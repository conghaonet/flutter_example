import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/city_list/app_event_bus.dart';
import 'package:flutter_example/city_list/entity.dart';
import 'package:flutter_example/city_list/province_event.dart';
import 'package:flutter_example/city_list/province_item.dart';
import 'package:flutter_example/city_list/province_notifier.dart';
import 'package:flutter_example/city_list/province_title.dart';
import 'package:provider/provider.dart';

class Cities extends StatefulWidget {
  @override
  _CitiesState createState() => _CitiesState();
}

/// 使用隔离序列化可避免UI阻塞，但是会耗费更多内存资源和时间。
List<ProvinceEntity> parseJson(String strJson) {
  print('parseJson start>>>> ' + DateTime.now().toString());
  List<dynamic> listDynamic = jsonDecode(strJson);
  List<ProvinceEntity> provinces = listDynamic.map((js) => ProvinceEntity.fromJson(js)).toList();
  print('parseJson end<<<< ' + DateTime.now().toString());
  return provinces;
}

class _CitiesState extends State<Cities> {
  List<ProvinceEntity> provinces = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    print('start>>>> ' + DateTime.now().toString());
    String strJson = await DefaultAssetBundle.of(context).loadString('assets/city_code.json');
//    List<ProvinceEntity> provinces = await compute(parseJson, strJson);
    List<dynamic> listDynamic = jsonDecode(strJson);
    provinces = listDynamic.map((js) => ProvinceEntity.fromJson(js)).toList();
    print('end<<<< ' + DateTime.now().toString());
    eventBus.on<ProvinceEvent>().listen((event) {
      Provider.of<ProvinceNotifier>(context, listen: false).updateProvince(event.provinceIndex);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('列表'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 18, color: Colors.black),
            child: Stack(
              children: <Widget>[
                ListView.custom(
                  physics: ClampingScrollPhysics(),
                  cacheExtent: 0.0,
                  childrenDelegate: ProvinceDelegate(
                    (context, index) {
                      return ProvinceItem(
                        province: provinces[index],
                        index: index,
                        key: ValueKey<ProvinceEntity>(provinces[index]),
                      );
                    },
                    childCount: provinces.length,
                    findChildIndexCallback: (Key key) {
                      final ValueKey valueKey = key;
                      final ProvinceEntity data = valueKey.value;
                      final index = provinces.indexOf(data);
                      return index;
                    },
                  ),
                ),
                if(provinces.isNotEmpty)
                  Consumer<ProvinceNotifier>(
                    builder: (_, province, __) {
                      return InkWell(
                        onTap: () {
                          provinces[province.provinceIndex].hidden = !provinces[province.provinceIndex].hidden;
                          setState(() {
                          });
                        },
                        child: ProvinceTitle(provinces[province.provinceIndex]),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProvinceDelegate extends SliverChildBuilderDelegate {
  ProvinceDelegate(
    IndexedWidgetBuilder builder, {
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
//    print('firstIndex=$firstIndex    lastIndex=$lastIndex');
    eventBus.fire(ProvinceEvent(firstIndex));
  }
}
