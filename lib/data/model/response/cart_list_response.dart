import 'dart:convert';

CartListResponse cartListResponseFromJson(String str) => CartListResponse.fromJson(json.decode(str));

String cartListResponseToJson(CartListResponse data) => json.encode(data.toJson());

class CartListResponse {
  CartListResponse({
    required this.success,
    required this.cartList,
  });

  bool success;
  List<CartList> cartList;

  factory CartListResponse.fromJson(Map<String, dynamic> json) => CartListResponse(
    success: json["success"],
    cartList: List<CartList>.from(json["cart_list"].map((x) => CartList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "cart_list": List<dynamic>.from(cartList.map((x) => x.toJson())),
  };
}

class CartList {
  CartList({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.productName,
    required this.thumbnail,
    required this.combinationName,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.discountPrice,
    required this.discountType,
    required this.mrpPrice,
    required this.gst,
    required this.hsnCode,
  });

  int id;
  int productId;
  int quantity;
  String productName;
  String thumbnail;
  String combinationName;
  String purchasePrice;
  String sellingPrice;
  String discountPrice;
  String discountType;
  String mrpPrice;
  dynamic gst;
  dynamic hsnCode;

  factory CartList.fromJson(Map<String, dynamic> json) => CartList(
    id: json["id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    productName: json["product_name"],
    thumbnail: json["thumbnail"],
    combinationName: json["combination_name"],
    purchasePrice: json["purchase_price"],
    sellingPrice: json["selling_price"],
    discountPrice: json["discount_price"] ?? "",
    discountType: json["discount_type"] ?? "",
    mrpPrice: json["mrp_price"],
    gst: json["gst"],
    hsnCode: json["hsn_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "quantity": quantity,
    "product_name": productName,
    "thumbnail": thumbnail,
    "combination_name": combinationName,
    "purchase_price": purchasePrice,
    "selling_price": sellingPrice,
    "discount_price": discountPrice,
    "discount_type": discountType,
    "mrp_price": mrpPrice,
    "gst": gst,
    "hsn_code": hsnCode,
  };
}

