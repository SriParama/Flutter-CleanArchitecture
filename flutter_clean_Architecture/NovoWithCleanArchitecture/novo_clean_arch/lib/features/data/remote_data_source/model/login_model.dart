import 'package:novo_clean_arch/features/domin/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    final String? clientId,
    final String? password,
    final String? pan,
  }) : super(
          clientId: clientId,
          password: password,
          pan: pan,
        );

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      clientId: json['clientId'],
      password: json['password'],
      pan: json['pan'],
    );
  }
}
