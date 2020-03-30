import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/city_list/city_item.dart';
import 'package:flutter_example/city_list/entity.dart';
import 'package:flutter_example/city_list/province_notifier.dart';
import 'package:flutter_example/city_list/province_title.dart';
import 'package:provider/provider.dart';

class ProvinceItem extends StatefulWidget {
  final ProvinceEntity province;
  final int index;

  ProvinceItem({this.province, this.index, Key key}) : super(key: key);

  @override
  _ProvinceItemState createState() => _ProvinceItemState();
}

class _ProvinceItemState extends State<ProvinceItem> {
  bool _isHidden = false;
  @override
  Widget build(BuildContext context) {
//    return Text('${widget.index} - ${widget.province.name}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        InkWell(
          onTap: () {
            _isHidden = !_isHidden;
            widget.province.hidden = !(widget.province.hidden ?? false);
            setState(() {

            });
//            Provider.of<ProvinceNotifier>(context, listen: false).updateProvince(widget.index);
          },
          child: ProvinceTitle(widget.province),
        ),
        if(!(widget.province.hidden ?? false))
          ListView.custom(
            primary: false,
            shrinkWrap: true,
            cacheExtent: 0.0,
            childrenDelegate: SliverChildBuilderDelegate(
              (context, index) {
                return CityItem(
                  city: widget.province.city[index],
                  index: index,
                  key: ValueKey<CityEntity>(widget.province.city[index]),
                );
              },
              childCount: widget.province.city?.length ?? 0,
              addRepaintBoundaries: false, //是否重新绘制边界，false时可能会提高性能。
              findChildIndexCallback: (Key key) {
                final ValueKey valueKey = key;
                final CityEntity data = valueKey.value;
                final index = widget.province.city.indexOf(data);
                return index;
              },
            ),
          ),
      ],
    );
  }
}
