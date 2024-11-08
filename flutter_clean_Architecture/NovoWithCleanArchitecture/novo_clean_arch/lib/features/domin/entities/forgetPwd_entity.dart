import 'package:equatable/equatable.dart';

class ForgetPwdEntity extends Equatable {
  final String? clientId;
  final String? dob;
  final String? pan;
  final String? sid;

  ForgetPwdEntity({
    this.clientId,
    this.dob,
    this.pan,
    this.sid,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [clientId, dob, pan, sid];
}
