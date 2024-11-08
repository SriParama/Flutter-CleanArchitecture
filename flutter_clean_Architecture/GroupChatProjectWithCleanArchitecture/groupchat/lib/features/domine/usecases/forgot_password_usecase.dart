import 'package:groupchat/features/domine/repositories/firebase_repository.dart';

class ForgotPasswordUseCase {
  final FirebaseRepository repository;

  ForgotPasswordUseCase({required this.repository});

  Future<void> forgetPassword(String email) {
    return repository.forgetPassword(email);
  }
}
