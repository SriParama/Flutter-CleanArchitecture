import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:novo_clean_arch/appconst.dart';
import 'package:novo_clean_arch/features/domin/entities/forgetPwd_entity.dart';
import 'package:novo_clean_arch/features/domin/entities/getOtp_enitity.dart';
import 'package:novo_clean_arch/features/domin/entities/login_entity.dart';
import 'package:novo_clean_arch/features/domin/usecases/forget_pwd_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/forget_pwd_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/getOtp_usecase.dart';
import 'package:novo_clean_arch/features/domin/usecases/log_in_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final LoginUseCase loginUseCase;
  final ForgetPwdUseCase forgetPwdUseCase;
  final GetOtpUseCase getOtpUseCase;

  CredentialCubit(
      {required this.loginUseCase,
      required this.forgetPwdUseCase,
      required this.getOtpUseCase})
      : super(CredentialInitial());

  Future<void> submitSignIn({required LoginEntity user}) async {
    emit(CredentialLoading());
    try {
      var loginRes = await loginUseCase.login(user);
      loginRes;

      emit(CredentialSuccess());
    } on SocketException {
      emit(CredentialFailure());
    } catch (e) {
      emit(CredentialFailure());
    }
  }

  Future<void> submitForgetPwd(
      {required ForgetPwdEntity forgetPwdEntity,
      required BuildContext context}) async {
    emit(CredentialLoading());
    try {
      print('forgetpwd');
      bool forgetPwd = await forgetPwdUseCase.call(forgetPwdEntity);
      // forgetPwd;
      print("forgetPwd");
      print(forgetPwd);
      if (forgetPwd) {
        print('forgetPwd');
        Navigator.pushNamedAndRemoveUntil(
            context, PageConst.loginPage, (route) => false);
        emit(CredentialSuccess());
      }
    } on SocketException {
      emit(CredentialFailure());
      // return false;
    } catch (e) {
      print('catch' + e.toString());
      emit(CredentialFailure());
      // return false;
    }
  }

  Future<void> submitOtp(
      {required GetOtpEntity getOtpEntity,
      required BuildContext context}) async {
    emit(CredentialLoading());
    try {
      print('getOTp');
      bool getOtp = await getOtpUseCase.call(getOtpEntity);
      // forgetPwd;
      print("getOTp");
      print(getOtp);
      if (getOtp) {
        print('getOtp');
        Navigator.pushNamedAndRemoveUntil(
            context, PageConst.loginPage, (route) => false);
        emit(CredentialSuccess());
      }
    } on SocketException {
      emit(CredentialFailure());
      // return false;
    } catch (e) {
      print('catch' + e.toString());
      emit(CredentialFailure());
      // return false;
    }
  }
}
