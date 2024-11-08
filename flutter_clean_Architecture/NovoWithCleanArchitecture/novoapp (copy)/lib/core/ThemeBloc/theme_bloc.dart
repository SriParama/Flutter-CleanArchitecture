import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ToggleTheme, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
            themeData: ThemeClass.Lighttheme, themeMode: ThemeMode.light)) {
    on<ToggleTheme>(_onToggleTheme);
    _loadThemeFromPrefs();
  }
  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    final isLightTheme = state.themeMode == ThemeMode.light;
    final newThemeMode = isLightTheme ? ThemeMode.dark : ThemeMode.light;
    final newThemeData =
        isLightTheme ? ThemeClass.Darktheme : ThemeClass.Lighttheme;

    _saveThemeToPrefs(newThemeMode);
    emit(ThemeState(themeData: newThemeData, themeMode: newThemeMode));
  }

  void _loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme');

    if (savedTheme == 'dark') {
      add(ToggleTheme());
    }
  }

  void _saveThemeToPrefs(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', themeMode.toString().split('.').last);
  }
}
