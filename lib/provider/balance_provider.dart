import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flyseas/data/model/response/balance_sheet_response.dart';
import 'package:flyseas/repository/balance_repo.dart';

import '../data/model/base/api_response.dart';
import '../data/model/base/response_model.dart';

class BalanceProvider extends ChangeNotifier{
  final BalanceRepo balanceRepo;
  BalanceProvider({required this.balanceRepo});

  bool _balanceLoading = false;
  bool get balanceLoading => _balanceLoading;

  List<WalletHistory> balanceList = [];
  double balance = 0.0;


  Future getBalanceHistory() async{
    _balanceLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await balanceRepo.getWalletHistory();
    _balanceLoading = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      var balanceResp = BalanceSheetResponse.fromJson(apiResponse.response?.data);
      balanceList.clear();
      balanceList.addAll(balanceResp.walletHistory);
      balance =  double.parse(balanceResp.amount);
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

  Future<ResponseModel> rechargeWallet(String amount) async{
    ResponseModel responseModel = ResponseModel("_message", false);
    ApiResponse apiResponse = await balanceRepo.rechargeWallet(amount);
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


}