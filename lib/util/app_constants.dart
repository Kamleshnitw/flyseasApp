
class AppConstants {

  static const String appName = 'Flyseas';
  //static const String root = 'http://10.0.2.2/flyseas/';
  // static const String root = 'https://flyseas.in/';
  static const String root = 'https://mapstreak.com/';
  static const String api = "api";
  static const String baseURL = root+api;
  static const String userId = 'userId';
  static const String name = 'name';
  static const String phone = 'phone';
  static const String city = 'city';
  static const String cityId= 'city_id';
  static const String token = 'token';
  static const String category = 'category';
  static const String categoryId = 'category_id';
  static const String topic = '';
  static const String onBoarding = 'onBoarding';


  static const String theme = 'theme';

  static const String connected = "Connected";
  static const String notConnected = "Not Connected";

  static const String countryCode = 'country_code';
  static const String langKey = 'lang';

  static const String fcmTokenUri = baseURL+"set-fcm-token";

  static const String loginUri = "/login";
  static const String verifyOtpUri = "/verify-otp";
  static const String getCityUri = "/city";
  static const String getMainCategoryUri = "/main-category";
  static const String getHomeUri = "/home";


  static const String kycStoreUri = "/kyc-store";

  static const String addToCartUri = "/add-to-cart";
  static const String updateCartUri = "/update-quantity";
  static const String removeCartUri = "/remove-cart-product";
  static const String getCartUri = "/cart-list";

  static const String getProductByCategoryUri = "/products-by-category/";
  static const String getAllProductUri = "/all-products";
  static const String getProductDescriptionUri = "/product-description/";

  static const String getCouponListUri = "/coupon-list";
  static const String applyCouponUri = "/apply-coupon";
  static const String orderStoreUri = "/order-store";
  static const String initPaymentUri = "/initiate-payment";

  static const String orderListUri = "/order-list";
  static const String orderDetailUri = "/order-detail/";

  static const String addressUri = "/address";

  static const String profileUri = "/profile";
  static const String bankDetailStoreUri = "/bank-detail-store";
  static const String bankDetailUpdateUri = "/bank-detail-update";

  static const String walletUri = "/wallet";
  static const String rechargeWalletUri = "/wallet-recharge";






}
