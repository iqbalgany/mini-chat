import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  appBarTheme: AppBarThemeData(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.grey,
    iconTheme: IconThemeData(color: Colors.grey.shade900),
  ),

  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
    error: Colors.red,
  ),
);
