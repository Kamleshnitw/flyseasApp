import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flyseas/data/model/response/city_list_response.dart';
import 'package:flyseas/util/app_constants.dart';

import '../data/datasource/remote/exception/register_error.dart';
import '../data/model/base/api_response.dart';
import '../repository/auth_repo.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo authRepo;
  AuthProvider({required this.authRepo});


  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Map<String,String> cityData = {};
  Map<String,String> categoryData = {};

  String _selectedCity = "Select School";
  String get selectedCity => _selectedCity;

  void updateSelectedCity(String city){
    _selectedCity = city;
    notifyListeners();
  }

  List<String> cityNameList = [];


  Future<bool> verifyOTP(String phone,String otp) async{
    _isLoading = true;
    notifyListeners();
    
    ApiResponse apiResponse = await authRepo.verifyOTP(phone,otp);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      Map<String,dynamic> map = apiResponse.response?.data;
      if(map['data']!=null){
        if(map['data']['name']!=null){
          authRepo.setPreferenceData(AppConstants.name,map['data']['name']);
        }
        if(map['data']['city']!=null){
          authRepo.setPreferenceData(AppConstants.city,map['data']['city']['name'].toString());
          authRepo.setPreferenceData(AppConstants.cityId,map['data']['city']['id'].toString());
        }
        if(map['data']['category']!=null){
          authRepo.setPreferenceData(AppConstants.category,map['data']['category']['name'].toString());
          authRepo.setPreferenceData(AppConstants.categoryId,map['data']['category']['id'].toString());
        }
      }

      String token = map['token'];
      String message = map['message'] ?? "Data";
      if(token.isNotEmpty){
        authRepo.saveUserToken(token);
        await authRepo.updateToken();
      }

      notifyListeners();
      return true;
    }
    else{
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage ="Invalid Otp.";
      }

      _isLoading = false;
      notifyListeners();
      return false;
    }
  }


  Future getCityList() async{
    notifyListeners();
    ApiResponse apiResponse = await authRepo.getCityList();
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
        cityData.clear();
        var cityResp = CityListResponse.fromJson(apiResponse.response?.data);
        cityNameList.clear();
        cityNameList.add("Select School");
        for (var element in cityResp.city) {
          cityData[element.id.toString()] = element.name;
          cityNameList.add(element.name);
        }
        notifyListeners();
    }

  }

  String getCityId() {
    return cityData.keys
        .firstWhere((k) => cityData[k] == _selectedCity, orElse: () => "");
  }

  Future saveToken(String token) async{
    authRepo.saveUserToken(token);
  }

  Future savePreferenceData(String key,String data) async{
    authRepo.setPreferenceData(key,data);
  }

  String getPreferenceData(String key) {
    return authRepo.getPreferenceData(key);
  }


  Timer? _timer;
  int _start = 60;

  int get start =>_start;

  void restartTimer(){
    _start =60;
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer =  Timer.periodic(oneSec,
          (Timer timer) {
        if (_start == 0) {
            timer.cancel();
        } else {
            _start--;
            notifyListeners();
        }
      },
    );
  }



  Future loginWithPhone(Map<String,String> loginData,Function callback,{bool isOtpVerified=false}) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.loginWithPhone(loginData);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      Map map = apiResponse.response?.data;
      String message = map['message'];
      callback(true, message);
      notifyListeners();
    }
    else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        String errorDescription = "Invalid Data";
        Map<String,dynamic> errorData = jsonDecode(apiResponse.error.toString());
        if(errorData['errors']!=null){
          ErrorRegisterResponse erResp = ErrorRegisterResponse.fromJson(errorData);
          if(erResp.errors.name.isNotEmpty){
            errorDescription = erResp.errors.name[0];
          }
          else if(erResp.errors.phoneNumber.isNotEmpty){
            errorDescription = erResp.errors.phoneNumber[0];
          }
          else {
            errorDescription = "Un Processable Content";
          }
        }
        else{
          errorDescription = errorData['message'];
        }
        errorMessage = errorDescription;
      }
      _isLoading = false;
      callback(false, errorMessage);
      notifyListeners();
    }
  }

  Future<void> updateToken(BuildContext context) async {
    ApiResponse apiResponse = await authRepo.updateToken();
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {

    } else {
      //ApiChecker.checkApi(context, apiResponse);
    }
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  bool isOnBoardingEnabled(){
    return authRepo.isOnBoardingEnable();
  }

  Future<void> disableOnBoarding() async{
    authRepo.disableOnBoarding();
  }


}