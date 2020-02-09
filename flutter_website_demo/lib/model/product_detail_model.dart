class ProductDetailModel {
  String code;
  String message;
  ProductDetail data;

  ProductDetailModel(this.data);

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if(json['data'] != null) {
      data = ProductDetail.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if(this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ProductDetail {
  String productId;
  String desc;
  String type;
  String name;
  String imageUrl;
  String point;
  String productDetail;

  ProductDetail({this.productId, this.desc, this.type, this.name, this.imageUrl, this.point, this.productDetail});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    desc = json['desc'];
    type = json['type'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    point = json['point'];
    productDetail = json['productDetail'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['productId'] = this.productId;
    data['desc'] = this.desc;
    data['type'] = this.type;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['point'] = this.point;
    data['productDetail'] = this.productDetail;
    return data;
  }
}