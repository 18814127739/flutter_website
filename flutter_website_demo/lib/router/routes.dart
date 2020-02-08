import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'router_handler.dart';

class Routes {
  // 跟路径
  static String root = '/';
  // 产品详情路径
  static String detailsPage = '/detail';
  // 配置路由
  static void configureRoutes(Router router) {
    // 路径没找到handler
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('error::: router 没有找到');
      }
    );
    // 定义产品详情路由handler
    router.define(detailsPage, handler: detailsHandler);
    // 定义跟路由handler
    router.define(root, handler: rootHandler);
  }
}