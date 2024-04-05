import 'package:flutter/material.dart';
import 'package:flyseas/data/model/response/bakery_home_response.dart';
import 'package:flyseas/data/model/response/main_category_response.dart';
import 'package:flyseas/repository/home_repo.dart';

import '../data/model/base/api_response.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepo homeRepo;
  String _categoryName = "Select Category";
  String get categoryName => _categoryName;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  List<String> topSlider = [];
  String midBanner = "";

  List<MainCategory> mainCategoryList = [];

  List<GroupProduct> groupProduct = [];
  List<BakeryProduct> newArrival = [];
  List<Category> homeCategory = [];

  int _kycStatus = 0;
  int get kycStatus => _kycStatus;

  void updateKycStatus(int status){
    _kycStatus = status;
    notifyListeners();
  }

  int _selectedCategory = 0;
  int get selectedCategory => _selectedCategory;

  HomeProvider({required this.homeRepo}) {
    _selectedCategory = homeRepo.getSelectedCategory();
    //updateCategoryName();
  }

  int _selectedHomePageIndex = 0;
  int get selectedHomePageIndex => _selectedHomePageIndex;

  void updateHomePageIndex(int index){
    _selectedHomePageIndex = index;
    notifyListeners();
  }


  void updateCategory(int index) {
    _selectedCategory = mainCategoryList[index].id;
    _categoryName= mainCategoryList[index].name;
    for (var element in mainCategoryList) {
      element.isSelected = false;
    }
    mainCategoryList[index].isSelected = true;
    //updateCategoryName();
    homeRepo.saveSelectedCategory(mainCategoryList[index].id,categoryName);
    notifyListeners();
  }

  void updateProduct(){
    notifyListeners();
  }

  /*void updateCategoryName() {
    if (_selectedCategory == 1) {
      categoryName = "Bakery";
    } else if (_selectedCategory == 2) {
      categoryName = "FMCG";
    } else if (_selectedCategory == 3) {
      categoryName = "Clothing";
    } else if (_selectedCategory == 4) {
      categoryName = "Electronic";
    }
    notifyListeners();
  }*/

  Future getMainCategoryList() async{
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await homeRepo.getMainCategoryList();
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      mainCategoryList.clear();
      var resp = MainCategoryListResponse.fromJson(apiResponse.response?.data);
      mainCategoryList.addAll(resp.mainCategory);
      if(selectedCategory!=0 && mainCategoryList.isNotEmpty){
        mainCategoryList[mainCategoryList.indexWhere((element) => element.id==selectedCategory)].isSelected = true;
        _categoryName = mainCategoryList.firstWhere((element) => element.id==selectedCategory).name ;
      }
      notifyListeners();
    }
    else{

    }
  }

  bool isError = false;

  Future getHomeData() async{
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await homeRepo.getHomeData();
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      var homeResp = BakeryHomeResponse.fromJson(apiResponse.response?.data);
      updateKycStatus(homeResp.kycStatus);
      topSlider.clear();
      for (var element in homeResp.sliders) {
          if(element.sliderType=="Main Slider"){
            topSlider.addAll(element.sliderImages);
          }
      }
      for (var element in homeResp.banners) {
        if(element.bannerType=="Midd"){
          if(element.bannerImages.isNotEmpty){
            midBanner = element.bannerImages[0];
          }
        }
      }

      newArrival.clear();
      newArrival.addAll(homeResp.newArrival);

      groupProduct.clear();
      groupProduct.addAll(homeResp.groupProducts);

      homeCategory.clear();
      homeCategory.addAll(homeResp.category);
      isError = false;
      notifyListeners();
      print(apiResponse.response);
    }
    else if(apiResponse.response?.statusCode==400){
      isError = true;
      notifyListeners();
    }
    else{
      isError = true;
      notifyListeners();
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
