import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cities.dart';

void main() {
  runApp(CityApp());
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
              })),
            ),
          ],
        ),
      ),
    );
  }
}