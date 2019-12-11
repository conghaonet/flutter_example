import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
                _count = await compute(countEven, 1000000000);
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
}