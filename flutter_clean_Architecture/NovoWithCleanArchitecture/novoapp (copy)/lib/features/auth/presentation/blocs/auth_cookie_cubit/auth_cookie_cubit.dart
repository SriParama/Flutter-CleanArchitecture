import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novoapp/core/common/globleVariables.dart';
import 'package:novoapp/core/utils/shared_pref.dart';
import 'package:novoapp/features/auth/domine/use_cases/getCurrentCookie_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/is_LoggedIn_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/logged_out_usecase.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

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
      ////print("isSignIn");loggedIn
      ////print(isSignIn);

      if (isSignIn) {
        // final cookie = await getCurrentCookieUseCase.call();
        final cookie = await SharedPrefRepository().getCookie();
        ////print("isSignIn cookie");
        // ////print(cookie);

        emit(AuthCookieValidated(cookie: cookie));
      } else {
        ////print('AuthCookieInvalid()');
        emit(AuthCookieInvalid(failureMsg: sessionError));
      }
    } on SocketException catch (_) {
      emit(AuthCookieInvalid(failureMsg: sessionError));
    }
  }

  Future<bool> loggedIn() async {
    try {
      final isSignIn = await isLoggedInUseCase.call();
      ////print('isSignIn11111111111111111111');
      print(isSignIn);
      if (isSignIn) {
        // final cookie = await getCurrentCookieUseCase.call();
        final cookie = await SharedPrefRepository().getCookie();
        ////print('logged in state');
        emit(AuthCookieValidated(cookie: cookie));
        return true;
      } else {
        ////print('AuthCookieInvalid()  LoggedIn');

        emit(AuthCookieInvalid(failureMsg: sessionError));
        return false;
      }
    } catch (_) {
      emit(AuthCookieInvalid(failureMsg: sessionError));
      return false;
    }
  }

  Future<bool> loggedOut() async {
    try {
      bool isLogout = await loggedOutUseCase.call();
      //print("loggedOutUseCase.call()");
      if (isLogout) {
        //print("lAuthCookieInvalid()");
        emit(AuthCookieInvalid(failureMsg: LogoutSuccess));

        return true;
      } else {
        return false;
      }
    } catch (_) {
      ////print("loggedOutUseCase.call()catch");

      // emit(AuthCookieInvalid(failureMsg: LogoutSuccess));
      return false;
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
