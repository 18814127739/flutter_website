import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../model/product.dart';
import '../utils/utils.dart';
import '../provider/product_provider.dart';
import '../service/http_service.dart';
import '../service/api.dart';
import '../router/application.dart';

class HomeProductPage extends StatefulWidget {
  @override
  HomeProductPageState createState() => HomeProductPageState();
}

class HomeProductPageState extends State<HomeProductPage> {
  @override
  void initState() {
    super.initState();
    getProductList();
  }

  void getProductList() async {
    await request(Api.getProducts, formData: {}).then((value) {
      print('接口返回数据');
      print(value);
      var data = json.decode(value.toString());
      print('产品列表数据json格式:::${data.toString()}');
      // 将json转换成ProductListModel
      ProductListModel productList = ProductListModel.fromJson(data);
      // 将数据放入ProductProvider
      if(productList.data == null) {
        Provider.of<ProductProvider>(context).getProductList([]);
      } else {
        Provider.of<ProductProvider>(context).getProductList(productList.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 设备宽度
    double deviceWidth = MediaQuery.of(context).size.width;
    // 使用Consumer获取ProductProvider对象
    return Consumer<ProductProvider>(
      builder: (BuildContext context, ProductProvider productProvider, Widget child) {
        // 获取产品列表数据
        List<ProductModel> productList = productProvider.productList;
        return Container(
          width: deviceWidth,
          color: Colors.white,
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 7.5),
          child: buildProductList(context, deviceWidth, productList),
        );
      }
    );
  }

  // 返回标题和列表
  Widget buildProductList(BuildContext context, double deviceWidth, List<ProductModel> productList) {
    // Item宽度
    double itemWidth = deviceWidth * 168.5 / 360;
    double imageWidth = deviceWidth * 110.0 / 360;

    // 返回产品列表
    List<Widget> listWidgets = productList.map((item) {
      Color bgColor = string2Color('#f8f8f8');
      Color titleColor = string2Color('#db5d41');
      Color subTitleColor = string2Color('#999999');

      return InkWell(
        onTap: () {
          // 路由跳转至产品详情页
          Application.router.navigateTo(context, '/detail?productId=${item.productId}');
        },
        child: Container(
          width: itemWidth,
          margin: EdgeInsets.only(bottom: 5, left: 2),
          padding: EdgeInsets.only(top: 10, left: 13, bottom: 7),
          color: bgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, color: titleColor),
              ),
              Text(
                item.desc,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, color: subTitleColor),
              ),
              Container(
                alignment: Alignment(0, 0),
                margin: EdgeInsets.only(top: 5),
                child: Image.network(
                  item.imageUrl,
                  width: imageWidth,
                  height: imageWidth,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 5, bottom: 10),
          child: Text(
            '最新产品',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(51, 51, 51, 1),
            )
          ),
        ),
        Wrap(
          spacing: 2,
          children: listWidgets,
        )
      ],
    );
  }
}