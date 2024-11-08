import 'package:flutter/material.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationProvider with ChangeNotifier {
  ThemeData currentTheme = ThemeClass.Lighttheme;
  ThemeMode themeMode = ThemeMode.light;

  themeModel() {
    loadThemeFromPrefs();
  }

  void toggleTheme(context) {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      currentTheme = ThemeClass.Darktheme;
    } else {
      themeMode = ThemeMode.light;
      currentTheme = ThemeClass.Lighttheme;
    }
    saveThemeToPrefs();
    notifyListeners();
  }

  void loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme');

    if (savedTheme == 'dark') {
      themeMode = ThemeMode.dark;
      currentTheme = ThemeClass.Darktheme;
    } else if (savedTheme == 'light') {
      themeMode = ThemeMode.light;
      currentTheme = ThemeClass.Lighttheme;
    }
    notifyListeners();
  }

  void saveThemeToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', themeMode.toString().split('.').last);
  }
}
