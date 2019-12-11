
import 'package:flutter/material.dart';

class ListFooter extends StatelessWidget {
  final String text;
  ListFooter(this.text, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Center(
        child: Text(
          this.text,
          style: TextStyle(color: Colors.red, fontSize: 14,),
        ),
      ),
    );
  }

}