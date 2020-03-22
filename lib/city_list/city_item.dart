import 'package:flutter/cupertino.dart';
import 'package:flutter_example/city_list/entity.dart';

import 'area_item.dart';

class CityItem extends StatefulWidget {
  final CityEntity city;
  final int index;
  CityItem({this.city, this.index, Key key}): super(key: key);
  @override
  _CityItemState createState() => _CityItemState();
}

class _CityItemState extends State<CityItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('-- 市 -- ${widget.index} - ${widget.city.name}'),
        ListView.custom(
          itemExtent: 28,
          primary: false,
          shrinkWrap: true,
          childrenDelegate: SliverChildBuilderDelegate((context, index) {
            return AreaItem(
              area: widget.city.area[index],
              index: index,
              key: ValueKey<AreaEntity>(widget.city.area[index]),
            );},
            childCount: widget.city.area?.length ?? 0,
            addRepaintBoundaries: false, //是否重新绘制边界，false时可能会提高性能。
            findChildIndexCallback: (Key key) {
              final ValueKey valueKey = key;
              final AreaEntity data = valueKey.value;
              final index = widget.city.area.indexOf(data);
              return index;
            },
          ),
        ),
      ],
    );
  }
}