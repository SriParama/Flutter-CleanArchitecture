import 'package:groupchat/features/domine/entities/user_entity.dart';
import 'package:groupchat/features/domine/repositories/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> signUp(UserEntity user) {
    return repository.signUp(user);
  }
}
