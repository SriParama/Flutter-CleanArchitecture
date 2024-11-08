// ignore_for_file: unused_field, prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_local_variable, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:novo_clean_arch/features/domin/entities/forgetPwd_entity.dart';
import 'package:novo_clean_arch/features/domin/entities/getOtp_enitity.dart';
import 'package:novo_clean_arch/features/domin/entities/login_entity.dart';

import '../cubit/auth/cubit/auth_cubit.dart';
import '../cubit/credential/cubit/credential_cubit.dart';
import '../widget/custom_button_widget.dart';
import '../widget/text_container.dart';
import '../widget/text_pwd_container_widget.dart';
import 'package:crypto/crypto.dart';

import 'home_page.dart';

class GetOtpPage extends StatefulWidget {
  const GetOtpPage({super.key});
  @override
  State<GetOtpPage> createState() => _GetOtpPageState();
}

class _GetOtpPageState extends State<GetOtpPage> {
  TextEditingController userIdController = TextEditingController();

  TextEditingController pancardController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _bodyWidget());
  }

  _bodyWidget() {
    double myHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: myHeight * 0.025),
              SizedBox(height: myHeight * 0.025),
              /* Textform field validation */
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* Userid validation */
                  SizedBox(height: myHeight * 0.025),
                  TextFieldContainer(
                    controller: userIdController,
                    hintText: 'Enter your User-Id',
                    isObscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                  ),
                  SizedBox(height: myHeight * 0.025),
                  /* Password validation */

                  /* pancard Or dateofbirth validation */
                  TextPwdFieldContainer(
                    controller: pancardController,
                    hintText: 'Enter your pAN',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.lock,
                    sufixIcon: Icons.remove_red_eye_rounded,
                  ),
                ],
              ),
              SizedBox(height: myHeight * 0.055),
              ContainerButtonWidget(
                title: 'GET OTP',
                onTap: () {
                  _getOtp();
                  print('Click the ForgetPwd');
                },
              ),
              SizedBox(height: myHeight * 0.050),
            ],
          ),
        ),
      ),
    );
  }

  void _getOtp() async {
    if (userIdController.text.isEmpty) {
      return;
    }
    if (pancardController.text.isEmpty) {
      return;
    }
    // var bytes = utf8.encode(dobController.text);
    // var hash = sha256.convert(bytes);
    BlocProvider.of<CredentialCubit>(context).submitOtp(
        context: context,
        getOtpEntity: GetOtpEntity(
            userId: userIdController.text, pan: pancardController.text));
    print("    BlocProvider.of<CredentialCubit>(context).submitOtp");
  }
}
