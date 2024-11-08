part of 'auth_cookie_cubit.dart';

sealed class AuthCookieState extends Equatable {
  const AuthCookieState();

  @override
  List<Object> get props => [];
}

final class AuthCookieInitial extends AuthCookieState {}

final class AuthCookieValidated extends AuthCookieState {
  final String cookie;
  const AuthCookieValidated({required this.cookie});
  @override
  List<Object> get props => [cookie];
}

final class AuthCookieInvalid extends AuthCookieState {
  final String failureMsg;
  const AuthCookieInvalid({required this.failureMsg});

  @override
  List<Object> get props => [];
}
