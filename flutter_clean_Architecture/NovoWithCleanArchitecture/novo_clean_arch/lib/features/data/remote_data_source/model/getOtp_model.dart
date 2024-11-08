import 'package:novo_clean_arch/features/domin/entities/forgetPwd_entity.dart';
import 'package:novo_clean_arch/features/domin/entities/getOtp_enitity.dart';

class GetOtpModel extends GetOtpEntity {
  GetOtpModel({
    final String? userId,
    final String? pan,
    final String? sid,
    final String? sid1,
  }) : super(
          userId: userId,
          pan: pan,
        );

  factory GetOtpModel.fromJson(Map<String, dynamic> json) {
    return GetOtpModel(
      userId: json['UserName'],
      pan: json['PAN'],
    );
  }
}
