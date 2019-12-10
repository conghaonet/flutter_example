import 'package:flutter/material.dart';

void main() => (runApp(ListDemo()));

class ListDemo extends StatefulWidget {
  @override
  _ListDemoState createState() => _ListDemoState();
}

class _ListDemoState extends State<ListDemo> {
  var id = 500;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return _buildItem(index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 8,
                  color: Colors.transparent,
                );
              },
              itemCount: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Image.network(
          'https://picsum.photos/id/${id + index}/300/100',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
