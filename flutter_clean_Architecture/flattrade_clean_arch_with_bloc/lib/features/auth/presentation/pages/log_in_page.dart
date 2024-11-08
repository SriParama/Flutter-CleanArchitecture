import 'package:flattrade/core/common/show_snackbar.dart';
import 'package:flattrade/core/widgets/loader.dart';
import 'package:flattrade/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flattrade/features/auth/presentation/pages/forget_password.dart';
import 'package:flattrade/features/auth/presentation/pages/security.dart';
import 'package:flattrade/features/auth/presentation/widgets/auth_field.dart';
import 'package:flattrade/features/auth/presentation/widgets/authenticate_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();

  late TextEditingController userIdController;
  late TextEditingController passwordController;
  late TextEditingController otpTotpController;

  @override
  void initState() {
    userIdController = TextEditingController();
    passwordController = TextEditingController();
    otpTotpController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    otpTotpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Scaffold(),
                  ));
            } else if (state is AuthSendedOtpState) {
              showSnackBar(context, 'Otp sent your sms/e-mail');
            } else if (state is AuthFailureState) {
              showSnackBar(context, state.failureMsg);
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      Center(
                          child: Image.asset(
                        'assets/images/logo-blue.png',
                        width: 160,
                        // height: 50,
                      )),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Let’s Log You In",
                        style: TextStyle(
                            color: Color(0xFF03314B),
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto',
                            height: 1.42),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Welcome back, you’ve been missed!",
                        style: TextStyle(
                            color: Color(0xFF8198A5),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthField(
                        labelText: 'User Id',
                        controller: userIdController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AuthField(
                        controller: passwordController,
                        labelText: 'Password',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AuthField(
                        labelText: 'OTP/TOTP',
                        controller: otpTotpController,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.transparent,
                              ),
                              onPressed: () {
                                if (userIdController.text.trim().isEmpty) {
                                  showSnackBar(
                                      context, 'userid shouldn\'t empty');
                                } else if (passwordController.text
                                    .trim()
                                    .isEmpty) {
                                  showSnackBar(
                                      context, 'password shouldn\'t empty');
                                } else {
                                  context.read<AuthBloc>().add(AuthOtp(
                                        userId: userIdController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      ));
                                }
                              },
                              child: const Text("Login with OTP",
                                  style: TextStyle(
                                    color: Color(0xFF0965DA),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 1.2,
                                  ))),
                          TextButton(
                              style: TextButton.styleFrom(
                                // padding: EdgeInsets.zero,
                                foregroundColor: Colors.transparent,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPassword(),
                                    ));
                              },
                              child: const Text("Forget Password",
                                  style: TextStyle(
                                    color: Color(0xFF0965DA),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 1.2,
                                  ))),
                        ],
                      ),
                      AuthButton(
                          btnfuc: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(AuthLogin(
                                    userId: userIdController.text.trim(),
                                    password: passwordController.text.trim(),
                                    factor: otpTotpController.text.trim(),
                                  ));
                            }
                          },
                          btnName: "Log in"),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Center(
                        child: RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Dont's have an account? ",
                              style: TextStyle(
                                color: Color(0xFF03314B),
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                // height: 1.71,
                              )),
                          WidgetSpan(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SecurityScreen(),
                                  ));
                                },
                                child: const Text("Register here",
                                    style: TextStyle(
                                      color: Color(0xFF0965DA),
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ))),
                          )
                        ])),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
