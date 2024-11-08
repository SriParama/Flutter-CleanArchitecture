import 'package:flutter/material.dart';

import 'app_pallete.dart';

class AppTheme {
  static _border([Color borderColor = AppPallete.inputBorderColor]) =>
      OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: borderColor, width: 3));

  static final lightThemeMode = ThemeData.light().copyWith(
      // appBarTheme:
      //     const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
      // scaffoldBackgroundColor: AppPallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: const EdgeInsets.all(27),
          border: _border(),
          enabledBorder: _border(),
          focusedErrorBorder: _border(AppPallete.primaryColor.withOpacity(0.8)),
          labelStyle: const TextStyle(
              // ignore: use_full_hex_values_for_flutter_colors
              color: Color(0xfff8198a5),
              fontSize: 16,
              height: 1.62),
          focusedBorder: _border(AppPallete.primaryColor.withOpacity(0.8)),
          errorBorder: _border(AppPallete.errorColor)),
      chipTheme: const ChipThemeData(
          side: BorderSide.none,
          color: MaterialStatePropertyAll(AppPallete.backgroundColor)));
}
