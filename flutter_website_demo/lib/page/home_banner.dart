import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeBanner extends StatelessWidget {
  List<String> imgs = <String>[
    'assets/images/banners/1.jpeg',
    'assets/images/banners/2.jpeg',
    'assets/images/banners/3.jpeg',
    'assets/images/banners/4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    // 计算宽高
    double width = MediaQuery.of(context).size.width;
    double height = width * 540.0 / 1080.0;

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
      // 轮播组件
      child: Swiper(
        // 轮播项构造器
        itemBuilder: (BuildContext context, index) {
          return Image.asset(
              imgs[index],
              width: width,
              height: height,
              //填充模式
              fit: BoxFit.cover, 
          );
        },
        itemCount: imgs.length,
        scrollDirection: Axis.horizontal,
        autoplay: true,
      ),
    );
  }
}
