part of 'fetch_cubit.dart';

abstract class FetchState extends Equatable {
  const FetchState();
}

final class FetchInitial extends FetchState {
  @override
  List<Object> get props => [];
}

final class FetchLoading extends FetchState {
  @override
  List<Object> get props => [];
}

final class FetchLoaded extends FetchState {
  final DashboardEntity dashboardData;
  final String clientId;

  const FetchLoaded({required this.dashboardData, required this.clientId});
  @override
  List<Object> get props => [dashboardData, clientId];
}

final class FetchFailure extends FetchState {
  @override
  List<Object> get props => [];
}
