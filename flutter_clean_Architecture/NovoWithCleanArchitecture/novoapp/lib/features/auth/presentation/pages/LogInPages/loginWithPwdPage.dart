// ignore_for_file: unused_field, prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_local_variable, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
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
import 'package:novoapp/features/novo/presentation/pages/novoDashPage.dart';

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
      TextEditingController(text: 'Sri@123');
  TextEditingController pancardController =
      TextEditingController(text: '13012000');
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // versionCheck(context);
      // cookieverify();
    });
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
        data: ThemeClass.lighttheme,
        child: Scaffold(
          body: SafeArea(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccessState) {
                  // BlocProvider.of<AuthCookieBloc>(context).authIsLogin();
                  //  context.read<AuthCookieBloc>().authIsLogin(event, emit)
                  // context.read<AuthCookieBloc>().add(AuthIsLoginEvent());
                  context.read<AuthCookieCubit>().loggedIn();
                  // BlocProvider.of<AuthCookieCubit>(context).loggedIn();
                  // Navigator.pushReplacementNamed(
                  //   context,
                  //   PageConst.novoPage,
                  // );
                  print('hi............');
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => NovoDashBoardPage(),
                  //       ));
                }

                //  else if (state is AuthForgetPwdState) {
                //   Navigator.pushNamedAndRemoveUntil(
                //       context, PageConst.loginPage, (route) => false);
                //   showSnackBar(context, 'PassWord Reset Successfully');
                // }  else if (state is AuthGetOtpState) {
                //   Navigator.pushNamedAndRemoveUntil(
                //       context, PageConst.loginPage, (route) => false);
                //   showSnackBar(context, 'OTP send Successfully');
                // }

                else if (state is AuthFailureState) {
                  showSnackBar(context, state.failureMsg);
                } else if (state is InternetDisconnected) {
                  showSnackBar(context, 'No internet');
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return Loader();
                }
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
                                    image: AssetImage(
                                        "assets/images/flattrade_logo.png"))),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GetOtpPage(),
                                      ));
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgetPwdPage(),
                                      ));
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
                              fontSize: 12,
                              color: subTitleTextColor,
                              fontFamily: 'inter'),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                            'FLATTRADE is an online brand of Fortune Capital Services Pvt Ltd',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 9,
                                color: subTitleTextColor,
                                fontFamily: 'inter'))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
