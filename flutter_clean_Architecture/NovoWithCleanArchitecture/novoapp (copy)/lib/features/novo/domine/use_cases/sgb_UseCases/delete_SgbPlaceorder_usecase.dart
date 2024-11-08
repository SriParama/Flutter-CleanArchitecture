import 'package:fpdart/fpdart.dart';
import 'package:novoapp/core/error/failure.dart';
import 'package:novoapp/core/usecase/usecase.dart';
import 'package:novoapp/features/novo/domine/entity/sgbPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class DeleteSGBplaceOrderUseCase
    implements UseCase<Map<String, dynamic>, SGBplaceOrderEntity> {
  final NovoRepository repository;

  DeleteSGBplaceOrderUseCase({required this.repository});

  // Future<Map<String, dynamic>> postSGBplaceOrderUseCase(
  //     Map<String, dynamic> postBidDetails) async {
  //   try {
  //     return await repository.postSGBplaceOrder(postBidDetails);
  //   } catch (e) {
  //     // Handle or log the error as necessary
  //     //print('Error in GetSbgMasterDatailsUseCase: $e');
  //     // Re-throw the exception to be handled by the caller
  //     throw Exception('Failed to post SGB Order details');
  //   }
  // }

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      SGBplaceOrderEntity sgBplaceOrderEntity) async {
    return await repository.deleteSGBplaceOrder(sgBplaceOrderEntity);
  }
}
