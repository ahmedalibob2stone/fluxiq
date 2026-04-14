import 'package:flutter/material.dart';

class AppTheme {
  static const Color bluePrimary = Color(0xFF1E88E5);
  static const Color purplePrimary = Color(0xFF8E24AA);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: bluePrimary,
    ).copyWith(
      primary: bluePrimary,
      secondary: purplePrimary,
    ),
    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.white,
      backgroundColor: Colors.transparent,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),
  );
}