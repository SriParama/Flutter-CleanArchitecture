part of 'gsec_fetch_data_cubit.dart';

sealed class GsecFetchDataState extends Equatable {
  const GsecFetchDataState();

  @override
  List<Object> get props => [];
}

final class GsecFetchDataInitial extends GsecFetchDataState {}

final class GsecInvestDataLoaded extends GsecFetchDataState {
  final GsecInvestDetailsModel gsecInvestDetailsModel;

  const GsecInvestDataLoaded({
    required this.gsecInvestDetailsModel,
  });
  @override
  List<Object> get props => [gsecInvestDetailsModel];
}

final class GsecInvestDataLoading extends GsecFetchDataState {
  // String failureMsg;
  // const GsecInvestDataFailed({})
}

final class GsecInvestDataFailed extends GsecFetchDataState {
  // String failureMsg;
  // const GsecInvestDataFailed({})
}

final class GsecOrderDataLoaded extends GsecFetchDataState {
  final GsecOrderDetailsModel gsecOrderDetailsModel;

  const GsecOrderDataLoaded({
    required this.gsecOrderDetailsModel,
  });
  @override
  List<Object> get props => [gsecOrderDetailsModel];
}

final class GsecOrderDataFailed extends GsecFetchDataState {}

final class GsecOrderDataLoading extends GsecFetchDataState {}
