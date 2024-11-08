import 'dart:async';

import 'package:flattrade/core/utils/text_contants.dart';
import 'package:flattrade/core/utils/token_resposistory.dart';
import 'package:flattrade/features/auth/domain/usecases/client_login_usecase.dart';
import 'package:flattrade/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:flattrade/features/auth/domain/usecases/get_opt_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ClientLogin _clientLogin;
  final GetOtp _getOtp;
  final ForgetPasswordUsecase _passwordUsecase;

  AuthBloc({
    required ClientLogin clientLogin,
    required GetOtp getOtp,
    required ForgetPasswordUsecase passwordUsecase,
  })  : _clientLogin = clientLogin,
        _getOtp = getOtp,
        _passwordUsecase = passwordUsecase,
        super(AuthInitial()) {
    on<AuthLogin>(authLogin);
    on<AuthOtp>(authOtp);
    on<AuthForgetPasswordEvent>(authForgetPasswordEvent);
  }

  FutureOr<void> authLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    var res = await _clientLogin(UserLoginParams(
      event.factor,
      userId: event.userId,
      password: event.password,
    ));

    res.fold((failure) => emit(AuthFailureState(failureMsg: failure.message)),
        (response) {
      if (response["quickauthresp"]['stat'] == 'Ok') {
        TokenRepository().saveToken(response["quickauthresp"]['susertoken'],
            response["quickauthresp"]['actid']);
        emit(AuthSuccessState());
      } else if (response["quickauthresp"]['stat'] == 'Not_Ok') {
        if (response.containsKey('spasswordreset')) {
          emit(AuthPasswordExpiryState());
        } else {
          emit(AuthFailureState(failureMsg: response["quickauthresp"]['emsg']));
        }
      } else {
        emit(AuthFailureState(failureMsg: APPTextConstants.failed));
      }
    });
  }

  FutureOr<void> authOtp(AuthOtp event, Emitter<AuthState> emit) async {
    var res = await _getOtp.call(UserLoginParams(
      '',
      userId: event.userId,
      password: event.password,
    ));

    res.fold((failure) => emit(AuthFailureState(failureMsg: failure.message)),
        (res) {
      if (res["response"]["ReqStatus"] == "OTP generation success") {
        emit(AuthSendedOtpState());
      } else {
        emit(AuthFailureState(failureMsg: res["response"]["ReqStatus"]));
      }
    });
  }

  FutureOr<void> authForgetPasswordEvent(
      AuthForgetPasswordEvent event, Emitter<AuthState> emit) async {

emit(AuthLoadingState());

    var res = await _passwordUsecase.call(UserForgetPasswordParams(
      userId: event.userId,
      pan: event.pan,
      dob: event.dob,
    ));

    res.fold((failure) => emit(AuthFailureState(failureMsg: failure.message)),
        (res) {
      if (res["status"] == "S") {
        emit(AuthSuccessState());
      } else {
        emit(AuthFailureState(failureMsg: res["errMsg"]));
      }
    });
  }
}
// {
//     "response": {
//         "request_time": "",
//         "stat": "",
//         "emsg": ""
//     },
//     "status": "E",
//     "errMsg": "Invalid Input :  Invalid DOB"
// }

// {
//     "response": {
//         "request_time": "",
//         "stat": "",
//         "emsg": ""
//     },
//     "status": "E",
//     "errMsg": "Error Occurred : Wrong user id or user details"
// }


// {
//     "response": {
//         "request_time": "15:20:15 04-05-2024",
//         "stat": "Ok",
//         "emsg": ""
//     },
//     "status": "S",
//     "errMsg": ""
// }