part of 'sgb_fetch_data_cubit.dart';

sealed class SgbFetchDataState extends Equatable {
  const SgbFetchDataState();

  @override
  List<Object> get props => [];
}

final class SgbFetchDataInitial extends SgbFetchDataState {}

final class SGBinvestDataLoaded extends SgbFetchDataState {
  final SGBinvestDetailsModel sgbInvestDetailsModel;
  final dynamic sgbFetchFund;
  // final SGBorderDetialsModel sgbOrderDetialsModel;
  const SGBinvestDataLoaded({
    required this.sgbInvestDetailsModel,
    required this.sgbFetchFund,
    // required this.sgbOrderDetialsModel,
  });
  @override
  List<Object> get props => [sgbInvestDetailsModel, sgbFetchFund];
}

final class SGBorderDataLoaded extends SgbFetchDataState {
  final SGBinvestDetailsModel sgbInvestDetailsModel;
  final SGBorderDetialsModel sgbOrderDetialsModel;
  final dynamic sgbFetchFund;
  const SGBorderDataLoaded({
    required this.sgbInvestDetailsModel,
    required this.sgbOrderDetialsModel,
    required this.sgbFetchFund,
  });
  @override
  List<Object> get props =>
      [sgbInvestDetailsModel, sgbOrderDetialsModel, sgbFetchFund];
}

final class SGBinvestDataFailure extends SgbFetchDataState {
  @override
  List<Object> get props => [];
}

final class SGBorderDataFailure extends SgbFetchDataState {
  @override
  List<Object> get props => [];
}
