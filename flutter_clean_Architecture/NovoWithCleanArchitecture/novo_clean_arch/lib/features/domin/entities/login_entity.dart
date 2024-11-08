import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String? clientId;
  final String? password;
  final String? pan;

  LoginEntity({
    this.clientId,
    this.password,
    this.pan,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        clientId,
        password,
        pan,
      ];
}
