class ProductListModel {
  String code;
  String message;
  List<ProductModel> data;

  ProductListModel(this.data);

  ProductListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if(json['data'] != null) {
      data = List<ProductModel>();
      json['data'].forEach((v) {
        data.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class ProductModel {
  String productId;
  String name;
  String desc;
  String type;
  String imageUrl;
  String point;
  // 通过传入json数据转换成数据模型
  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    name = json['name'];
    desc = json['desc'];
    type = json['type'];
    imageUrl = json['imageUrl'];
    point = json['point'];
  }
  // 将数据模型转换成json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['productId'] = this.productId;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['type'] = this.type;
    data['imageUrl'] = this.imageUrl;
    data['point'] = this.point;
    return data;
  }
}
