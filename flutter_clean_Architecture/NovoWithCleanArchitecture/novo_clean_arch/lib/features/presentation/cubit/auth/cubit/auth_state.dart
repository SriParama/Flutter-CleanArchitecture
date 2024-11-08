part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class Authenticated extends AuthState {
  final String cookie;

  const Authenticated({required this.cookie});
  // const Authenticated();
  @override
  List<Object> get props => [cookie];
}

final class UnAuthenticated extends AuthState {
  @override
  List<Object> get props => [];
}
