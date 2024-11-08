import 'package:fpdart/src/either.dart';
import 'package:novoapp/core/error/failure.dart';
import 'package:novoapp/core/usecase/usecase.dart';
import 'package:novoapp/features/auth/domine/auth_repository/auth_repository.dart';
import 'package:novoapp/features/auth/domine/enities/login_entity.dart';

// class LoggedOutUseCase implements UseCaseNoParams {
//   final AuthRepository authRepository;

//   LoggedOutUseCase({required this.authRepository});

//   @override
//   Future<Either<Failure, bool>> call() async {
//     return await authRepository.logout();
//   }
// }

class LoggedOutUseCase {
  final AuthRepository repository;

  LoggedOutUseCase({required this.repository});

  Future<void> call() {
    return repository.logout();
  }
}
