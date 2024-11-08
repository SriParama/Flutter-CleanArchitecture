import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginEntity extends Equatable {
  final String? clientId;
  final String? password;
  final String? pan;
  // final BuildContext? context;

  const LoginEntity({
    this.clientId,
    this.password,
    this.pan,
    // this.context,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [clientId, password, pan];
}
