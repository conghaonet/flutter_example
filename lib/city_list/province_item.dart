import 'package:flutter/cupertino.dart';
import 'package:flutter_example/city_list/entity.dart';

class ProvinceItem extends StatefulWidget {
  final ProvinceEntity province;
  final int index;
  ProvinceItem({this.province, this.index, Key key}): super(key: key);
  @override
  _ProvinceItemState createState() => _ProvinceItemState();
}

class _ProvinceItemState extends State<ProvinceItem> {
  @override
  Widget build(BuildContext context) {
    return Text('${widget.index} - ${widget.province.name}');
  }
}