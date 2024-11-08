part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthLogin extends AuthEvent {
  final String userId;
  final String password;
  final String factor;
  AuthLogin({
    required this.userId,
    required this.password,
    required this.factor,
  });
}

class AuthOtp extends AuthEvent {
  final String userId;
  final String password;

  AuthOtp({
    required this.userId,
    required this.password,
  });
}

class AuthForgetPasswordEvent extends AuthEvent {
  final String userId;
  final String pan;
  final String dob;

  AuthForgetPasswordEvent({
    required this.userId,
    required this.pan,
    required this.dob,
  });
}
