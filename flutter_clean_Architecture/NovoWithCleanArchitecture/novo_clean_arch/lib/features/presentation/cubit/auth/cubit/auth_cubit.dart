// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'auth_state.dart';

// class AuthCubit extends Cubit<AuthState> {
//   final IsS
//   AuthCubit() : super(AuthInitial());
// }

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novo_clean_arch/features/domin/usecases/get_current_cookie_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/is_log_in_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/log_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsLogInUseCase isLogInUseCase;
  final GetCurrentCookieUseCase getCurrentCookieUseCase;
  final LogOutUseCase logOutUseCase;

  AuthCubit(
      {required this.isLogInUseCase,
      required this.getCurrentCookieUseCase,
      required this.logOutUseCase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isLogInUseCase.call();

      if (isSignIn) {
        final cookie = await getCurrentCookieUseCase.call();
        emit(Authenticated(cookie: cookie));
      } else {
        emit(UnAuthenticated());
      }
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final isSignIn = await isLogInUseCase.call();

      if (isSignIn) {
        final cookie = await getCurrentCookieUseCase.call();
        emit(Authenticated(cookie: cookie));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await logOutUseCase.logOut();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
