import 'package:flutter/material.dart';
import 'home_banner.dart';
import 'home_product_page.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          HomeBanner(),
          HomeProductPage(),
        ],
      ),
    );
  }
}