import 'package:flutter/material.dart';
import 'package:fpdart/src/either.dart';
import 'package:novoapp/core/error/failure.dart';
import 'package:novoapp/core/usecase/usecase.dart';
import 'package:novoapp/features/auth/domine/auth_repository/auth_repository.dart';
import 'package:novoapp/features/auth/domine/enities/login_entity.dart';

class LoginUseCase implements UseCase<Map<String, dynamic>, LoginEntity> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  // @override
  // Future<Either<Failure, Map<String, dynamic>>> call(LoginEntity params) {
  //   // TODO: implement call
  //   throw UnimplementedError();
  // }

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
    LoginEntity loginEntity,
  ) async {
    return await authRepository.logIn(loginEntity);
  }
}
