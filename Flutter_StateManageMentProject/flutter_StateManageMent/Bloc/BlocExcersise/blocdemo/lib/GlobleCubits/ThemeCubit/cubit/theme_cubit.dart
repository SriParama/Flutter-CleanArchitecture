import 'package:blocdemo/Common/theme/theme_class.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

part 'theme_state.dart';

enum AppTheme { systemTheme, lightTheme, darkTheme }

class ThemeCubit extends Cubit<ThemeData> {
  final Database db;

  ThemeCubit({required this.db}) : super(_systemTheme);

  // // Toggle between Light, Dark, and System theme
  // Future<void> toggleTheme(AppTheme theme, Brightness systemBrightness) async {
  //   if (theme == AppTheme.LightTheme) {
  //     emit(ThemeClass.lightThemeMode());
  //   } else if (theme == AppTheme.DarkTheme) {
  //     emit(ThemeClass.darkThemeMode());
  //   } else {
  //     // System theme based on device setting
  //     emit(systemBrightness == Brightness.dark
  //         ? ThemeClass.darkThemeMode()
  //         : ThemeClass.lightThemeMode());
  //   }

  //   // Save the selected theme in the database
  //   await _saveTheme(theme);
  // }
  // Light Theme
  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.red,
  );

  // Dark Theme
  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.yellow,
  );

  // System Theme (adjusts to the device theme)
  static final ThemeData _systemTheme = ThemeData();
  // System Theme (adjusts to the device theme)
  // static final ThemeData _systemTheme = ThemeData();

  // Toggle between Light, Dark, and System theme
  Future<void> toggleTheme(AppTheme theme, Brightness systemBrightness) async {
    if (theme == AppTheme.lightTheme) {
      emit(_lightTheme);
    } else if (theme == AppTheme.darkTheme) {
      emit(_darkTheme);
    } else {
      // System theme based on device setting
      emit(systemBrightness == Brightness.dark ? _darkTheme : _lightTheme);
    }

    // Save the selected theme in the database
    await _saveTheme(theme);
  }
  // Future<void> toggleTheme(AppTheme theme, Brightness systemBrightness) async {
  //   if (theme == AppTheme.LightTheme) {
  //     emit(_lightTheme);
  //   } else if (theme == AppTheme.DarkTheme) {
  //     emit(_darkTheme);
  //   } else {
  //     // System theme based on device setting
  //     emit(systemBrightness == Brightness.dark ? _darkTheme : _lightTheme);
  //   }

  //   // Save the selected theme in the database
  //   await _saveTheme(theme);
  // }

  // Save the selected theme in the database
  Future<void> _saveTheme(AppTheme theme) async {
    final List<Map<String, dynamic>> result = await db.query('theme');
    if (result.isEmpty) {
      await db.insert(
        'theme',
        {'theme': theme.toString().split('.').last.toLowerCase()},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      await db.update(
        'theme',
        {'theme': theme.toString().split('.').last.toLowerCase()},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // print(db);
  }
  // Future<void> _saveTheme(AppTheme theme) async {
  //   print(theme);
  //   print(theme.toString().split('.').last.toLowerCase());
  //   await db.insert(
  //     'theme',
  //     {'theme': theme.toString().split('.').last.toLowerCase()},
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  // Load the theme from the database
  Future<void> loadTheme(Brightness systemBrightness) async {
    final List<Map<String, dynamic>> result = await db.query('theme');
    if (result.isNotEmpty) {
      final String savedTheme = result.first['theme'] as String;

      if (savedTheme == 'lighttheme') {
        emit(_lightTheme);
      } else if (savedTheme == 'darktheme') {
        emit(_darkTheme);
      } else {
        // System theme
        emit(systemBrightness == Brightness.dark ? _darkTheme : _lightTheme);
      }
    } else {
      // Default to system theme if no preference is saved
      emit(systemBrightness == Brightness.dark ? _darkTheme : _lightTheme);
    }
  }
  // Load the theme from the database
  // Future<void> loadTheme(Brightness systemBrightness) async {
  //   final List<Map<String, dynamic>> result = await db.query('theme');
  //   if (result.isNotEmpty) {
  //     final String savedTheme = result.first['theme'] as String;
  //     // print("savedTheme");
  //     // print(savedTheme);
  //     if (savedTheme == 'lighttheme') {
  //       emit(ThemeClass.lightThemeMode());
  //     } else if (savedTheme == 'darktheme') {
  //       emit(ThemeClass.lightThemeMode());
  //     } else {
  //       // System theme
  //       emit(systemBrightness == Brightness.dark
  //           ? ThemeClass.darkThemeMode()
  //           : ThemeClass.lightThemeMode());
  //     }
  //   } else {
  //     // Default to system theme if no preference is saved
  //     emit(systemBrightness == Brightness.dark
  //         ? ThemeClass.darkThemeMode()
  //         : ThemeClass.lightThemeMode());
  //   }
  // }
}
