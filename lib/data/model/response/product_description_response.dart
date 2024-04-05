import 'package:flyseas/data/model/response/bakery_home_response.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

ProductDescriptionResponse productDescriptionResponseFromJson(String str) => ProductDescriptionResponse.fromJson(json.decode(str));

String productDescriptionResponseToJson(ProductDescriptionResponse data) => json.encode(data.toJson());

class ProductDescriptionResponse {
  ProductDescriptionResponse({
    required this.success,
    required this.productDescription,
    //required this.relatedProducts,
  });

  bool success;
  BakeryProduct productDescription;
  //List<BakeryProduct> relatedProducts;

  factory ProductDescriptionResponse.fromJson(Map<String, dynamic> json) => ProductDescriptionResponse(
    success: json["success"],
    productDescription: BakeryProduct.fromJson(json["product_description"]),
    //relatedProducts: List<BakeryProduct>.from(json["related_products"].map((x) => BakeryProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "product_description": productDescription.toJson(),
    //"related_products": List<dynamic>.from(relatedProducts.map((x) => x.toJson())),
  };
}