import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groupchat/features/data/remote_data_source/firebase_remote_data_source.dart';
import 'package:groupchat/features/data/remote_data_source/firebase_remote_data_source_impl.dart';
import 'package:groupchat/features/data/repositories/firebase_repository_impl.dart';
import 'package:groupchat/features/domine/repositories/firebase_repository.dart';
import 'package:groupchat/features/domine/usecases/forgot_password_usecase.dart';
import 'package:groupchat/features/domine/usecases/get_all_users_usecase.dart';
import 'package:groupchat/features/domine/usecases/get_create_current_user_usecase.dart';
import 'package:groupchat/features/domine/usecases/get_current_userId_usecase.dart';
import 'package:groupchat/features/domine/usecases/get_update_user_usecase.dart';
import 'package:groupchat/features/domine/usecases/google_auth_usecase.dart';
import 'package:groupchat/features/domine/usecases/is_sign_in_usecase.dart';
import 'package:groupchat/features/domine/usecases/sign_in_usecase.dart';
import 'package:groupchat/features/domine/usecases/sign_out_usecase.dart';
import 'package:groupchat/features/domine/usecases/sign_up_usecase.dart';
import 'package:groupchat/features/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:groupchat/features/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:groupchat/features/presentation/cubit/user/cubit/user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
//bloc

  sl.registerFactory<AuthCubit>(() => AuthCubit(
      isSignInUseCase: sl.call(),
      getCurrentUserIDUseCase: sl.call(),
      signOutUseCase: sl.call()));
  sl.registerFactory<UserCubit>(() => UserCubit(
      getAllUsersUseCase: sl.call(), getUpdateUserUseCase: sl.call()));

  sl.registerFactory<CredentialCubit>(() => CredentialCubit(
      signInUseCase: sl.call(),
      signUpUseCase: sl.call(),
      forgotPasswordUseCase: sl.call(),
      getCreateCurrentUserUseCase: sl.call(),
      googleAuthUseCase: sl.call()));

//UseCases

  //AuthCubit UseCases...

  sl.registerLazySingleton<GetCurrentUserIDUseCase>(
      () => GetCurrentUserIDUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));

  //UserCubit UseCases...
  sl.registerLazySingleton<GetUpdateUserUseCase>(
      () => GetUpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(repository: sl.call()));

  //CredentialCubit UseCases...

  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));

  sl.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));

  sl.registerLazySingleton<GoogleAuthUseCase>(
      () => GoogleAuthUseCase(repository: sl.call()));

//Repository

  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

//Remote DataSource

  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(
          fireStore: sl.call(), auth: sl.call(), googleSignIn: sl.call()));

//LocalSource

//External

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final googleSignIn = GoogleSignIn();

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => googleSignIn);
}
