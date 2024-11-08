// ignore_for_file: unused_field, prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_local_variable, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:novo_clean_arch/appconst.dart';
import 'package:novo_clean_arch/features/domin/entities/login_entity.dart';
import 'package:novo_clean_arch/features/presentation/pages/forget_password.dart';

import '../cubit/auth/cubit/auth_cubit.dart';
import '../cubit/credential/cubit/credential_cubit.dart';
import '../widget/custom_button_widget.dart';
import '../widget/text_container.dart';
import '../widget/text_pwd_container_widget.dart';
import 'package:crypto/crypto.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingController userIdController = TextEditingController();
  // //karthikraja=FT032287
  // //Lakshmanan Sir=FT000069
  // //sri=FT034528
  // //thangareen=FT034568
  // TextEditingController passwordController = TextEditingController();
  // //karthikraja=Aaa@111
  // //Lakshmanan Sir=Demo@1111
  // //sri=Wqsb-852
  // //thangareena=smile@1A
  // TextEditingController pancardController = TextEditingController();
  //karthikraja=EXPPK4076L
  //Lakshmanan Sir=AGMPA8575C
  //sri=DSGPA0038D
  //thangareena=NISPS8983P
  TextEditingController userIdController =
      TextEditingController(text: 'FT034528');
  TextEditingController passwordController =
      TextEditingController(text: 'GMzc*894');
  TextEditingController pancardController =
      TextEditingController(text: '13012000');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            print('Autheniticated success....');
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            print('Invalid Email and Password');
          }
        },
        builder: (context, credenticalState) {
          if (credenticalState is CredentialLoading) {
            print('loading');
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          if (credenticalState is CredentialSuccess) {
            print('loginSuccess');
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  print('HomePageSucces');
                  return HomePage(
                    cookie: authState.cookie,
                    // uid: authState.uid,
                  );
                } else {
                  print('homepagelogin else');
                  return _bodyWidget();
                }
              },
            );
          }

          return _bodyWidget();
        },
      ),
    );
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
              // Center(
              //   child: Container(
              //     height: 22.0,
              //     width: 147.0,
              //     decoration: const BoxDecoration(
              //         image: DecorationImage(
              //             image:
              //                 AssetImage("assets/flattrade_logo.png"))),
              //   ),
              // ),
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
                  TextPwdFieldContainer(
                    controller: passwordController,
                    hintText: 'Enter your Password',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.lock,
                    sufixIcon: Icons.remove_red_eye_rounded,
                  ),
                  SizedBox(height: myHeight * 0.025),
                  /* pancard Or dateofbirth validation */
                  TextPwdFieldContainer(
                    controller: pancardController,
                    hintText: 'Enter your Password',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.lock,
                    sufixIcon: Icons.remove_red_eye_rounded,
                  ),
                ],
              ),
              SizedBox(height: myHeight * 0.025),
              SizedBox(height: myHeight * 0.055),
              ContainerButtonWidget(
                title: 'LogIn',
                onTap: () {
                  _submitLogin();
                  print('Click the login');
                },
              ),
              SizedBox(height: myHeight * 0.050),
              ContainerButtonWidget(
                title: 'ForgotPassword',
                onTap: () {
                  // _submitLogin();
                  Navigator.pushNamed(context, PageConst.forgotPasswordPage);
                  print('Click the forget');
                },
              ),
              SizedBox(height: myHeight * 0.050),
              ContainerButtonWidget(
                title: 'GetOtp',
                onTap: () {
                  // _submitLogin();
                  Navigator.pushNamed(context, PageConst.getOtpPage);
                  print('Click the forget');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitLogin() {
    if (userIdController.text.isEmpty) {
      return;
    }
    if (passwordController.text.isEmpty) {
      return;
    }
    var bytes = utf8.encode(passwordController.text);
    var hash = sha256.convert(bytes);
    BlocProvider.of<CredentialCubit>(context).submitSignIn(
      user: LoginEntity(
          clientId: userIdController.text,
          password: hash.toString(),
          pan: pancardController.text),
    );
    print("    BlocProvider.of<CredentialCubit>(context).submitSignI");
    print(BlocProvider.of<CredentialCubit>(context).submitSignIn(
      user: LoginEntity(
          clientId: userIdController.text,
          password: hash.toString(),
          pan: pancardController.text),
    ));
  }
}
