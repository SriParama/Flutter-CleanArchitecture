import 'package:novo_clean_arch/features/domin/entities/forgetPwd_entity.dart';

class ForgetModel extends ForgetPwdEntity {
  ForgetModel({
    final String? clientId,
    final String? dob,
    final String? pan,
    final String? sid,
  }) : super(
          clientId: clientId,
          dob: dob,
          pan: pan,
          sid: sid,
        );

  factory ForgetModel.fromJson(Map<String, dynamic> json) {
    return ForgetModel(
        clientId: json['UserName'],
        pan: json['PAN'],
        dob: json['DOB'],
        sid: json['sid']);
  }
}
