// ignore_for_file: unused_field, prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_local_variable, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:novoapp/core/common/show_snackbar.dart';
import 'package:novoapp/core/commonWidgets/loader.dart';
import 'package:novoapp/core/commonWidgets/textbutton_widget.dart';
import 'package:novoapp/core/cubits/internet_cubit/internet_cubit.dart';
import 'package:novoapp/core/route/onGenerateRoute.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/features/auth/domine/enities/login_entity.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie/auth_cookie_bloc.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/forgetPwd_page.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/getOtp_page.dart';

import 'package:novoapp/features/auth/presentation/widgets/login_Widgets/auth_button.dart';
import 'package:novoapp/features/auth/presentation/widgets/login_Widgets/auth_field.dart';
import 'package:novoapp/features/novo/presentation/pages/novo_MainScreen.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();
  TextEditingController userIdController =
      TextEditingController(text: 'FT034528');
  TextEditingController passwordController =
      TextEditingController(text: 'Sri@777');
  TextEditingController pancardController =
      TextEditingController(text: '13012000');
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    userIdController.clear();
    pancardController.clear();
    passwordController.clear();
    super.dispose();
  }

  DateTime goBackApp = DateTime.now();
  bool popScopeFunc() {
    if (DateTime.now().isBefore(goBackApp)) {
      SystemNavigator.pop();
      return true;
    }
    goBackApp = DateTime.now().add(const Duration(seconds: 2));
    // appExit(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) => popScopeFunc,

      // onWillPop: () async {
      //   if (DateTime.now().isBefore(goBackApp)) {
      //     SystemNavigator.pop();
      //     return true;
      //   }
      //   goBackApp = DateTime.now().add(const Duration(seconds: 2));
      //   appExit(context);
      //   return false;
      // },
      child: Theme(
        data: ThemeClass.Lighttheme,
        child: Scaffold(
          body: SafeArea(
            child: BlocListener<InternetCubit, InternetState>(
              listener: (context, state) {
                if (state is InternetConnected) {
                  // return showSnackBar(context, 'interNet Connected');
                } else if (state is InternetDisconnected) {
                  // return showSnackBar(context, 'interNet Disconnected');
                }
              },
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccessState) {
                    //  showSnackBar(context, state.failureMsg);
                    print('Authenticated Suceess');
                    context.read<AuthCookieCubit>().loggedIn();
                    Navigator.pushNamedAndRemoveUntil(
                        context, PageConst.novoPage, (route) => false);
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => NovoMainScreen(),
                    //   ),
                    //   (route) => false,
                    // );
                  } else if (state is AuthFailureState) {
                    print(state.failureMsg);
                    showSnackBar(context, state.failureMsg, primaryRedColor);
                  }
                },
                child: _loginScreen(myHeight),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginScreen(myHeight) {
    return SingleChildScrollView(
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
                        image: AssetImage("assets/images/flattrade_logo.png"))),
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
                    userIdController: userIdController,
                    labelname: "User ID",
                  ),
                  SizedBox(height: myHeight * 0.025),
                  /* Password validation */
                  Passwordfield(
                    passwordController: passwordController,
                    labelname: "Password",
                  ),
                  SizedBox(height: myHeight * 0.025),
                  /* pancard Or dateofbirth validation */
                  PanCardField(
                    panController: pancardController,
                    labelname: "TOTP/OTP",
                  ),
                ],
              ),
            ),
            SizedBox(height: myHeight * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButtonWidget(
                    buttonName: "GET OTP",
                    buttonFunction: () {
                      Navigator.pushNamed(context, PageConst.getOtpPage);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => GetOtpPage(),
                      //     ));
                    },
                    fontStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        height: 1.71,
                        fontFamily: "inter",
                        color: Color.fromRGBO(9, 101, 218, 1))),
                TextButtonWidget(
                    buttonName: "FORGOT PASSWORD?",
                    buttonFunction: () {
                      Navigator.pushNamed(
                          context, PageConst.forgotPasswordPage);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => ForgetPwdPage(),
                      //     ));
                      // forgetPassword(context);
                    },
                    fontStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        height: 1.71,
                        fontFamily: "inter",
                        color: Color.fromRGBO(9, 101, 218, 1))),
              ],
            ),
            SizedBox(height: myHeight * 0.055),
            AuthButton(
                btnfuc: () {
                  ScaffoldMessenger.of(context)..hideCurrentSnackBar();
                  if (formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(AuthLoginEvent(
                          loginEntity: LoginEntity(
                            clientId: userIdController.text,
                            pan: pancardController.text,
                            password: passwordController.text,
                          ),
                        ));
                    // Navigator.pushNamedAndRemoveUntil(
                    //   context,
                    //   NovoDashBoardPage.routeName,
                    //   (Route<dynamic> route) => false,
                    // );
                    // context.read<AuthCookieCubit>().loggedIn();
                  }
                },
                btnName: "LOGIN"),
            SizedBox(height: myHeight * 0.050),
            TextButtonWidget(
              buttonName: "Don't have an account? Signup Now!",
              buttonFunction: () {
                final url = Uri.parse(
                    'https://flattrade.in/open-trading-account?utm_source=NovoApp&utm_medium=organic&utm_campaign=Android');

                // launchUrl(url);
              },
              fontStyle: const TextStyle(
                color: Color(0xFF0965DA),
                fontSize: 14,
                fontFamily: 'inter',
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
            SizedBox(height: myHeight * 0.030),
            Text(
              'SEBI Registration No. INZ000201438. Member Code for NSE: 14572 BSE:6524 MCX: 16765 and ICEX: 2010. CDSL DP ID: 12080300 SEBI Registration No.IN-DP-CDSL-729-2014',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12, color: subTitleTextColor, fontFamily: 'inter'),
            ),
            const SizedBox(height: 10.0),
            // Container(
            //   child: Lottie.network(
            //     'https://lottie.host/8852af69-50ef-489d-a82c-bf278dce8027/ftvKoS9IUT.json',
            //   ),
            // ),
            // Center(
            //   child: Lottie.network(
            //     'https://lottie.host/8852af69-50ef-489d-a82c-bf278dce8027/ftvKoS9IUT.json',
            //   ),
            // ),
            Text(
                'FLATTRADE is an online brand of Fortune Capital Services Pvt Ltd',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 9, color: subTitleTextColor, fontFamily: 'inter'))
          ],
        ),
      ),
    );
  }
}
