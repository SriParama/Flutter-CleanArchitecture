import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';

class NavigationBloc extends Bloc<NavigationEvent, void> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationBloc({required this.navigatorKey}) : super(null) {
    on<GlobalNavigationPushNamedEvent>(
      (event, emit) {
        ScaffoldMessenger.of(navigatorKey.currentContext!).clearSnackBars();

        navigatorKey.currentState?.pushNamed(
          event.routeName,
        );
      },
    );
    on<GlobalNavigationpushReplacementNamedEvent>(
      (event, emit) {
        ScaffoldMessenger.of(navigatorKey.currentContext!).clearSnackBars();

        navigatorKey.currentState?.pushReplacementNamed(
          event.routeName,
        );
      },
    );
    on<GlobalNavigationpushNamedAndRemoveUntilEvent>(
      (event, emit) {
        ScaffoldMessenger.of(navigatorKey.currentContext!).clearSnackBars();

        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          event.routeName,
          (route) => route.isFirst,
        );
      },
    );

    on<GlobleNavigationPop>(
      (event, emit) {
        navigatorKey.currentState?.pop();
      },
    );
  }
}
