import 'package:groupchat/features/domine/repositories/firebase_repository.dart';

class GetCurrentUserIDUseCase {
  final FirebaseRepository repository;

  GetCurrentUserIDUseCase({required this.repository});

  Future<String> call() async {
    return await repository.getCurrentUserId();
  }
}
