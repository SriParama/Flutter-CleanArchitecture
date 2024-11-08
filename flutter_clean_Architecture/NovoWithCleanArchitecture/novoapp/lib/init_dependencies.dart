import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
import 'package:novoapp/features/novo/domine/use_cases/getDashBoard_usecase.dart';
import 'package:novoapp/features/novo/domine/use_cases/get_clientid_usecase.dart';
import 'package:novoapp/features/novo/presentation/bloc/Fetch_data_Cubit/fetch_data_cubit.dart';

final serviceLocator = GetIt.asNewInstance();

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton(() => Connectivity());
  serviceLocator.registerLazySingleton(
      () => InternetCubit(connectivity: serviceLocator()));
  _initAuth();
}

_initAuth() {
  //AuthRepositoryImpl.....
  serviceLocator
      .registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: serviceLocator()));
  serviceLocator
      .registerFactory<NovoRemoteDataSource>(() => NovoRemoteDataSourceImpl());
  serviceLocator.registerFactory<NovoRepository>(
      () => NovoRepositoryImpl(remoteDataSource: serviceLocator()));

//Usecases Register....

  serviceLocator
      .registerFactory(() => LoginUseCase(authRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => ForgetPwdUseCase(authRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => GetOtpUseCase(authRepository: serviceLocator()));
  // serviceLocator.registerFactory(
  //     () => IsLoggedInUseCase(authRepository: serviceLocator()));
  // serviceLocator.registerFactory(
  //     () => LoggedOutUseCase(authRepository: serviceLocator()));
  // serviceLocator.registerFactory(
  //     () => GetCurrentCookieUseCase(authRepository: serviceLocator()));
  // serviceLocator.registerLazySingleton<GetCurrentCookieUseCase>(
  //     () => GetCurrentCookieUseCase(repository: serviceLocator.call()));
  serviceLocator.registerLazySingleton<IsLoggedInUseCase>(
      () => IsLoggedInUseCase(repository: serviceLocator.call()));
  serviceLocator.registerLazySingleton<LoggedOutUseCase>(
      () => LoggedOutUseCase(repository: serviceLocator.call()));
  serviceLocator.registerLazySingleton<GetDashBoardUseCase>(
      () => GetDashBoardUseCase(repository: serviceLocator.call()));
  serviceLocator.registerLazySingleton<GetClientIDUseCase>(
      () => GetClientIDUseCase(repository: serviceLocator.call()));

//AuthBloc Register
  serviceLocator.registerFactory(() => AuthBloc(
      loginUseCase: serviceLocator(),
      forgetPwdUseCase: serviceLocator(),
      getOtpUseCase: serviceLocator()));
  serviceLocator.registerFactory(() => AuthCookieCubit(
        isLoggedInUseCase: serviceLocator(),
        loggedOutUseCase: serviceLocator(),
        // getCurrentCookieUseCase: serviceLocator()
      ));

  serviceLocator.registerFactory<FetchDataCubit>(() => FetchDataCubit(
      getClientIDUseCase: serviceLocator(),
      getDashBoardUseCase: serviceLocator()));
}
