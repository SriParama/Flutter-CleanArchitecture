part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  AuthSuccessState();
}

final class AuthFailureState extends AuthState {
  final String failureMsg;

  AuthFailureState({required this.failureMsg});
}
class AuthSendedOtpState extends AuthState {
  AuthSendedOtpState();
}



class AuthPasswordExpiryState extends AuthState {
  AuthPasswordExpiryState();
}
