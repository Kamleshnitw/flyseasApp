import 'dart:convert';

OrderDetailResponse orderDetailResponseFromJson(String str) => OrderDetailResponse.fromJson(json.decode(str));

String orderDetailResponseToJson(OrderDetailResponse data) => json.encode(data.toJson());

class OrderDetailResponse {
  OrderDetailResponse({
    required this.success,
    required this.orderDetail,
  });

  bool success;
  OrderDetail orderDetail;

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) => OrderDetailResponse(
    success: json["success"],
    orderDetail: OrderDetail.fromJson(json["order_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "order_detail": orderDetail.toJson(),
  };
}

class OrderDetail {
  OrderDetail({
    required this.orderId,
    required this.productDetails,
    required this.totalAmount,
    required this.grandAmount,
    required this.orderStatus,
    required this.paymentStatus,
    required this.createdAt,
    required this.orderTime,
    required this.invoice,
    required this.trackOrder,
    required this.productList,
  });

  String orderId;
  String productDetails;
  String totalAmount;
  String grandAmount;
  String orderStatus;
  String paymentStatus;
  String createdAt;
  dynamic orderTime;
  String invoice;
  List<dynamic> trackOrder;
  List<ProductDetail> productList;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    orderId: json["order_id"],
    productDetails: json["product_details"],
    totalAmount: json["total_amount"],
    grandAmount: json["grand_amount"],
    orderStatus: json["order_status"],
    paymentStatus: json["payment_status"],
    createdAt: json["created_at"],
    orderTime: json["order_time"],
    invoice: json["invoice"],
    trackOrder: List<dynamic>.from(json["order_history"].map((x) => x)),
    productList: List<ProductDetail>.from(json["product_list"].map((x) => ProductDetail.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "product_details": productDetails,
    "grand_amount": grandAmount,
    "order_status": orderStatus,
    "payment_status": paymentStatus,
    "created_at": createdAt,
    "order_time": orderTime,
    "invoice": invoice,
    "order_history": List<dynamic>.from(trackOrder.map((x) => x)),
    "product_list": List<dynamic>.from(productList.map((x) => x.toJson())),
  };
}

class ProductDetail {
  ProductDetail({
    required this.productId,
    required this.productName,
    required this.thumbnail,
    required this.quantity,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.mrpPrice,
    //required this.discountPrice,
    //required this.discountType,
    required this.status,
  });

  int productId;
  String productName;
  String thumbnail;
  int quantity;
  String purchasePrice;
  String sellingPrice;
  String mrpPrice;
  //String discountPrice;
  //String discountType;
  dynamic status;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    productId: json["product_id"],
    productName: json["product_name"],
    thumbnail: json["thumbnail"],
    quantity: json["quantity"],
    purchasePrice: json["purchase_price"],
    sellingPrice: json["selling_price"],
    mrpPrice: json["mrp_price"],
    //discountPrice: json["discount_price"],
    //discountType: json["discount_type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "thumbnail": thumbnail,
    "quantity": quantity,
    "purchase_price": purchasePrice,
    "selling_price": sellingPrice,
    "mrp_price": mrpPrice,
    //"discount_price": discountPrice,
    //"discount_type": discountType,
    "status": status,
  };
}

