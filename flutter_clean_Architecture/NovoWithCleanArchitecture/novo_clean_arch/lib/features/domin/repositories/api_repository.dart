import 'package:flutter/widgets.dart';
import 'package:novo_clean_arch/features/domin/entities/forgetPwd_entity.dart';
import 'package:novo_clean_arch/features/domin/entities/getOtp_enitity.dart';
import 'package:novo_clean_arch/features/domin/entities/login_entity.dart';

import '../../data/remote_data_source/model/dash_board_model.dart';

abstract class ApiRepository {
  Future<void> login(
    LoginEntity login,
  );
  Future<bool> islogin();
  Future<String> getCurrentCookie();
  Future<void> logOut();
  Future<bool> forgetPwd(ForgetPwdEntity forgetPwdEntity);
  Future<bool> getOtp(GetOtpEntity getOtpEntity);
  Future<dynamic> getDashBoardDetails();
  Future<String> getClientId();
}
