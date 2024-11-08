import 'package:fpdart/fpdart.dart';
import 'package:novoapp/core/error/failure.dart';
import 'package:novoapp/core/usecase/usecase.dart';
import 'package:novoapp/features/novo/domine/entity/gsecPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/domine/entity/sgbPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class DeleteGsecplaceOrderUseCase
    implements UseCase<Map<String, dynamic>, GsecplaceOrderEntity> {
  final NovoRepository repository;

  DeleteGsecplaceOrderUseCase({required this.repository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      GsecplaceOrderEntity gsecplaceOrderEntity) async {
    return await repository.deleteGsecplaceOrder(gsecplaceOrderEntity);
  }
}
