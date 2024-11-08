import 'package:fpdart/src/either.dart';
import 'package:novoapp/core/error/failure.dart';
import 'package:novoapp/core/usecase/usecase.dart';
import 'package:novoapp/features/auth/domine/enities/login_entity.dart';
import 'package:novoapp/features/novo/domine/entity/gsecPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/domine/entity/sgbPlaceOrderEntity.dart';
import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class PostGsecplaceOrderUseCase
    implements UseCase<Map<String, dynamic>, GsecplaceOrderEntity> {
  final NovoRepository repository;

  PostGsecplaceOrderUseCase({required this.repository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      GsecplaceOrderEntity gsecplaceOrderEntity) async {
    return await repository.postGsecplaceOrder(gsecplaceOrderEntity);
  }
}
