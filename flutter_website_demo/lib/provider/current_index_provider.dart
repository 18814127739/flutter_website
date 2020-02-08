import 'package:flutter/material.dart';

class CurrentIndexProvider with ChangeNotifier {
  int currentIndex = 0;
  // 切换页面索引
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}