import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'loading.dart';
import './provider/current_index_provider.dart';
import './provider/product_provider.dart';
import './provider/product_detail_provider.dart';
import './provider/websocket_provider.dart';
import './router/application.dart';
import './router/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 实例化路由
    final router = Router();
    // 配置路由
    Routes.configureRoutes(router);
    // 将路由设置成整个应用可以调用 
    Application.router = router;

    // 管理多个共享数据类
    return MultiProvider(
      providers: [
        // 底部导航页切换
        ChangeNotifierProvider(builder: (_) => CurrentIndexProvider()),
        // 获取产品数据
        ChangeNotifierProvider(builder: (_) => ProductProvider()),
        // 获取产品详情数据
        ChangeNotifierProvider(builder: (_) => ProductDetailProvider()),
        // WebSocket连接及收发消息
        ChangeNotifierProvider(builder: (_) => WebSocketProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter企业站实践',
        // 生成路由的回调函数, 当导航到目标路由时, 会使用这个来生成页面
        onGenerateRoute: Application.router.generator,
        // 自定义主题
        theme: ThemeData(
          primaryColor: Colors.redAccent,
        ),
        // 指定加载页面
        home: LoadingPage(),
      ),
    );
  }
}
