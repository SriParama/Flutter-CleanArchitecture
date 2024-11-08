import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/ThemeBloc/theme_bloc.dart';

class AppColors {
  static const Color backgroundColor = Color.fromRGBO(24, 24, 32, 1);
  static const Color inputBorderColor = Color.fromRGBO(244, 244, 246, 1);
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Colors.grey;
  static const Color errorColor = Color.fromARGB(255, 240, 61, 61);
  static const Color transparentColor = Colors.transparent;
  static const Color primaryColor = Color.fromRGBO(9, 101, 218, 1);
}

Color appPrimeColor = const Color.fromRGBO(0, 74, 177, 1);
Color titleTextColorLight = const Color.fromRGBO(67, 67, 79, 1);
Color titleTextColorDark = Colors.white;
Color subTitleTextColor = const Color.fromRGBO(156, 155, 173, 1);
Color primaryRedColor = const Color.fromRGBO(236, 52, 78, 1);
Color primaryGreenColor = const Color.fromRGBO(11, 154, 124, 1);
Color primaryOrangeColor = const Color.fromRGBO(251, 140, 0, 1);
Color modifyButtonColor = const Color.fromRGBO(187, 222, 251, 1);
Color footerBackgroundColor = const Color.fromRGBO(225, 245, 254, 1);
Color activeColor = const Color.fromRGBO(83, 183, 162, 1);
Color inactiveColor = const Color.fromRGBO(240, 240, 240, 1);
Color infoColorStart = const Color.fromRGBO(236, 177, 82, 1);
Color infoColor = const Color.fromRGBO(255, 243, 224, 1);
Color sgbPrimaryColor = const Color.fromRGBO(255, 249, 160, 1);

// Color getThemeBasedColor(BuildContext context) {
//   final themeBloc = BlocProvider.of<ThemeBloc>(context);
//   final darkTheme = themeBloc.state.themeMode == ThemeMode.dark;
//   return darkTheme ? titleTextColorDark : titleTextColorLight;
// }

// BuildContext? context;
// getContext() {
//   return context;
// }

// setContext(BuildContext newContext) {
//   context = newContext;
// }

// class GetTheme {
//   // final BuildContext context;
//   late final ThemeBloc themeBloc;
//   late final bool darkTheme;
//   late final Color themeColor;

//   GetTheme.instance() {
//     themeBloc = BlocProvider.of<ThemeBloc>(getContext());
//     darkTheme = themeBloc.state.themeMode == ThemeMode.dark;
//     themeColor = darkTheme ? titleTextColorDark : titleTextColorLight;
//   }

//   static final getThemeInstance = GetTheme.instance();
//   factory GetTheme() => getThemeInstance;
// }
