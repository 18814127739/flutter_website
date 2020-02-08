import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../page/index_page.dart';
import '../page/product_detail_page.dart';

// 根路由handler返回IndexPage页面
Handler rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return IndexPage();
  }
);

// 产品路由handler返回产品详情页面, 传入productId参数
Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String productId = params['productId'].first;
    return ProductDetailPage(productId);
  }
);