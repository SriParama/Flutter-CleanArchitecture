import 'package:groupchat/features/domine/repositories/firebase_repository.dart';

class GoogleAuthUseCase {
  final FirebaseRepository repository;

  GoogleAuthUseCase({required this.repository});

  Future<void> gooleAuth() async {
    return await repository.googleAuth();
  }
}
