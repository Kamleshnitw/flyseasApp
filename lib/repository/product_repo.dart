import 'package:dio/dio.dart';
import 'package:flyseas/data/datasource/remote/dio/dio_client.dart';

import '../data/datasource/remote/exception/api_error_handler.dart';
import '../data/model/base/api_response.dart';
import '../util/app_constants.dart';

class ProductRepo {
  final DioClient dioClient;
  ProductRepo({required this.dioClient});

  Future<ApiResponse> getProductOfCategory(int categoryId) async {
    try {
      Response response = await dioClient.get(
        "${AppConstants.getProductByCategoryUri}$categoryId}",
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getProductList() async {
    try {
      Response response = await dioClient.get(
        AppConstants.getAllProductUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }

  Future<ApiResponse> getProductDescription(int productId) async {
    try {
      Response response = await dioClient.get(
        "${AppConstants.getProductDescriptionUri}$productId",
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }

  Future<ApiResponse> getCartList() async {
    try {
      Response response = await dioClient.get(AppConstants.getCartUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }

  Future<ApiResponse> addToCart(int productId,int quantity,String combinationName) async {
    try {
      Response response = await dioClient.post(
        AppConstants.addToCartUri,queryParameters: {"product_id":productId,"quantity":quantity,"combination_name" : combinationName}
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }

  Future<ApiResponse> updateCart(int productId,int quantity,String combinationName) async {
    try {
      Response response = await dioClient.post(
        AppConstants.updateCartUri,queryParameters: {"product_id":productId,"quantity":quantity,"combination_name": combinationName}
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }

  Future<ApiResponse> deleteCart(int productId,String combinationName) async {
    try {
      Response response = await dioClient.post(
        AppConstants.removeCartUri,queryParameters: {"product_id":productId,"combination_name": combinationName}
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }


}