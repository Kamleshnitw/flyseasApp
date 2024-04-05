import 'package:flyseas/data/model/response/bakery_home_response.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

ProductListResponse productListResponseFromJson(String str) => ProductListResponse.fromJson(json.decode(str));

String productListResponseToJson(ProductListResponse data) => json.encode(data.toJson());

class ProductListResponse {
  ProductListResponse({
    required this.success,
    required this.productsList,
  });

  bool success;
  List<BakeryProduct> productsList;

  factory ProductListResponse.fromJson(Map<String, dynamic> json) => ProductListResponse(
    success: json["success"],
    productsList: List<BakeryProduct>.from(json["products_list"].map((x) => BakeryProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "products_list": List<dynamic>.from(productsList.map((x) => x.toJson())),
  };
}