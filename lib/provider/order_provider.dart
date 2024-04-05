import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flyseas/data/model/base/response_model.dart';
import 'package:flyseas/data/model/response/coupon_list_response.dart';
import 'package:flyseas/data/model/response/order_detail_response.dart';
import 'package:flyseas/data/model/response/order_list_response.dart';

import '../data/model/base/api_response.dart';
import '../repository/order_repo.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepo orderRepo;
  OrderProvider({required this.orderRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<CouponList> couponList = [];

  Future getCouponList() async{
    ApiResponse apiResponse = await orderRepo.getCouponList();
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      var couponResp = CouponListResponse.fromJson(apiResponse.response?.data);
      couponList.clear();
      couponList.addAll(couponResp.couponList);
      print(apiResponse.response);
      notifyListeners();
    }
    else{
      print(apiResponse.error.toString());
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = "Error While Checking";
      }
    }
  }

  var couponDiscount = 0;
  var appliedCouponCode = "";

  void removeCoupon(){
    couponDiscount = 0;
    appliedCouponCode = "";
    notifyListeners();
  }

  Future applyCoupon(String couponCode) async{
    ApiResponse apiResponse = await orderRepo.applyCoupon(couponCode);
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      print(apiResponse.response?.data);
      couponDiscount = apiResponse.response?.data['amount'];
      appliedCouponCode = couponCode;
      notifyListeners();
    }
    else{
      print(apiResponse.error.toString());
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = "Error While Checking";
      }
    }
  }

  Future<ResponseModel> placeBakeryOrder(Map<String,dynamic> orderData) async{
    ResponseModel responseModel = ResponseModel("_message", false);
    ApiResponse apiResponse = await orderRepo.placeBakeryOrder(orderData);
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      responseModel = ResponseModel("${apiResponse.response?.data['message']} With Order Id ${apiResponse.response?.data['order_id']}", true);
      notifyListeners();
    }
    else{
      print(apiResponse.error.toString());
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        Map map = jsonDecode(apiResponse.error.toString());
        errorMessage = map['message'] ?? "Something Went Wrong";
      }
      responseModel = ResponseModel(errorMessage, false);
    }
    return responseModel;
  }


  Future<ResponseModel> initOnlinePayment(Map<String,dynamic> orderData) async{
    ResponseModel responseModel = ResponseModel("_message", false);
    ApiResponse apiResponse = await orderRepo.getOnlinePaymentUrl(orderData);
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response?.data['url'] ?? "", true);
      notifyListeners();
    }
    else{
      print(apiResponse.error.toString());
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        Map map = jsonDecode(apiResponse.error.toString());
        errorMessage = map['message'] ?? "Something Went Wrong";
      }
      responseModel = ResponseModel(errorMessage, false);
    }
    return responseModel;
  }


  List<OrderList> orderListData = [];
  bool _isOrderLoading = false;
  bool get isOrderLoading => _isOrderLoading;
  Future getOrderList() async{
    _isOrderLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await orderRepo.getOrderList();
    _isOrderLoading = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      var orderListResp = OrderListResponse.fromJson(apiResponse.response?.data);
      orderListData.clear();
      orderListData.addAll(orderListResp.orderList.reversed);
      notifyListeners();
    }
    else{
      print(apiResponse.error.toString());
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = "Error While Checking";
      }
    }
  }


  bool isOrderDetailLoading = false;
  OrderDetailResponse? orderDetailResponse;
  var totalAmount = 0.0;
  var discountAmount = 0.0;
  var discount = 0.0;
  Future getOrderDetail(String orderId) async{
    isOrderDetailLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await orderRepo.getOrderDetail(orderId);
    isOrderDetailLoading = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      orderDetailResponse = OrderDetailResponse.fromJson(apiResponse.response?.data);
      totalAmount = 0.0;
      discountAmount = 0.0;
      discount = 0.0;
      if(orderDetailResponse!=null){
        for(var element in orderDetailResponse!.orderDetail.productList){
          totalAmount+= element.quantity*double.parse(element.mrpPrice);
          discountAmount+= element.quantity*double.parse(element.sellingPrice);
        }
        discount = totalAmount-discountAmount;
      }
      notifyListeners();
    }
    else{
      print(apiResponse.error.toString());
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = "Error While Checking";
      }
    }
  }





}