import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'product_page.dart';
import 'chat_page.dart';
import '../provider/current_index_provider.dart';
import '../provider/websocket_provider.dart';

class IndexPage extends StatefulWidget {
  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  HomePage homePage;
  ProductPage productPage;
  ChatPage chatPage;
  bool socketInited = false;

  currentPage() {
    int currentIndex = Provider.of<CurrentIndexProvider>(context).currentIndex;
    switch(currentIndex) {
      case 0:
        if(homePage == null) {
          homePage = HomePage();
        }
        return homePage;
      case 1:
        if(productPage == null) {
          productPage = ProductPage();
        }
        return productPage;
      case 2:
        if(chatPage == null) {
          chatPage = ChatPage();
        }
        return chatPage;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 初始化websocket
    if(!socketInited) {
      Provider.of<WebSocketProvider>(context).init();
      socketInited = true;
    }

    int currentIndex = Provider.of<CurrentIndexProvider>(context).currentIndex;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter企业站'),
        leading: Icon(Icons.home),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.search),
            )
          )
        ],
      ),
      body: currentPage(),
      bottomNavigationBar: BottomNavigationBar(
        // 通过fixedColor设置选中item的颜色
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          Provider.of<CurrentIndexProvider>(context).changeIndex(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text('产品')),
          BottomNavigationBarItem(icon: Icon(Icons.insert_comment), title: Text('联系我们')),
        ],
      ),
    );
  }
}
