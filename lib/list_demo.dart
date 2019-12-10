import 'package:flutter/material.dart';

void main() =>(runApp(ListDemo()));

class ListDemo extends StatefulWidget {
  @override
  _ListDemoState createState() => _ListDemoState();
}

class _ListDemoState extends State<ListDemo> {
  @override
  Widget build(BuildContext context) {
    var id = 500;
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Image.network('https://picsum.photos/id/${id++}/300/100'),
              );
            },
          ),
        ),
      ),
    );
  }
}