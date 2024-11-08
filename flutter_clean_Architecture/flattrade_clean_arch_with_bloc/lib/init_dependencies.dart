import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flattrade/core/cubits/internet_cubit/internet_cubit.dart';
import 'package:flattrade/features/auth/data/auth_respoistory_impl/auth_reposistory_imp.dart';
import 'package:flattrade/features/auth/data/datasource/remote_data_sources.dart';
import 'package:flattrade/features/auth/data/datasource/remote_data_sources_impl.dart';
import 'package:flattrade/features/auth/domain/auth_reposistory/auth_resposistory.dart';
import 'package:flattrade/features/auth/domain/usecases/client_login_usecase.dart';
import 'package:flattrade/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:flattrade/features/auth/domain/usecases/get_opt_usecase.dart';
import 'package:flattrade/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.asNewInstance();
Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton(() => Connectivity());
  serviceLocator.registerLazySingleton(
      () => InternetCubit(connectivity: serviceLocator()));
  _initAuth();
}

_initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImp(authRemoteDataSource: serviceLocator()));

  serviceLocator
      .registerFactory(() => ClientLogin(authRepository: serviceLocator()));

  serviceLocator
      .registerFactory(() => GetOtp(authRepository: serviceLocator()));

  serviceLocator.registerFactory(
      () => ForgetPasswordUsecase(authRepository: serviceLocator()));

  serviceLocator.registerFactory(() => AuthBloc(
      clientLogin: serviceLocator(),
      getOtp: serviceLocator(),
      passwordUsecase: serviceLocator()));
}
