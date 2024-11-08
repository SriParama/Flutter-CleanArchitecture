import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:novoapp/core/utils/global_const.dart';
import 'package:novoapp/core/utils/shared_pref.dart';
import 'package:novoapp/features/auth/domine/enities/forgetpwd_enitity.dart';
import 'package:novoapp/features/auth/domine/enities/getotp_enitity.dart';
import 'package:novoapp/features/auth/domine/enities/login_entity.dart';
import 'package:novoapp/features/auth/domine/use_cases/forgetpwd_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/getCurrentCookie_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/getotp_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/is_LoggedIn_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/logged_out_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final ForgetPwdUseCase forgetPwdUseCase;
  final GetOtpUseCase getOtpUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.forgetPwdUseCase,
    required this.getOtpUseCase,
  }) :
        // _loginUseCase=loginUseCase,
        // _forgetPwdUseCase=forgetPwdUseCase,
        // _getOtpUseCase=getOtpUseCase,

        super(AuthInitial()) {
    on<AuthLoginEvent>(authlogin);
    on<AuthForgetPwdEvent>(authForgetPwd);
    on<AuthGetOtpEvent>(authOtp);
  }

  FutureOr<void> authlogin(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      var res = await loginUseCase.call(
        LoginEntity(
          clientId: event.loginEntity.clientId,
          pan: event.loginEntity.pan,
          password: event.loginEntity.password,
        ),
      );

      res.fold((failure) => emit(AuthFailureState(failureMsg: failure.message)),
          (response) {
        if (response['status'] == 'S') {
          emit(const AuthSuccessState());
        } else if (response['status'] == 'E') {
          emit(AuthFailureState(failureMsg: response['errmsg']));
        } else if (response['status'] == 'I') {
          emit(AuthFailureState(failureMsg: response['errmsg']));
        } else {
          emit(const AuthFailureState(failureMsg: AppContsTexts.failed));
        }
      });
    } on SocketException catch (e) {
      emit(const AuthFailureState(failureMsg: AppContsTexts.internetFailed));
    } catch (e) {
      emit(const AuthFailureState(failureMsg: AppContsTexts.internetFailed));
    }
  }

  FutureOr<void> authForgetPwd(
    AuthForgetPwdEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      var res = await forgetPwdUseCase.call(ForgetPwdEntity(
          clientId: event.forgetPwdEntity.clientId,
          dob: event.forgetPwdEntity.dob,
          pan: event.forgetPwdEntity.pan,
          sid: event.forgetPwdEntity.sid));

      res.fold((failure) => emit(AuthFailureState(failureMsg: failure.message)),
          (response) {
        if (response['emsg'] == "") {
          emit(const AuthForgetPwdState());
        } else {
          emit(AuthFailureState(failureMsg: response['emsg']));
        }
      });
    } on SocketException catch (_) {
      emit(const AuthFailureState(failureMsg: AppContsTexts.internetFailed));
    } catch (e) {
      ;
      emit(const AuthFailureState(failureMsg: AppContsTexts.internetFailed));
    }
  }

  FutureOr<void> authOtp(
    AuthGetOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      var res = await getOtpUseCase.call(GetOtpEntity(
          clientId: event.getOtpEntity.clientId,
          pan: event.getOtpEntity.pan,
          sid: event.getOtpEntity.sid,
          sid1: event.getOtpEntity.sid1));
      res.fold((failure) => emit(AuthFailureState(failureMsg: failure.message)),
          (response) {
        if (response['emsg'] == "") {
          emit(const AuthGetOtpState());
        } else {
          emit(AuthFailureState(failureMsg: response['emsg']));
        }
      });
    } on SocketException catch (_) {
      emit(const AuthFailureState(failureMsg: AppContsTexts.internetFailed));
    } catch (e) {
      emit(const AuthFailureState(failureMsg: AppContsTexts.internetFailed));
    }
  }
}
