part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthSuccessState extends AuthState {
  const AuthSuccessState();
}

final class AuthFailureState extends AuthState {
  final String failureMsg;
  const AuthFailureState({required this.failureMsg});
}

class AuthForgetPwdSuccess extends AuthState {
  const AuthForgetPwdSuccess();
}

class AuthForgetPwdFailure extends AuthState {
  final String failureMsg;
  const AuthForgetPwdFailure({required this.failureMsg});
}

class AuthGetOtpSuccess extends AuthState {
  const AuthGetOtpSuccess();
}

class AuthGetOtpFailure extends AuthState {
  final String failureMsg;
  const AuthGetOtpFailure({required this.failureMsg});
}

// final class AuthCookieValidated extends AuthState {
//   // final String cookie;
//   const AuthCookieValidated();
//   @override
//   List<Object> get props => [];
// }

// final class AuthCookieInvalid extends AuthState {
//   @override
//   List<Object> get props => [];
// }
