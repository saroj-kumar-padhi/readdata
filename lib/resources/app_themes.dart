import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    // backgroundColor: Colors.white,
    // buttonColor: LightColors.prime,
    // primaryColor: LightColors.prime,
    primaryColor: Colors.black87,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  static final dark = ThemeData.dark().copyWith(
    primaryColor: Colors.white
    // backgroundColor: Colors.black,
    // buttonColor: Colors.red,
  );
}