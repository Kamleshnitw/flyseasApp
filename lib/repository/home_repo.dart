import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/datasource/remote/exception/api_error_handler.dart';
import '../data/model/base/api_response.dart';
import '../util/app_constants.dart';
import '../data/datasource/remote/dio/dio_client.dart';

class HomeRepo {
  final SharedPreferences sharedPreferences;
  final DioClient dioClient;
  HomeRepo({required this.dioClient, required this.sharedPreferences});

  int getSelectedCategory() {
    return sharedPreferences.getInt(AppConstants.category) ?? 0;
  }

  void saveSelectedCategory(int categoryId,String categoryName){
    sharedPreferences.setInt(AppConstants.category, categoryId);
  }

  Future<ApiResponse> getHomeData() async {
    try {
      Response response = await dioClient.get(
        AppConstants.getHomeUri,
      );
      
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }

  Future<ApiResponse> getMainCategoryList() async {
    try {
      Response response = await dioClient.get(
        AppConstants.getMainCategoryUri,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }

}