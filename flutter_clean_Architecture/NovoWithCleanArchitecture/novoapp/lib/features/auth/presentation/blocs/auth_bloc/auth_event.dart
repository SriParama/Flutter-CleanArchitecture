part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final LoginEntity loginEntity;

  const AuthLoginEvent({required this.loginEntity});
}

class AuthForgetPwdEvent extends AuthEvent {
  final ForgetPwdEntity forgetPwdEntity;
  const AuthForgetPwdEvent({required this.forgetPwdEntity});
}

class AuthGetOtpEvent extends AuthEvent {
  final GetOtpEntity getOtpEntity;
  const AuthGetOtpEvent({required this.getOtpEntity});
}
