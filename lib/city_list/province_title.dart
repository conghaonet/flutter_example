import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/city_list/entity.dart';

class ProvinceTitle extends StatelessWidget {
  final ProvinceEntity provinceEntity;
  ProvinceTitle(this.provinceEntity);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey,
      child: Text('省 -- ${provinceEntity.name} - ${provinceEntity.code}'),
    );
  }

}