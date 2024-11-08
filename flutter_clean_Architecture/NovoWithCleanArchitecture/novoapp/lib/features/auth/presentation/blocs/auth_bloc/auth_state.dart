part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  const AuthSuccessState();
}

final class AuthFailureState extends AuthState {
  final String failureMsg;
  const AuthFailureState({required this.failureMsg});
}

class AuthForgetPwdState extends AuthState {
  const AuthForgetPwdState();
}

class AuthGetOtpState extends AuthState {
  const AuthGetOtpState();
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
