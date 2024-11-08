// ignore_for_file: unused_field, prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_local_variable, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:crypto/crypto.dart';
import 'package:novoapp/core/common/show_snackbar.dart';
import 'package:novoapp/core/commonWidgets/loader.dart';
import 'package:novoapp/core/route/onGenerateRoute.dart';
import 'package:novoapp/features/auth/domine/enities/getotp_enitity.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/loginWithPwdPage.dart';
import 'package:novoapp/features/auth/presentation/widgets/login_Widgets/auth_button.dart';
import 'package:novoapp/features/auth/presentation/widgets/login_Widgets/auth_field.dart';

class GetOtpPage extends StatefulWidget {
  const GetOtpPage({super.key});
  @override
  State<GetOtpPage> createState() => _GetOtpPageState();
}

class _GetOtpPageState extends State<GetOtpPage> {
  TextEditingController _useridController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  TextEditingController _panController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthGetOtpState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
              (route) => false);
          showSnackBar(context, 'OTP Send Successfully');
        } else if (state is AuthFailureState) {
          showSnackBar(context, state.failureMsg);
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const Loader();
        } else {
          return _bodyWidget();
        }
      },
    ));
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
              Center(
                child: Container(
                  height: 22.0,
                  width: 147.0,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/flattrade_logo.png"))),
                ),
              ),
              SizedBox(height: myHeight * 0.025),
              /* Textform field validation */
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* Userid validation */
                    SizedBox(height: myHeight * 0.025),
                    NameField(
                      userIdController: _useridController,
                      labelname: "Client ID",
                    ),
                    SizedBox(height: myHeight * 0.025),
                    /* Password validation */
                    PanCardField(
                      panController: _panController,
                      labelname: "Pan",
                    ),
                    SizedBox(height: myHeight * 0.025),
                    /* pancard Or dateofbirth validation */
                  ],
                ),
              ),
              SizedBox(height: myHeight * 0.055),
              AuthButton(
                  btnfuc: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(AuthGetOtpEvent(
                          getOtpEntity: GetOtpEntity(
                              clientId: _useridController.text,
                              pan: _panController.text,
                              sid: '',
                              sid1: '')
                          // userId: _useridController.text.trim(),
                          // pan: _panController.text.trim(),
                          // dob: _dobController.text.trim(),
                          ));
                    }
                  },
                  btnName: "GETOTP"),
              SizedBox(height: myHeight * 0.050),
            ],
          ),
        ),
      ),
    );
  }
}
