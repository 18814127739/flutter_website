import 'package:flutter/material.dart';
import '../model/product.dart';

// 产品数据处理
class ProductProvider with ChangeNotifier {
  List<ProductModel> productList = [];

  getProductList(List<ProductModel> list) {
    productList = list;
    notifyListeners();
  }
  // 追加列表数据
  addProductList(List<ProductModel> list) {
    productList.addAll(list);
    notifyListeners();
  }
}