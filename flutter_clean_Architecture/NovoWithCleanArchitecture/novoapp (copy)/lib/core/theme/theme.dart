// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:novoapp/core/common/globleVariables.dart';

import 'package:novoapp/core/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeClass {
  static ThemeData Lighttheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    scrollbarTheme: ScrollbarThemeData(
        thickness: MaterialStatePropertyAll(5),
        radius: Radius.circular(30),
        thumbColor:
            MaterialStatePropertyAll(subTitleTextColor.withOpacity(0.35))),
    useMaterial3: false,
    primaryColor: appPrimeColor,
    brightness: Brightness.light,
    // appBarTheme: AppBarTheme(
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //       statusBarColor: Colors.transparent,
    //       statusBarIconBrightness: Brightness.dark),
    // ),

    textTheme: TextTheme(
      titleSmall: TextStyle(
          color: titleTextColorLight,
          fontSize: titleSmallFontSize,
          fontFamily: 'inter',
          fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          color: titleTextColorLight,
          fontSize: titleMediumFontSize,
          fontFamily: 'inter',
          fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          color: titleTextColorLight,
          fontSize: titleLargeFontSize,
          fontFamily: 'inter',
          fontWeight: FontWeight.w600),
      bodySmall: TextStyle(
        color: titleTextColorLight,
        fontSize: bodySmallFontSize,
        fontFamily: 'inter',
      ),
      bodyMedium: TextStyle(
        color: titleTextColorLight,
        fontSize: bodyMediumFontSize,
        fontFamily: 'inter',
      ),
      bodyLarge: TextStyle(
        color: titleTextColorLight,
        fontSize: bodyLargeFontSize,
        fontFamily: 'inter',
      ),
      displayMedium: TextStyle(
          color: subTitleTextColor,
          fontSize: bodyMediumFontSize,
          fontFamily: 'inter',
          height: 1.5),
      displaySmall: TextStyle(
        color: subTitleTextColor,
        fontSize: bodySmallFontSize,
        fontFamily: 'inter',
      ),
      headlineMedium: TextStyle(
          color: titleTextColorLight,
          fontSize: 25,
          letterSpacing: 1.2,
          fontFamily: 'Kiro',
          fontWeight: FontWeight.w900),
      headlineSmall: TextStyle(
          color: titleTextColorLight,
          fontSize: 18,
          letterSpacing: 1.2,
          fontFamily: 'Kiro',
          fontWeight: FontWeight.w900),
      labelMedium: TextStyle(
          color: titleTextColorLight,
          fontSize: 16,
          letterSpacing: 1,
          fontFamily: 'Kiro',
          fontWeight: FontWeight.w900),
    ),
    // primaryTextTheme: TextTheme(
    //   bodyMedium: TextStyle(fontFamily: 'Inter', color: titleTextColor),
    //   titleMedium: TextStyle(fontFamily: 'Inter', color: titleTextColor),
    //   displayMedium: TextStyle(fontFamily: 'Inter', color: titleTextColor),
    //   headlineMedium: TextStyle(fontFamily: 'Inter', color: titleTextColor),
    //   labelSmall: TextStyle(fontFamily: 'Inter', color: titleTextColor),
    // ),
    // scaffoldBackgroundColor: Colors.red, // You may set the background color
  );
  static ThemeData Darktheme = ThemeData(
    // primarySwatch: Colors.grey,
    scrollbarTheme: ScrollbarThemeData(
        radius: Radius.circular(30),
        thickness: MaterialStatePropertyAll(5),
        thumbColor:
            MaterialStatePropertyAll(titleTextColorDark.withOpacity(0.50))),
    useMaterial3: false,
    primaryColor: Colors.white,
    brightness: Brightness.dark,
    // appBarTheme: AppBarTheme(
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //       statusBarColor: Colors.transparent,
    //       statusBarIconBrightness: Brightness.light),
    // ),

    textTheme: TextTheme(
      titleSmall: TextStyle(
          color: titleTextColorDark,
          fontSize: titleSmallFontSize,
          fontFamily: 'inter',
          fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          color: titleTextColorDark,
          fontSize: titleMediumFontSize,
          fontFamily: 'inter',
          fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          color: titleTextColorDark,
          fontSize: titleLargeFontSize,
          fontFamily: 'inter',
          fontWeight: FontWeight.w600),
      bodySmall: TextStyle(
        color: titleTextColorDark,
        fontSize: bodySmallFontSize,
        fontFamily: 'inter',
      ),
      bodyMedium: TextStyle(
        color: titleTextColorDark,
        fontSize: bodyMediumFontSize,
        fontFamily: 'inter',
      ),
      bodyLarge: TextStyle(
        color: titleTextColorDark,
        fontSize: bodyLargeFontSize,
        fontFamily: 'inter',
      ),
      displayMedium: TextStyle(
          color: subTitleTextColor,
          fontSize: bodyMediumFontSize,
          fontFamily: 'inter',
          height: 1.5),
      displaySmall: TextStyle(
        color: subTitleTextColor,
        fontSize: bodySmallFontSize,
        fontFamily: 'inter',
      ),
      headlineMedium: TextStyle(
          color: titleTextColorDark,
          fontSize: 25,
          letterSpacing: 1.2,
          fontFamily: 'Kiro',
          fontWeight: FontWeight.w900),
      headlineSmall: TextStyle(
          color: titleTextColorDark,
          fontSize: 18,
          letterSpacing: 1.2,
          fontFamily: 'Kiro',
          fontWeight: FontWeight.w900),
      labelMedium: TextStyle(
          color: titleTextColorDark,
          fontSize: 16,
          letterSpacing: 1.0,
          fontFamily: 'Kiro',
          fontWeight: FontWeight.w900),
    ),
    // primaryTextTheme: TextTheme(
    //   bodyMedium: TextStyle(fontFamily: 'Inter', color: Colors.white),
    //   titleMedium: TextStyle(fontFamily: 'Inter', color: Colors.white),
    //   displayMedium: TextStyle(fontFamily: 'Inter', color: Colors.white),
    //   headlineMedium: TextStyle(fontFamily: 'Inter', color: Colors.white),
    //   labelSmall: TextStyle(fontFamily: 'Inter', color: Colors.white),
    // ),
    // scaffoldBackgroundColor:
    //     Colors.grey.shade800, // You may set the background color
  );
}

class ThemeManager {
  static Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', themeMode.toString());
  }

  static Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getString('theme_mode');
    return themeMode != null
        ? ThemeMode.values.firstWhere((e) => e.toString() == themeMode)
        : ThemeMode.system;
  }
}
