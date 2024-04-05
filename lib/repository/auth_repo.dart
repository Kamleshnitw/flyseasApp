import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasource/remote/dio/dio_client.dart';
import '../data/datasource/remote/exception/api_error_handler.dart';
import '../data/model/base/api_response.dart';
import '../util/app_constants.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.dioClient, required this.sharedPreferences});



  // for  user token
  Future<void> saveUserToken(String token) async {
    dioClient.updateHeader(token);

    try {
      await sharedPreferences.setString(AppConstants.token, token);
    } catch (e) {
      throw e;
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  //auth token
  // for  user token
  Future<void> saveAuthToken(String token) async {
    dioClient.token = token;
    dioClient.dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences.setString(AppConstants.token, token);
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> getCityList() async {
    try {
      Response response = await dioClient.get(
        AppConstants.getCityUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }


  Future<ApiResponse> verifyOTP(String phone, String otp) async {
    try {
      Response response = await dioClient.post(
        AppConstants.verifyOtpUri,
        data: jsonEncode({"phone":phone,"otp":otp}),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }

  Future<ApiResponse> loginWithPhone(Map<String,dynamic> login) async {
    try {
      Response response = await dioClient.post(
        AppConstants.loginUri,
        data: jsonEncode(login),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




  Future<ApiResponse> updateToken() async {
    try {
      String? _deviceToken = await _getDeviceToken();
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.topic);
      Response response = await dioClient.post(
        AppConstants.fcmTokenUri,
        data: {"id": "7", "token": _deviceToken},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<String?> _getDeviceToken() async {
    String? _deviceToken;
    if(Platform.isIOS) {
      _deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    }else {
      _deviceToken = await FirebaseMessaging.instance.getToken();
    }

    if (_deviceToken != null) {
      print('--------Device Token---------- '+_deviceToken);
    }
    return _deviceToken;
  }

  String getAuthToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  String getPreferenceData(String key) {
    return sharedPreferences.getString(key) ?? "";
  }

  void setPreferenceData(String key,String value){
    sharedPreferences.setString(key, value);
  }


  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  bool isOnBoardingEnable(){
    return sharedPreferences.getBool(AppConstants.onBoarding) ?? true;
  }

  disableOnBoarding(){
    sharedPreferences.setBool(AppConstants.onBoarding, false);
  }

  Future<bool> clearSharedData() async {
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.onBoarding);
    sharedPreferences.remove(AppConstants.userId);
    sharedPreferences.remove(AppConstants.city);
    sharedPreferences.remove(AppConstants.cityId);
    sharedPreferences.remove(AppConstants.categoryId);
    sharedPreferences.remove(AppConstants.category);
    sharedPreferences.clear();
    return true;
  }
}