part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;
  final ThemeMode themeMode;

  ThemeState({required this.themeData, required this.themeMode});

  @override
  List<Object> get props => [themeData, themeMode];
}

// final class ThemeInitial extends ThemeState {
//   ThemeInitial({required super.themeData, required super.themeMode});
// }
