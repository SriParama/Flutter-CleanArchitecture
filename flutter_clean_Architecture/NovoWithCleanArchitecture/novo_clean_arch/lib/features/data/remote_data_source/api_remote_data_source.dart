import 'package:flutter/widgets.dart';
import 'package:novo_clean_arch/features/data/remote_data_source/model/dash_board_model.dart';
import 'package:novo_clean_arch/features/domin/entities/dash_board_entity.dart';
import 'package:novo_clean_arch/features/domin/entities/forgetPwd_entity.dart';
import 'package:novo_clean_arch/features/domin/entities/getOtp_enitity.dart';

import '../../domin/entities/login_entity.dart';
import 'package:http/http.dart' as http;

abstract class ApiRemoteDataSource {
  Future<void> login(LoginEntity login);
  Future<bool> isLogin();
  Future<String> getCurrentCookie();
  Future<void> logOut();
  Future<bool> forgetPwd(ForgetPwdEntity forgetPwdEntity);
  Future<bool> getOtp(GetOtpEntity getOtpEntity);
  Future<DashboardEntity> getDashBoardDetails();
  Future<String> getClientId();
}
