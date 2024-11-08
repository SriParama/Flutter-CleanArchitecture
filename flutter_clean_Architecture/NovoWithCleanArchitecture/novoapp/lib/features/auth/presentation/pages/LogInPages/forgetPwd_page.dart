import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/common/show_snackbar.dart';
import 'package:novoapp/core/commonWidgets/loader.dart';
import 'package:novoapp/core/route/onGenerateRoute.dart';
import 'package:novoapp/features/auth/domine/enities/forgetpwd_enitity.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/loginWithPwdPage.dart';
import 'package:novoapp/features/auth/presentation/widgets/login_Widgets/auth_button.dart';
import 'package:novoapp/features/auth/presentation/widgets/login_Widgets/auth_field.dart';

class ForgetPwdPage extends StatefulWidget {
  const ForgetPwdPage({super.key});

  @override
  State<ForgetPwdPage> createState() => _ForgetPwdPageState();
}

class _ForgetPwdPageState extends State<ForgetPwdPage> {
  late TextEditingController _useridController;
  late TextEditingController _panController;
  late TextEditingController _dobController;
  var formKey = GlobalKey<FormState>();

  DateTime? userDob;
  @override
  void initState() {
    _useridController = TextEditingController();
    _panController = TextEditingController();
    _dobController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _useridController.dispose();
    _panController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthForgetPwdState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
              (route) => false,
            );
            showSnackBar(context, 'PassWord Reset Successfully');
          } else if (state is AuthFailureState) {
            showSnackBar(context, state.failureMsg);
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Loader();
          } else {
            double myHeight = MediaQuery.of(context).size.height;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
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
                    const SizedBox(
                      height: 40,
                    ),
                    Text("Reset your password",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold)

                        // TextStyle(
                        //     color: Color(0xFF03314B),
                        //     fontSize: 20.0,
                        //     fontWeight: FontWeight.w700,
                        //     fontFamily: 'Roboto',
                        //     // height: 1.42
                        //     ),
                        ),
                    const SizedBox(
                      height: 15,
                    ),
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
                          DobField(
                            dobController: _dobController,
                            labelname: "DOB",
                            hindtext: '',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    AuthButton(
                        btnfuc: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(AuthForgetPwdEvent(
                                forgetPwdEntity: ForgetPwdEntity(
                                    clientId: _useridController.text,
                                    dob: _dobController.text,
                                    pan: _panController.text,
                                    sid: '')
                                // userId: _useridController.text.trim(),
                                // pan: _panController.text.trim(),
                                // dob: _dobController.text.trim(),
                                ));
                          }
                        },
                        btnName: "Reset"),
                    const SizedBox(
                      height: 8.0,
                    ),
                    // Center(
                    //   child: RichText(
                    //       text: TextSpan(children: [
                    //     TextSpan(
                    //         text: "Remember password ?",
                    //         style: Theme.of(context).textTheme.bodyMedium),
                    //     WidgetSpan(
                    //       child: GestureDetector(
                    //           onTap: () {
                    //             showConfirmationDialog(context);
                    //           },
                    //           child: Text(" Back to Login",
                    //               style: Theme.of(context)
                    //                   .textTheme
                    //                   .titleSmall!
                    //                   .copyWith(
                    //                       color: AppPallete.primaryColor))),
                    //     )
                    //   ])),
                    // )
                  ],
                ),
              ),
            );
          }
        },
      ),
    ));

    //     BlocConsumer<AuthBloc, AuthState>(
    //   listener: (context, state) {
    //     if (state is AuthFailureState) {
    //       showSnackBar(context, state.failureMsg);
    //     } else if (state is AuthSuccessState) {
    //       Navigator.pushReplacement(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => const LoginPage(),
    //           ));
    //     }
    //   },
    //   builder: (context, state) {
    //     if (state is AuthLoadingState) {
    //       return const Loader();
    //     }
    //     return

    //   },
    // ));
  }
}
