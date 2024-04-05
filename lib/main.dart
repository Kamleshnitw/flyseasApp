import 'package:flutter/material.dart';
import 'package:flyseas/provider/auth_provider.dart';
import 'package:flyseas/provider/balance_provider.dart';
import 'package:flyseas/provider/home_provider.dart';
import 'package:flyseas/provider/location_provider.dart';
import 'package:flyseas/provider/order_provider.dart';
import 'package:flyseas/provider/product_provider.dart';
import 'package:flyseas/provider/profile_provider.dart';
import 'package:flyseas/provider/theme_provider.dart';
import 'package:flyseas/theme/dark_theme.dart';
import 'package:flyseas/theme/light_theme.dart';
import 'package:flyseas/util/app_constants.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;
import 'view/screens/splash/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> ThemeProvider()),
    ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<LocationProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<BalanceProvider>()),
  ], child: const MyApp()),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      home: const SplashScreen(),
    );
  }
}

