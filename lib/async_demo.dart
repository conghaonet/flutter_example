import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AsyncDemo',
      home: AsyncDemo(),
    );
  }

}

class AsyncDemo extends StatefulWidget {
  @override
  _AsyncDemoState createState() => _AsyncDemoState();
}

class _AsyncDemoState extends State<AsyncDemo> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            FlatButton(
              onPressed: () async {
                _count = countEven(1000000000);
//                _count = await compute(countEven, 1000000000);
//                _count = await isolateCountEven(1000000000);
                Fluttertoast.showToast(msg: _count.toString());

                setState(() {});
              },
              child: Text(_count.toString()),),
          ],
        ),
      ),
    );
  }

  static int countEven(int num) {
    int count = 0;
    while (num > 0) {
      if (num % 2 == 0) {
        count++;
      }
      num--;
    }
    return count;
  }

  static Future<dynamic> isolateCountEven(int num) async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(countEven2, receivePort.sendPort);
    SendPort sendPort = await receivePort.first as SendPort;
    receivePort.close();
    final response = ReceivePort();
    sendPort.send([response.sendPort, num]);
    return response.first;
  }

  static void countEven2(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    receivePort.listen((message) {
      receivePort.close();
      final send = message[0] as SendPort;
      final n = message[1] as int;
      send.send(countEven(n));
    });
  }
}