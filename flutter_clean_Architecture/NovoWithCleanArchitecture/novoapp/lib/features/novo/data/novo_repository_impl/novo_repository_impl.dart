import 'package:novoapp/features/novo/data/novo_data_source/novo_remote_data_sources.dart';
import 'package:novoapp/features/novo/domine/novo_repository/novo_repository.dart';

class NovoRepositoryImpl implements NovoRepository {
  final NovoRemoteDataSource remoteDataSource;
  NovoRepositoryImpl({required this.remoteDataSource});
  @override
  Future<String> getClientId() async => remoteDataSource.getClientId();

  @override
  Future getDashBoardDetails() async => remoteDataSource.getDashBoardDetails();
}
