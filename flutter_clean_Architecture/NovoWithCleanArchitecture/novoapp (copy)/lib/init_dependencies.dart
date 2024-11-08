import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:novoapp/core/ThemeBloc/theme_bloc.dart';
import 'package:novoapp/core/cubits/IndexChange_cubit/index_change_cubit.dart';
import 'package:novoapp/core/cubits/internet_cubit/internet_cubit.dart';
import 'package:novoapp/features/auth/data/auth_repository_impl/auth_repository_impl.dart';
import 'package:novoapp/features/auth/data/data_source/remote_data_sources.dart';
import 'package:novoapp/features/auth/data/data_source/remote_data_sources_impl.dart';
import 'package:novoapp/features/auth/domine/auth_repository/auth_repository.dart';
import 'package:novoapp/features/auth/domine/use_cases/forgetpwd_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/getCurrentCookie_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/getotp_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/is_LoggedIn_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/logged_out_usecase.dart';
import 'package:novoapp/features/auth/domine/use_cases/login_usecase.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie/auth_cookie_bloc.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
import 'package:novoapp/features/novo/data/novo_data_source/novo_remote_data_source_impl.dart';
import 'package:novoapp/features/novo/data/novo_data_source/novo_remote_data_sources.dart';
import 'package:novoapp/features/novo/data/novo_repository_impl/novo_repository_impl.dart';
import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';
import 'package:novoapp/features/novo/domine/use_cases/gsec_useCases/delete_GsecPlaceorder_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/gsec_useCases/get_GsecMaster_details_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/gsec_useCases/get_Gsecorder_details_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/gsec_useCases/post_GsecPlaceorder_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/novo_UseCases/getDashBoard_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/novo_UseCases/get_clientName_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/novo_UseCases/get_clientid_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/sgb_UseCases/delete_SgbPlaceorder_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/sgb_UseCases/getAccountBalance_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/sgb_UseCases/get_SGBorder_details_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/sgb_UseCases/get_SgbMaster_details_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/sgb_UseCases/post_SgbPlaceorder_usecase.dart';
import 'package:novoapp/features/novo/presentation/bloc/Gsec_PlaceOrder_Bloc/post_gsec_order_bloc.dart';
import 'package:novoapp/features/novo/presentation/bloc/SGB_PlaceOrder_Bloc/post_sgb_order_bloc.dart';
import 'package:novoapp/features/novo/presentation/cubit/Fetch_data_Cubit/fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/cubit/Gsec_fetch_data_Cubit/gsec_fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/cubit/Sgb_FetchData_Cubit/sgb_fetch_data_cubit.dart';

final serviceLocator = GetIt.asNewInstance();

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton(() => Connectivity());
  serviceLocator.registerLazySingleton(
      () => InternetCubit(connectivity: serviceLocator()));
  _initAuth();
}

