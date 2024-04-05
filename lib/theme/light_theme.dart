import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyseas/util/color_resources.dart';

ThemeData light = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: ColorResources.gradientOne,
    brightness: Brightness.light,
    highlightColor: Colors.white,
    hintColor: Color(0xFF9E9E9E),
    primarySwatch: ColorResources.primaryMaterial,
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
    }),
    appBarTheme: AppBarTheme(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent)));
