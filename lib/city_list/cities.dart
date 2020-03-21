import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/city_list/entity.dart';
import 'package:flutter_example/city_list/province_item.dart';

class Cities extends StatefulWidget {
  @override
  _CitiesState createState() => _CitiesState();
}

/// 使用隔离序列化可避免UI阻塞，但是会耗费更多内存资源和时间。
List<ProvinceEntity> parseJson(String strJson) {
  print('parseJson start>>>> '+DateTime.now().toString());
  List<dynamic> listDynamic = jsonDecode(strJson);
  List<ProvinceEntity> provinces = listDynamic.map((js) =>ProvinceEntity.fromJson(js)).toList();
  print('parseJson end<<<< '+DateTime.now().toString());
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
    print('start>>>> '+DateTime.now().toString());
    String strJson = await DefaultAssetBundle.of(context).loadString('assets/city_code.json');
//    List<ProvinceEntity> provinces = await compute(parseJson, strJson);
    List<dynamic> listDynamic = jsonDecode(strJson);
    provinces = listDynamic.map((js) =>ProvinceEntity.fromJson(js)).toList();
    print('end<<<< '+DateTime.now().toString());
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('列表'),
      ),
      body: SafeArea(
        child: Container(
          child: ListView.custom(
            itemExtent: 120,
            cacheExtent: 0.0,
            childrenDelegate: SliverChildBuilderDelegate((context, index) {
                return ProvinceItem(
                  province: provinces[index],
                  index: index,
                  key: ValueKey<ProvinceEntity>(provinces[index]),
                );
              },
              childCount: provinces.length,
              addRepaintBoundaries: false, //是否重新绘制边界，false时可能会提高性能。
              findChildIndexCallback: (Key key) {
                  final ValueKey valueKey = key;
                  final ProvinceEntity data = valueKey.value;
                  final index = provinces.indexOf(data);
                  return index;
              },

            ),
          ),
        ),
      ),
    );
  }
}
