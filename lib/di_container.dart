

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flyseas/provider/balance_provider.dart';
import 'package:flyseas/provider/location_provider.dart';
import 'package:flyseas/provider/order_provider.dart';
import 'package:flyseas/provider/product_provider.dart';
import 'package:flyseas/provider/profile_provider.dart';
import 'package:flyseas/repository/balance_repo.dart';
import 'package:flyseas/repository/home_repo.dart';
import 'package:flyseas/provider/auth_provider.dart';
import 'package:flyseas/provider/home_provider.dart';
import 'package:flyseas/repository/auth_repo.dart';
import 'package:flyseas/repository/location_repo.dart';
import 'package:flyseas/repository/order_repo.dart';
import 'package:flyseas/repository/product_repo.dart';
import 'package:flyseas/repository/profile_repo.dart';
import 'package:flyseas/util/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'helper/network_info.dart';

final sl = GetIt.instance;


Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(AppConstants.baseURL, sl(), loggingInterceptor: sl(),
      sharedPreferences: sl()));


  //Repository
  sl.registerLazySingleton(() => ProductRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProfileRepo(dioClient: sl()));
  sl.registerLazySingleton(() => OrderRepo(dioClient: sl()));
  sl.registerLazySingleton(() => BalanceRepo(dioClient: sl()));



  // Provider
  sl.registerFactory(() => ProductProvider(productRepo: sl()));
  sl.registerFactory(() => BalanceProvider(balanceRepo: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => OrderProvider(orderRepo: sl()));



  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton(() => LocationRepo(dioClient: sl(),sharedPreferences: sharedPreferences));
  sl.registerFactory(() => LocationProvider(locationRepo: sl(), sharedPreferences: sharedPreferences));

  sl.registerLazySingleton(() => HomeRepo(dioClient: sl(),sharedPreferences: sharedPreferences));
  sl.registerFactory(() => HomeProvider(homeRepo: sl()));

  sl.registerLazySingleton(() => AuthRepo(dioClient: sl(),sharedPreferences: sharedPreferences));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
}