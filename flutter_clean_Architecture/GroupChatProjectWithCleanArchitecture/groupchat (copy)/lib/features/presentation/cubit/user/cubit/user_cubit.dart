import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groupchat/features/domine/usecases/get_update_user_usecase.dart';

import '../../../../domine/entities/user_entity.dart';
import '../../../../domine/usecases/get_all_users_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final GetUpdateUserUseCase getUpdateUserUseCase;
  UserCubit(
      {required this.getAllUsersUseCase, required this.getUpdateUserUseCase})
      : super(UserInitial());

  Future<void> getUsers() async {
    emit(UserLoading());
    try {
      getAllUsersUseCase.call().listen((listUsers) {
        emit(UserLoaded(users: listUsers));
      });
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> updateUser({required UserEntity user}) async {
    try {
      await getUpdateUserUseCase.call(user);
      // emit(UserLoaded(users: user));
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
