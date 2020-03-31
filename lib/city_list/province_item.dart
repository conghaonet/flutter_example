import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/city_list/city_item.dart';
import 'package:flutter_example/city_list/entity.dart';
import 'package:flutter_example/city_list/province_title.dart';

class ProvinceItem extends StatefulWidget {
  final ProvinceEntity province;
  final int index;

  ProvinceItem({this.province, this.index, Key key}) : super(key: key);

  @override
  _ProvinceItemState createState() => _ProvinceItemState();
}

class _ProvinceItemState extends State<ProvinceItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        InkWell(
          onTap: () {
            widget.province.hidden = !(widget.province.hidden ?? false);
            setState(() {
            });
          },
          child: ProvinceTitle(widget.province),
        ),
        if(!(widget.province.hidden ?? false))
          ListView.custom(
            primary: false,
            shrinkWrap: true,
            cacheExtent: 0.0,
            childrenDelegate: CityDelegate(
              (context, index) {
                return CityItem(
                  city: widget.province.city[index],
                  index: index,
                  key: ValueKey<CityEntity>(widget.province.city[index]),
                );
              },
              provinceIndex: widget.index,
              childCount: widget.province.city?.length ?? 0,
              findChildIndexCallback: (Key key) {
                final ValueKey valueKey = key;
                final CityEntity data = valueKey.value;
                final index = widget.province.city.indexOf(data);
                return index;
              },
            ) ,
          ),
      ],
    );
  }
}

class CityDelegate extends SliverChildBuilderDelegate {
  final int provinceIndex;
  CityDelegate(
      IndexedWidgetBuilder builder, {
        this.provinceIndex,
        int childCount,
        ChildIndexGetter findChildIndexCallback,
      }) : super(
    builder,
    childCount: childCount,
    findChildIndexCallback: findChildIndexCallback,
    addAutomaticKeepAlives: true,
    addRepaintBoundaries: true, //是否重新绘制边界，false时可能会提高性能。
  );

  @override
  void didFinishLayout(int firstIndex, int lastIndex) {
    print('provinceIndex=$provinceIndex,  city firstIndex=$firstIndex  city lastIndex=$lastIndex');
  }
}