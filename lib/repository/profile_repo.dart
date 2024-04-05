import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flyseas/data/datasource/remote/dio/dio_client.dart';
import 'package:http/http.dart' as http;

import '../data/datasource/remote/exception/api_error_handler.dart';
import '../data/model/base/api_response.dart';
import '../util/app_constants.dart';

class ProfileRepo {
  final DioClient dioClient;
  ProfileRepo({required this.dioClient});

  Future<http.StreamedResponse> storeKycData(Map<String,String> fieldData,Map<String,String> docData,String bearerToken) async {
    var headers = {
      'Authorization': 'Bearer $bearerToken'
    };

    var request = http.MultipartRequest('POST',
        Uri.parse(AppConstants.baseURL + AppConstants.kycStoreUri)); // your server url
    request.fields.addAll(fieldData);

    // any other fields required by your server
    docData.forEach((key, value) {
      request.files.add(http.MultipartFile(key,
          File(value).readAsBytes().asStream(), File(value).lengthSync(),
          filename: value.split("/").last));
    });

    //request.files.add(await http.MultipartFile.fromPath('documnet', '${fileData.absolute}')); // file you want to upload
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;

  }

  Future<ApiResponse> getProfileDetail() async {
    try {
      Response response = await dioClient.get(AppConstants.profileUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> storeBankDetail(Map<String,String> bankDetails) async {
    try {
      Response response = await dioClient.post(AppConstants.bankDetailStoreUri,data: bankDetails);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateBankDetail(Map<String,String> bankDetails) async {
    try {
      Response response = await dioClient.post(AppConstants.bankDetailUpdateUri,data: bankDetails);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}