_initAuth() {
//RegisterFacotories...

//General...
  // serviceLocator.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
  serviceLocator.registerFactory<IndexChangeCubit>(() => IndexChangeCubit());
//Authenticaitons Registers...
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: serviceLocator()));
  serviceLocator
      .registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());

  //Login/Otp/Forget

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  serviceLocator.registerFactory(() => AuthBloc(
      loginUseCase: serviceLocator(),
      forgetPwdUseCase: serviceLocator(),
      getOtpUseCase: serviceLocator()));

  // Login/Otp/Forget  RegisterLazySingleTon
  serviceLocator.registerLazySingleton(
      () => LoginUseCase(authRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => ForgetPwdUseCase(authRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetOtpUseCase(authRepository: serviceLocator()));

//------------------------------------------------------------------------------

  //AuthCubit Cookies Register....

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  serviceLocator.registerFactory(() => AuthCookieCubit(
        isLoggedInUseCase: serviceLocator(),
        loggedOutUseCase: serviceLocator(),
      ));
  //  isLoggedInUseCase/loggedOutUseCase  RegisterLazySingleTon

  serviceLocator.registerLazySingleton<IsLoggedInUseCase>(
      () => IsLoggedInUseCase(repository: serviceLocator.call()));
  serviceLocator.registerLazySingleton<LoggedOutUseCase>(
      () => LoggedOutUseCase(repository: serviceLocator.call()));

//------------------------------------------------------------------------------

  //NovoImply Registers....

  serviceLocator.registerFactory<NovoRepository>(
      () => NovoRepositoryImpl(remoteDataSource: serviceLocator()));
  serviceLocator
      .registerFactory<NovoRemoteDataSource>(() => NovoRemoteDataSourceImpl());

//FetchDetails Register....

//DashBoardDetials Register...

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  serviceLocator.registerFactory<FetchDataCubit>(() => FetchDataCubit(
      getClientIDUseCase: serviceLocator(),
      getClientNameUseCase: serviceLocator(),
      getDashBoardUseCase: serviceLocator()));

//   getClientIDUseCase/getClientNameUseCase/getDashBoardUseCase  RegisterLazySingleTon

  serviceLocator.registerLazySingleton<GetDashBoardUseCase>(
      () => GetDashBoardUseCase(repository: serviceLocator.call()));
  serviceLocator.registerLazySingleton<GetClientIDUseCase>(
      () => GetClientIDUseCase(repository: serviceLocator.call()));
  serviceLocator.registerLazySingleton<GetClientNameUseCase>(
      () => GetClientNameUseCase(repository: serviceLocator.call()));
//------------------------------------------------------------------------------

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  serviceLocator.registerFactory<SgbFetchDataCubit>(() => SgbFetchDataCubit(
      getSGBinvestDatailsUseCase: serviceLocator(),
      getSGBorderDatailsUseCase: serviceLocator(),
      getAccountBalanceUseCase: serviceLocator()));

//   getClientIDUseCase/getClientNameUseCase/getDashBoardUseCase  RegisterLazySingleTon

  serviceLocator.registerLazySingleton<GetSGBinvestDatailsUseCase>(
      () => GetSGBinvestDatailsUseCase(repository: serviceLocator.call()));

  serviceLocator.registerLazySingleton<GetAccountBalanceUseCase>(
      () => GetAccountBalanceUseCase(repository: serviceLocator.call()));
  serviceLocator.registerLazySingleton<GetSGBorderDatailsUseCase>(
      () => GetSGBorderDatailsUseCase(repository: serviceLocator.call()));

//------------------------------------------------------------------------------

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  serviceLocator.registerFactory(() => SgbOrderBloc(
      deleteSGBplaceOrderUseCase: serviceLocator.call(),
      postSGBplaceOrderUseCase: serviceLocator.call()));

  // Login/Otp/Forget  RegisterLazySingleTon
  serviceLocator.registerLazySingleton<PostSGBplaceOrderUseCase>(
      () => PostSGBplaceOrderUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton<DeleteSGBplaceOrderUseCase>(
      () => DeleteSGBplaceOrderUseCase(repository: serviceLocator()));

  //------------------------------------------------------------------------------

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  serviceLocator.registerFactory<GsecFetchDataCubit>(() => GsecFetchDataCubit(
      getGsecinvestDatailsUseCase: serviceLocator.call(),
      getGsecorderDatailsUseCase: serviceLocator.call()));

//   getClientIDUseCase/getClientNameUseCase/getDashBoardUseCase  RegisterLazySingleTon

  serviceLocator.registerLazySingleton<GetGsecinvestDatailsUseCase>(
      () => GetGsecinvestDatailsUseCase(repository: serviceLocator.call()));

  serviceLocator.registerLazySingleton<GetGsecorderDatailsUseCase>(
      () => GetGsecorderDatailsUseCase(repository: serviceLocator.call()));

//------------------------------------------------------------------------------

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  serviceLocator.registerFactory(() => GsecOrderBloc(
      postGsecplaceOrderUseCase: serviceLocator.call(),
      deleteGsecplaceOrderUseCase: serviceLocator.call()));

  // Login/Otp/Forget  RegisterLazySingleTon
  serviceLocator.registerLazySingleton<PostGsecplaceOrderUseCase>(
      () => PostGsecplaceOrderUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton<DeleteGsecplaceOrderUseCase>(
      () => DeleteGsecplaceOrderUseCase(repository: serviceLocator()));

  //------------------------------------------------------------------------------
}
