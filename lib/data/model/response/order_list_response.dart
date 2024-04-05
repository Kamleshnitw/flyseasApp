import 'dart:convert';

OrderListResponse orderListResponseFromJson(String str) => OrderListResponse.fromJson(json.decode(str));

String orderListResponseToJson(OrderListResponse data) => json.encode(data.toJson());

class OrderListResponse {
  OrderListResponse({
    required this.success,
    required this.orderList,
  });

  bool success;
  List<OrderList> orderList;

  factory OrderListResponse.fromJson(Map<String, dynamic> json) => OrderListResponse(
    success: json["success"],
    orderList: List<OrderList>.from(json["order_list"].map((x) => OrderList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "order_list": List<dynamic>.from(orderList.map((x) => x.toJson())),
  };
}

class OrderList {
  OrderList({
    required this.orderId,
    required this.productDetails,
    required this.totalAmount,
    required this.grandAmount,
    required this.orderStatus,
    required this.paymentStatus,
    required this.createdAt,
    required this.productCount,
    required this.orderTime,
  });

  String orderId;
  String productDetails;
  String totalAmount;
  String grandAmount;
  String orderStatus;
  String paymentStatus;
  String createdAt;
  int productCount;
  String orderTime;

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
    orderId: json["order_id"],
    productDetails: json["product_details"],
    totalAmount: json["total_amount"],
    grandAmount: json["grand_amount"],
    orderStatus: json["order_status"],
    paymentStatus: json["payment_status"],
    createdAt: json["created_at"],
    productCount: json["product_count"],
    orderTime: json["order_time"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "product_details": productDetails,
    "total_amount": totalAmount,
    "grand_amount": grandAmount,
    "order_status": orderStatus,
    "payment_status": paymentStatus,
    "created_at": createdAt,
    "product_count": productCount,
    "order_time": orderTime,
  };
}
