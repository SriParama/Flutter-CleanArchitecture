import 'package:fpdart/src/either.dart';
import 'package:novoapp/core/error/failure.dart';
import 'package:novoapp/core/usecase/usecase.dart';
import 'package:novoapp/features/auth/domine/auth_repository/auth_repository.dart';
import 'package:novoapp/features/auth/domine/enities/login_entity.dart';

// class IsLoggedInUseCase implements UseCaseNoParams {
//   final AuthRepository authRepository;
//   IsLoggedInUseCase({required this.authRepository});

//   @override
//   Future<bool> call() async {
//     return await authRepository.isLoggedIn();
//   }
// }

class IsLoggedInUseCase {
  final AuthRepository repository;

  IsLoggedInUseCase({required this.repository});

  Future<bool> call() async {
    return await repository.isLoggedIn();
  }
}
