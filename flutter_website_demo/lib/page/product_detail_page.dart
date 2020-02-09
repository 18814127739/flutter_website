import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import '../model/product_detail_model.dart';
import '../provider/product_detail_provider.dart';
import '../service/api.dart';
import '../service/http_service.dart';

class ProductDetailPage extends StatefulWidget {

  final String productId;

  ProductDetailPage(this.productId);

  @override
  ProductDetailPageState createState() => ProductDetailPageState();
}

class ProductDetailPageState extends State<ProductDetailPage> {

  @override
  void initState() {
    super.initState();
    getProductDetail();
  }

  getProductDetail() async {
    var params = {
      "productId": widget.productId,
    };
    var res = await request(Api.getProductDetail, formData: params);
    var data = json.decode(res.toString());
    // print('产品详情: ${data.toString()}');
    ProductDetailModel productDetailData = ProductDetailModel.fromJson(data);
    if(productDetailData.data != null) {
      Provider.of<ProductDetailProvider>(context).getProductDetail(productDetailData.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailProvider>(
      builder: (BuildContext context, ProductDetailProvider productDetailProvider, Widget child) {
        // 获取产品详情
        ProductDetail detail = productDetailProvider.productDetail;
          return Scaffold(
            appBar: AppBar(
              title: Text('产品详情'),
            ),
            body: detail != null ? ListView(
              children: <Widget>[
                Html(
                  data: detail.productDetail,
                ),
              ],
            ) : Center(),
          );
      },
    );

    // 方式2: 不使用Consumer, 直接通过 Provider.of<ProductDetailProvider>(context) 获取productDetail数据进行渲染
    // ProductDetail detail = Provider.of<ProductDetailProvider>(context).productDetail;
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('产品详情'),
    //   ),
    //   body: detail != null ? ListView(
    //     children: <Widget>[
    //       Html(
    //         data: detail.productDetail,
    //       ),
    //     ],
    //   ) : Center(),
    // );
  }
}