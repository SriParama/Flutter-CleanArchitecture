import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:novo_clean_arch/features/data/remote_data_source/api_remote_data_source.dart';
import 'package:novo_clean_arch/features/data/remote_data_source/model/dash_board_model.dart';
import 'package:novo_clean_arch/features/domin/entities/forgetPwd_entity.dart';
import 'package:novo_clean_arch/features/domin/entities/getOtp_enitity.dart';
import 'package:novo_clean_arch/features/domin/entities/login_entity.dart';
import 'package:novo_clean_arch/features/domin/repositories/api_repository.dart';
import 'package:http/http.dart' as http;

class ApiRepositoryImpl implements ApiRepository {
  final ApiRemoteDataSource remoteDataSource;
  ApiRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> login(LoginEntity login) async => remoteDataSource.login(login);

  @override
  Future<bool> islogin() async => remoteDataSource.isLogin();

  @override
  Future<String> getCurrentCookie() async =>
      remoteDataSource.getCurrentCookie();

  @override
  Future<void> logOut() async => remoteDataSource.logOut();

  @override
  Future<dynamic> getDashBoardDetails() async =>
      remoteDataSource.getDashBoardDetails();

  @override
  Future<String> getClientId() async => remoteDataSource.getClientId();

  @override
  Future<bool> forgetPwd(ForgetPwdEntity forgetPwdEntity) async =>
      await remoteDataSource.forgetPwd(forgetPwdEntity);

  @override
  Future<bool> getOtp(GetOtpEntity getOtpEntity) async =>
      await remoteDataSource.getOtp(getOtpEntity);
}
