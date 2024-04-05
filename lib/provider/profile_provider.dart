import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flyseas/data/model/base/response_model.dart';
import 'package:flyseas/data/model/response/profile_response.dart';
import 'package:flyseas/repository/profile_repo.dart';
import 'package:http/http.dart' as http;

import '../data/model/base/api_response.dart';

class ProfileProvider extends ChangeNotifier{
  final ProfileRepo profileRepo;

  ProfileProvider({required this.profileRepo});

  Map<String, String> fileData = {};
  Map<String, String> formValues = {};


  bool _isKycSubmitting = false;

  void updateFormValue(String index, String val) async {
    formValues[index] = val;
  }

  void updateFileData(String index, String val) async {
    fileData[index] = val;
  }

  String getFileName(String id){
    String? path = fileData[id];
    return path!=null ? path.split("/").last : "";
  }

  Future<Map<String,dynamic>> storeKYCData(String token) async {
    Map<String,dynamic> result = {};
    _isKycSubmitting = true;
    notifyListeners();
    http.StreamedResponse apiResponse =  await profileRepo.storeKycData(formValues,fileData,token);
    _isKycSubmitting = false;
    if (apiResponse.statusCode == 200) {
      result['status'] = true;
      result['message'] = "KYC Submitted";
      //{success: true, message: Lead has been successfully created., goal_id: 84, lead_id: 197357}
      await apiResponse.stream.bytesToString().then((value) {
        Map<String,dynamic> map = jsonDecode(value);
        result['message'] = map['message'];
        print(map);
      });
      notifyListeners();
    }
    else if(apiResponse.statusCode==422) {
      result['status'] = false;
      result['message'] = apiResponse.reasonPhrase ?? "Error";
      await apiResponse.stream.bytesToString().then((value){
        Map<String,dynamic> data = jsonDecode(value);
        result['message'] = data['message'];
        notifyListeners();

      });
      notifyListeners();

    }
    else {
      apiResponse.stream.bytesToString().then((value) {
        print(value);
      });
      result['status'] = false;
      result['message'] = apiResponse.reasonPhrase ?? "Server Error";

    }

    return result;
  }


  bool isProfileLoading = false;
  ProfileDetailResponse? profileDetailResponse;
  Future getProfileDetail() async{
    isProfileLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await profileRepo.getProfileDetail();
    isProfileLoading = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      profileDetailResponse = ProfileDetailResponse.fromJson(apiResponse.response?.data);
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


  bool _isBankDetailUpdating = false;
  bool get isBankDetailUpdating => _isBankDetailUpdating;
  Future<ResponseModel> storeBankDetail(Map<String,String> bankDetails,{bool isUpdate= false}) async{
    ResponseModel model = ResponseModel("message", false);
    _isBankDetailUpdating = true;
    notifyListeners();
    ApiResponse apiResponse = await (isUpdate ? profileRepo.updateBankDetail(bankDetails) : profileRepo.storeBankDetail(bankDetails));
    _isBankDetailUpdating = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      model = ResponseModel(apiResponse.response?.data['profile'], true);
      getProfileDetail();
    }
    else{
      print(apiResponse.error.toString());
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = "Error While Updating";
      }
      model = ResponseModel(errorMessage, false);
    }

    return model;
  }




}