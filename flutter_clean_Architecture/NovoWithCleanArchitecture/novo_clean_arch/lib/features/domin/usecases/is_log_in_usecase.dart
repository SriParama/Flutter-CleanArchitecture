import 'package:novo_clean_arch/features/data/remote_data_source/api_remote_data_source.dart';
import 'package:novo_clean_arch/features/domin/repositories/api_repository.dart';

class IsLogInUseCase {
  final ApiRepository repository;

  IsLogInUseCase({required this.repository});

  Future<bool> call() async {
    print("repository.islogin()");
    print(await repository.islogin());
    return await repository.islogin();
  }
}
