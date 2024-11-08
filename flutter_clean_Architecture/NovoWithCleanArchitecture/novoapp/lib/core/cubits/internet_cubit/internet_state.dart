part of 'internet_cubit.dart';

sealed class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

final class InternetInitial extends InternetState {}

final class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final String status;
  InternetConnected({required this.status});
}

class InternetDisconnected extends InternetState {}
