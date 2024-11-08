part of 'internet_cubit.dart';

@immutable
sealed class InternetState {}

final class InternetLoading extends InternetState {}
class InternetConnected extends InternetState {
  final String status;

  InternetConnected({required this.status});
}

class InternetDisconnected extends InternetState {}
