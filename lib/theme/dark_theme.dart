import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyseas/util/color_resources.dart';

ThemeData dark = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: ColorResources.gradientOne,
    brightness: Brightness.dark,
    highlightColor: const Color(0xFF252525),
    hintColor: const Color(0xFFc7c7c7),
    primarySwatch: ColorResources.primaryMaterial,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
    }),
    appBarTheme: AppBarTheme(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent)));
