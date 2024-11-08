import 'package:equatable/equatable.dart';

class GetOtpEntity extends Equatable {
  final String? clientId;
  final String? pan;
  final String? sid;
  final String? sid1;

  GetOtpEntity({this.clientId, this.pan, this.sid, this.sid1});

  @override
  // TODO: implement props
  List<Object?> get props => [clientId, pan, sid, sid1];
}
