
import 'package:flutter/cupertino.dart';
import 'package:flutter_example/city_list/entity.dart';

class AreaItem extends StatelessWidget {
  final AreaEntity area;
  final int index;
  AreaItem({this.area, this.index, Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text('---- 县 -- $index - ${area.name}');
  }

}