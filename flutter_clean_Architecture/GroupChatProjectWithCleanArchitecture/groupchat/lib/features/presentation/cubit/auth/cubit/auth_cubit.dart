import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groupchat/features/domine/usecases/get_create_current_user_usecase.dart';
import 'package:groupchat/features/domine/usecases/get_current_userId_usecase.dart';
import 'package:groupchat/features/domine/usecases/is_sign_in_usecase.dart';
import 'package:groupchat/features/domine/usecases/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUserIDUseCase getCurrentUserIDUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit(
      {required this.isSignInUseCase,
      required this.getCurrentUserIDUseCase,
      required this.signOutUseCase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignInUseCase.call();

      if (isSignIn) {
        final uid = await getCurrentUserIDUseCase.call();
        emit(AuthenticatedState(uid: uid));
      } else {
        emit(UnAuthenticatedState());
      }
    } on SocketException catch (_) {
      emit(UnAuthenticatedState());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUserIDUseCase.call();
      print("uid**********");
      print(uid);
      emit(AuthenticatedState(uid: uid));
    } catch (_) {
      emit(UnAuthenticatedState());
    }
  }

  Future<void> loggedOut() async {
    try {
      signOutUseCase.signOut();
      emit(UnAuthenticatedState());
    } catch (_) {
      emit(UnAuthenticatedState());
    }
  }
}
