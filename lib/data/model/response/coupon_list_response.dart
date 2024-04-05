import 'dart:convert';

CouponListResponse couponListResponseFromJson(String str) => CouponListResponse.fromJson(json.decode(str));

String couponListResponseToJson(CouponListResponse data) => json.encode(data.toJson());

class CouponListResponse {
  CouponListResponse({
    required this.success,
    required this.couponList,
  });

  bool success;
  List<CouponList> couponList;

  factory CouponListResponse.fromJson(Map<String, dynamic> json) => CouponListResponse(
    success: json["success"],
    couponList: List<CouponList>.from(json["coupon_list"].map((x) => CouponList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "coupon_list": List<dynamic>.from(couponList.map((x) => x.toJson())),
  };
}

class CouponList {
  CouponList({
    required this.id,
    required this.banner,
    required this.couponName,
    required this.usesType,
    required this.discountType,
    required this.discount,
    required this.minimumOrderAmount,
    required this.startDate,
    required this.endDate,
    required this.shortDescription,
    required this.termsConditions,
  });

  int id;
  String banner;
  String couponName;
  String usesType;
  String discountType;
  String discount;
  dynamic minimumOrderAmount;
  String startDate;
  String endDate;
  String shortDescription;
  String termsConditions;

  factory CouponList.fromJson(Map<String, dynamic> json) => CouponList(
    id: json["id"],
    banner: json["banner"],
    couponName: json["coupon_name"],
    usesType: json["uses_type"],
    discountType: json["discount_type"],
    discount: json["discount"],
    minimumOrderAmount: json["minimum_order_amount"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    shortDescription: json["short_description"],
    termsConditions: json["terms_conditions"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "banner": banner,
    "coupon_name": couponName,
    "uses_type": usesType,
    "discount_type": discountType,
    "discount": discount,
    "minimum_order_amount": minimumOrderAmount,
    "start_date": startDate,
    "end_date": endDate,
    "short_description": shortDescription,
    "terms_conditions": termsConditions,
  };
}
