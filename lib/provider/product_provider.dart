import 'package:flutter/material.dart';
import 'package:flyseas/data/model/response/bakery_home_response.dart';
import 'package:flyseas/data/model/response/product_description_response.dart';
import 'package:flyseas/data/model/response/product_list_response.dart';
import 'package:flyseas/repository/product_repo.dart';

import '../data/model/base/api_response.dart';
import '../data/model/response/cart_list_response.dart';

class ProductProvider extends ChangeNotifier{
  final ProductRepo productRepo;
  ProductProvider({required this.productRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<BakeryProduct> productList = [];
  List<BakeryProduct> relatedProducts = [];

  ProductDescriptionResponse? productDescriptionResponse;

  List<int> variantIndex = [];
  String variationName = "";

  Future getProductByCategoryId(int categoryId) async{
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await productRepo.getProductOfCategory(categoryId);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      var resp = ProductListResponse.fromJson(apiResponse.response?.data);
      productList.clear();
      productList.addAll(resp.productsList);
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


  Future getAllProductList() async{
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await productRepo.getProductList();
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      var resp = ProductListResponse.fromJson(apiResponse.response?.data);
      productList.clear();
      productList.addAll(resp.productsList);
      print(apiResponse.response);
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

  Future getProductDescription(int productId) async{
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await productRepo.getProductDescription(productId);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      productDescriptionResponse = ProductDescriptionResponse.fromJson(apiResponse.response?.data);
      if(productDescriptionResponse!=null){
        variantIndex.clear();
        for (var element in productDescriptionResponse!.productDescription.attributes) {
          variantIndex.add(0);
        }
        variationName = productDescriptionResponse!.productDescription.variation[0].combinationName;
        relatedProducts.clear();
        //relatedProducts.addAll(productDescriptionResponse!.relatedProducts);
        //buildVariationName(0, 0);
      }

      print(apiResponse.response);
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

  void buildVariationName(int parentIndex,int childIndex){
    variantIndex[parentIndex] = childIndex;
    print(variantIndex);
    String newName = "";
    for (var i = 0; i < variantIndex.length; i++) {
      newName+="-";
      newName+=productDescriptionResponse!.productDescription.attributes[i].variationValue[variantIndex[i]];
    }
    variationName = newName;
    notifyListeners();

  }

  Variation getSelectedVariation(){
    return productDescriptionResponse!.productDescription.variation.firstWhere((element) => element.combinationName==variationName);
  }

  bool _addingCart = false;
  bool get addingCart => _addingCart;
  Future<bool> addToCart(int productId,int quantity,String combinationName) async{
    _addingCart = true;
    notifyListeners();
    ApiResponse apiResponse = await productRepo.addToCart(productId,quantity,combinationName);
    _addingCart = false;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      print(apiResponse.response);
      notifyListeners();
      getCart();
      return true;
    }
    else{
      print(apiResponse.error.toString());
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = "Error While Checking";
      }
      return false;
    }
  }

  double getCartTotal(){
    double total = 0.0;
    for (var element in cartList) {
      total+= element.quantity*double.parse(element.sellingPrice);
    }
    return total;
  }

  void updateData(){
    notifyListeners();
  }

  Future<bool> updateToCart(int productId,int quantity,String combination) async{
    _addingCart = true;
    notifyListeners();
    ApiResponse apiResponse = await productRepo.updateCart(productId,quantity,combination);
    _addingCart = false;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      print(apiResponse.response);
      getCart();
      notifyListeners();
      return true;
    }
    else{
      print(apiResponse.error.toString());
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = "Error While Checking";
      }
      return false;
    }
  }

  Future<bool> deleteToCart(int productId,String combinationName) async{
    _addingCart = true;
    notifyListeners();
    ApiResponse apiResponse = await productRepo.deleteCart(productId,combinationName);
    _addingCart = false;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      print(apiResponse.response);
      notifyListeners();
      getCart();
      return true;
    }
    else{
      print(apiResponse.error.toString());
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = "Error While Checking";
      }
      return false;
    }
  }

  List<CartList> cartList = [];
  bool _cartLading = false;
  bool get cartLoading => _cartLading;
  Future getCart() async{
    _cartLading = true;
    notifyListeners();
    ApiResponse apiResponse = await productRepo.getCartList();
    _cartLading = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      var cartResp = CartListResponse.fromJson(apiResponse.response?.data);
      cartList.clear();
      cartList.addAll(cartResp.cartList);
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

  void updateCartQuantity(){
    //cartList.insert(position, cart);
    notifyListeners();
  }

  void removeItemFromCart(int index){
    cartList.removeAt(index);
  }


}