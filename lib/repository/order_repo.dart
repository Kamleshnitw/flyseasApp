import 'package:dio/dio.dart';

import '../data/datasource/remote/dio/dio_client.dart';
import '../data/datasource/remote/exception/api_error_handler.dart';
import '../data/model/base/api_response.dart';
import '../util/app_constants.dart';

class OrderRepo {
  final DioClient dioClient;
  OrderRepo({required this.dioClient});

  Future<ApiResponse> getCouponList() async {
    try {
      Response response = await dioClient.get(AppConstants.getCouponListUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> applyCoupon(String couponCode) async {
    try {
      Response response = await dioClient.get(AppConstants.applyCouponUri,queryParameters: {"coupon_name": couponCode});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> placeBakeryOrder(Map<String,dynamic> orderData) async {
    try {
      Response response = await dioClient.post(AppConstants.orderStoreUri,data: orderData
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOnlinePaymentUrl(Map<String,dynamic> orderData) async {
    try {
      Response response = await dioClient.post(AppConstants.initPaymentUri,data: orderData
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getOrderList() async {
    try {
      Response response = await dioClient.get(AppConstants.orderListUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderDetail(String orderId) async {
    try {
      Response response = await dioClient.get(AppConstants.orderDetailUri+orderId,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}