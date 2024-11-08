import 'package:flattrade/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract  class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> logIN(
    String factor, {
    required String userId,
    required String password,
  });


  Future<Either<Failure, Map<String, dynamic>>> getOtp(
   {
    required String userId,
    required String password,
  });
  
  Future<Either<Failure, Map<String, dynamic>>> forgetPasaword(
   {
    required String userId,
    required String pan,
    required String dob
  });

}
