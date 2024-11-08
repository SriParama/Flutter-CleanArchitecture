import 'package:groupchat/features/domine/entities/user_entity.dart';
import 'package:groupchat/features/domine/repositories/firebase_repository.dart';

class SignInUseCase {
  final FirebaseRepository repository;

  SignInUseCase({required this.repository});

  Future<void> singIn(UserEntity user) async {
    return await repository.signIn(user);
  }
}
