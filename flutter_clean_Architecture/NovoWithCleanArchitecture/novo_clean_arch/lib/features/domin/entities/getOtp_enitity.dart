import 'package:equatable/equatable.dart';

class GetOtpEntity extends Equatable {
  final String? userId;
  final String? pan;

  GetOtpEntity({
    this.userId,
    this.pan,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        userId,
        pan,
      ];
}
