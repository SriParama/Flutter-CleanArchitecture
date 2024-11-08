import 'package:novoapp/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<Successtype, Params> {
  Future<Either<Failure, Successtype>> call(Params params);
}

abstract interface class UseCaseNoParams<Successtype> {
  Future<Either<Failure, Successtype>> call();
}
