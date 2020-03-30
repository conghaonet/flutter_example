import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/city_list/entity.dart';

class CityTitle extends StatelessWidget {
  final CityEntity cityEntity;
  CityTitle(this.cityEntity);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.blue,
      child: Text(
        '-- 市 -- ${cityEntity.name} - ${cityEntity.code}',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

}