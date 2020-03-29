import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/city_list/province_notifier.dart';
import 'package:provider/provider.dart';

import 'cities.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ProvinceNotifier>(create: (_) => ProvinceNotifier()),
    ],
    child: CityApp(),
  ));
//  runApp(CityApp());
}

class CityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '城市列表',
      home: CityHome(),
    );
  }
  
}

class CityHome extends StatefulWidget {
  @override
  _CityHomeState createState() => _CityHomeState();
}

class _CityHomeState extends State<CityHome> {
  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    //预加载数据
    await DefaultAssetBundle.of(context).loadString('assets/city_code.json');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CityHome'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('城市列表'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Cities();
//                return ChangeNotifierProvider(
//                  create: (_) => new ProvinceNotifier(),
//                  child: Cities(),
//                );
              })),
            ),
          ],
        ),
      ),
    );
  }
}