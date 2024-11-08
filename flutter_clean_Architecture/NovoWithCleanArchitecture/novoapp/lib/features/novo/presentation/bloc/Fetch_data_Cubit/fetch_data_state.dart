part of 'fetch_data_cubit.dart';

sealed class FetchDataState extends Equatable {
  const FetchDataState();

  @override
  List<Object> get props => [];
}

final class FetchDataInitial extends FetchDataState {}

final class FetchDataLoaded extends FetchDataState {
  final DashboardModel dashboardData;
  final String clientId;

  const FetchDataLoaded({required this.dashboardData, required this.clientId});
  @override
  List<Object> get props => [dashboardData, clientId];
}

final class FetchDataFailure extends FetchDataState {
  @override
  List<Object> get props => [];
}
