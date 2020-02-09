import 'package:flutter/material.dart';
import '../model/product_detail_model.dart';

class ProductDetailProvider with ChangeNotifier {
  // 产品详情
  ProductDetail productDetail;

  void getProductDetail(ProductDetail detail) {
    productDetail = detail;
    notifyListeners();
  }
}