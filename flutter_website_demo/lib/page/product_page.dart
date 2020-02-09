import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'dart:convert';
import '../model/product.dart';
import '../service/http_service.dart';
import '../service/api.dart';
import '../provider/product_provider.dart';
import '../style/index.dart';
import '../router/application.dart';

class ProductPage extends StatefulWidget {
  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  GlobalKey<RefreshFooterState> footerKey = GlobalKey<RefreshFooterState>();
  // 滑动控制
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getProductList(false);
  }

  void getProductList(bool isMore) async {
    var value = await request(Api.getProducts, formData: {});
    var data = json.decode(value.toString());
    ProductListModel productList = ProductListModel.fromJson(data);
    if(productList.data == null) {
      Provider.of<ProductProvider>(context).getProductList([]);
    } else {
      if(isMore) {
        Provider.of<ProductProvider>(context).addProductList(productList.data);
      } else {
        Provider.of<ProductProvider>(context).getProductList(productList.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (BuildContext context, ProductProvider productProvider, Widget child) {
        List<ProductModel> productList = productProvider.productList;
        if(productList.length > 0) {
          return Container(
            child: EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: footerKey,
                bgColor: Colors.white,
                textColor: Color.fromRGBO(132, 95, 63, 1),
                moreInfoColor: Color.fromRGBO(132, 95, 63, 1),
                showMore: true,
                noMoreText: '加载更多',
                moreInfo: '加载中',
                loadReadyText: '上拉加载',
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return listWiget(productList[index]);
                },
              ),
              loadMore: () async {
                getProductList(true);
              },
            ),
          );
        } else {
          return Text('暂时没有数据');
        }
      },
    );
  }

  Widget listWiget(ProductModel item) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
          context, 
          '/detail?productId=${item.productId}', 
          transition: TransitionType.fadeIn
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: ProductColors.bgColor,
          border: Border(bottom: BorderSide(width: 1, color: ProductColors.divideLineColor))
        ),
        child: Row(
          children: <Widget>[
            Image.network(item.imageUrl, width: 120, height: 120),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 5),
                        Text(
                          item.type,
                          style: TextStyle(fontSize: 16, color: ProductColors.typeColor),
                        ),
                        item.point == null ? SizedBox() : Container(
                          child: Text(
                            item.point,
                            style: TextStyle(color: ProductColors.pointColor),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          margin: EdgeInsets.only(left: 4),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: ProductColors.pointColor)
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(item.name, style: ProductFonts.itemNameStype),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}