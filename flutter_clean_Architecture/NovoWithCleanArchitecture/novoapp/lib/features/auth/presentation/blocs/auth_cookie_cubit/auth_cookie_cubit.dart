import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novoapp/core/utils/shared_pref.dart';
import 'package:novoapp/features/auth/domine/use_cases/getCurrentCookie_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/is_LoggedIn_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/logged_out_usecase.dart';

part 'auth_cookie_state.dart';

class AuthCookieCubit extends Cubit<AuthCookieState> {
  final IsLoggedInUseCase isLoggedInUseCase;
  final LoggedOutUseCase loggedOutUseCase;
  // final GetCurrentCookieUseCase getCurrentCookieUseCase;
  AuthCookieCubit({
    required this.isLoggedInUseCase,
    required this.loggedOutUseCase,
    // required this.getCurrentCookieUseCase
  }) : super(AuthCookieInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isLoggedInUseCase.call();
      print("isSignIn");
      print(isSignIn);

      if (isSignIn) {
        // final cookie = await getCurrentCookieUseCase.call();
        final cookie = await SharedPrefRepository().getCookie();
        print("isSignIn cookie");
        // print(cookie);

        emit(AuthCookieValidated(cookie: cookie));
      } else {
        print('AuthCookieInvalid()');
        emit(AuthCookieInvalid());
      }
    } on SocketException catch (_) {
      emit(AuthCookieInvalid());
    }
  }

  Future<void> loggedIn() async {
    try {
      final isSignIn = await isLoggedInUseCase.call();
      print('isSignIn11111111111111111111');
      print(isSignIn);
      if (isSignIn) {
        // final cookie = await getCurrentCookieUseCase.call();
        final cookie = await SharedPrefRepository().getCookie();
        print('logged in state');
        emit(AuthCookieValidated(cookie: cookie));
      } else {
        print('AuthCookieInvalid()  LoggedIn');
        emit(AuthCookieInvalid());
      }
    } catch (_) {
      emit(AuthCookieInvalid());
    }
  }

  Future<void> loggedOut() async {
    try {
      await loggedOutUseCase.call();
      print("loggedOutUseCase.call()");
      emit(AuthCookieInvalid());
    } catch (_) {
      print("loggedOutUseCase.call()catch");
      emit(AuthCookieInvalid());
    }
  }

  @override
  void onChange(Change<AuthCookieState> change) {
    // TODO: implement onChange
    print("change");
    print(change);
    super.onChange(change);
  }
}
