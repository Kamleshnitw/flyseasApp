import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/base/api_response.dart';
import '../data/model/base/error_response.dart';
import '../data/model/base/response_model.dart';
import '../data/model/response/address_list_response.dart';
import '../repository/location_repo.dart';


class LocationProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  final LocationRepo locationRepo;

  LocationProvider({required this.sharedPreferences, required this.locationRepo});

  bool _loading = false;
  bool get loading => _loading;
  bool _isBilling = true;
  bool get isBilling =>_isBilling;
  TextEditingController _locationController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();

  TextEditingController get locationController => _locationController;
  TextEditingController get cityController => _cityController;
  TextEditingController get stateController => _stateController;
  TextEditingController get countryController => _countryController;



  bool _buttonDisabled = true;
  bool _changeAddress = true;

  bool _updateAddAddressData = true;

  bool get buttonDisabled => _buttonDisabled;


  void setLocationController(String text) {
    _locationController.text = text;
  }


  // delete usser address
  void deleteUserAddressByID(int id, int index, Function callback) async {
    ApiResponse apiResponse = await locationRepo.removeAddressByID(id);
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      _addressList.removeAt(index);
      callback(true, 'Deleted address successfully');
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      callback(false, errorMessage);
    }
  }

  bool _isAvaibleLocation = false;

  bool get isAvaibleLocation => _isAvaibleLocation;

  // user address
  List<Address> _addressList = [];

  List<Address> get addressList => _addressList;

  Future<ResponseModel> initAddressList(BuildContext context) async {
    ResponseModel _responseModel = ResponseModel("_message", false);
    ApiResponse apiResponse = await locationRepo.getAllAddress();
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      _addressList.clear();
      var resp = AddressListResponse.fromJson(apiResponse.response?.data);
      _addressList.addAll(resp.addresses);
      if(_addressList.isNotEmpty){
        updateSelectedAddress(0);
      }
      _responseModel = ResponseModel('successful', true);
    } else {
     // ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return _responseModel;
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  String? _addressStatusMessage = '';
  String? get addressStatusMessage => _addressStatusMessage;
  updateAddressStatusMessae({required String message}){
    _addressStatusMessage = message;
  }
  updateErrorMessage({required String message}){
    _errorMessage = message;
  }

  Future<ResponseModel> addAddress(Map<String,String> addressModel, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    _errorMessage = '';
    _addressStatusMessage = null;
    ApiResponse apiResponse = await locationRepo.addAddress(addressModel);
    _isLoading = false;
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      Map map = apiResponse.response?.data;
      initAddressList(context);
      String message = map["message"] ?? "";
      responseModel = ResponseModel(message, true);
      _addressStatusMessage = message;
    } else {
      String errorMessage = apiResponse.error.toString();
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel(errorMessage, false);
      _errorMessage = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }



  // for address update screen
  Future<ResponseModel> updateAddress(BuildContext context, {required Map<String,String> addressModel,required int id}) async {
    _isLoading = true;
    notifyListeners();
    _errorMessage = '';
    _addressStatusMessage = null;
    ApiResponse apiResponse = await locationRepo.updateAddress(addressModel,id);
    _isLoading = false;
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      Map map = apiResponse.response?.data;
      initAddressList(context);
      String message = map["message"] ?? "";
      responseModel = ResponseModel( message, true);
      _addressStatusMessage = message;
    } else {
      String errorMessage = apiResponse.error.toString();
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel(errorMessage, false);
      _errorMessage = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  String _isPinCodeFound = '';
  String get isPinCodeFound => _isPinCodeFound;
  String cityId = '';
  String stateId = '';



  // for Label Us
  List<String> _getAllAddressType = [];

  List<String> get getAllAddressType => _getAllAddressType;
  int _selectAddressIndex = 0;

  int get selectAddressIndex => _selectAddressIndex;

  updateAddressIndex(int index, bool notify) {
    _selectAddressIndex = index;
    if(notify) {
      notifyListeners();
    }
  }

  Address? getSelectedAddress(){
    Address? selectedAddress;
    for (var element in addressList) {
      if(element.isSelected){
        selectedAddress = element;
      }
    }
    return selectedAddress;
  }

  void updateSelectedAddress(int index){
    for (var element in addressList) {
      element.isSelected = false;
    }
    addressList[index].isSelected = true;
    notifyListeners();
  }

  initializeAllAddressType({required BuildContext context}) {
    if (_getAllAddressType.isEmpty) {
      _getAllAddressType = [];
      _getAllAddressType = locationRepo.getAllAddressType(context: context);
    }
  }


  void disableButton() {
    _buttonDisabled = true;
    notifyListeners();
  }













  void isBillingChanged(bool change) {
    _isBilling = change;
    if (change) {
      change = !_isBilling;
    }
    notifyListeners();
  }


}
