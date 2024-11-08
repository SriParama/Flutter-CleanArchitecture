import 'package:get_it/get_it.dart';
import 'package:novo_clean_arch/features/data/remote_data_source/api_remote_data_source.dart';
import 'package:novo_clean_arch/features/data/remote_data_source/api_remote_data_source_impl.dart';
import 'package:novo_clean_arch/features/data/repositories/api_repository_impl.dart';
import 'package:novo_clean_arch/features/domin/repositories/api_repository.dart';
import 'package:novo_clean_arch/features/domin/usecases/forget_pwd_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/getOtp_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/get_clieint_Id_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/get_current_cookie_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/get_dashBoard_datails_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/is_log_in_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/log_in_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/log_out_usecase.dart';
import 'package:novo_clean_arch/features/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:novo_clean_arch/features/presentation/cubit/fetchData/cubit/fetch_cubit.dart';

import 'features/presentation/cubit/auth/cubit/auth_cubit.dart';

final sl = GetIt.instance;

// Future<void> init() async {
//   sl.registerFactory<CredentialCubit>(() => CredentialCubit(
//         loginUseCase: sl.call(),
//       ));

//   sl.registerLazySingleton<LoginUseCase>(
//       () => LoginUseCase(repository: sl.call()));

//   sl.registerLazySingleton<ApiRepository>(
//       () => ApiRepositoryImpl(remoteDataSource: sl.call()));

//   sl.registerLazySingleton<ApiRemoteDataSource>(
//       () => ApiRemoteDataSourceImpl());
// }
Future<void> init() async {
  //BLOC Register.....
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      isLogInUseCase: sl.call(),
      getCurrentCookieUseCase: sl.call(),
      logOutUseCase: sl.call()));
  sl.registerFactory<CredentialCubit>(() => CredentialCubit(
      loginUseCase: sl.call(),
      forgetPwdUseCase: sl.call(),
      getOtpUseCase: sl.call()));

  sl.registerFactory<FetchCubit>(() => FetchCubit(
      getDashBoardDataUseCase: sl.call(), getClientIDUseCase: sl.call()));

  // Registering the UseCases

  //AuthUseCase
  sl.registerLazySingleton<GetCurrentCookieUseCase>(
      () => GetCurrentCookieUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsLogInUseCase>(
      () => IsLogInUseCase(repository: sl.call()));
  sl.registerLazySingleton<LogOutUseCase>(
      () => LogOutUseCase(repository: sl.call()));

  //Credential UseCase...

  sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(repository: sl.call()));
  sl.registerLazySingleton<ForgetPwdUseCase>(
      () => ForgetPwdUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetOtpUseCase>(
      () => GetOtpUseCase(repository: sl.call()));

  //Fetch UseCase....
  sl.registerLazySingleton<GetDashBoardDataUseCase>(
      () => GetDashBoardDataUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetClientIDUseCase>(
      () => GetClientIDUseCase(repository: sl.call()));

  // Registering the ApiRepository
  sl.registerLazySingleton<ApiRepository>(
      () => ApiRepositoryImpl(remoteDataSource: sl.call()));

  // Registering the ApiRemoteDataSource
  sl.registerLazySingleton<ApiRemoteDataSource>(
      () => ApiRemoteDataSourceImpl());
}
