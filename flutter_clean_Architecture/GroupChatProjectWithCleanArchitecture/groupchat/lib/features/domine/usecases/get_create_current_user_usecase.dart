import 'package:groupchat/features/domine/entities/user_entity.dart';
import 'package:groupchat/features/domine/repositories/firebase_repository.dart';

class GetCreateCurrentUserUseCase {
  final FirebaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> getCreateCurrentUserUseCase(UserEntity user) {
    return repository.getCreateCurrentUser(user);
  }
}
