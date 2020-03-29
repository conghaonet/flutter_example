import 'package:flutter/cupertino.dart';

class ProvinceNotifier extends ChangeNotifier {
  int _provinceIndex = 0;

  int get provinceIndex => _provinceIndex;

  void updateProvince(int index) {
    if(_provinceIndex != index) {
      _provinceIndex = index;
      notifyListeners();
    }
  }

}