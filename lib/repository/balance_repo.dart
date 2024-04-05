import 'package:dio/dio.dart';

import '../data/datasource/remote/dio/dio_client.dart';
import '../data/datasource/remote/exception/api_error_handler.dart';
import '../data/model/base/api_response.dart';
import '../util/app_constants.dart';

class BalanceRepo{
  final DioClient dioClient;
  BalanceRepo({required this.dioClient});

  Future<ApiResponse> getWalletHistory() async {
    try {
      Response response = await dioClient.get(AppConstants.walletUri,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> rechargeWallet(String amount) async {
    try {
      Response response = await dioClient.post(AppConstants.rechargeWalletUri,data: {"amount": amount});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}