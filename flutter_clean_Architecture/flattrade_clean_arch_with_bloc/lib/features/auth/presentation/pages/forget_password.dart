import 'package:flattrade/core/common/show_snackbar.dart';
import 'package:flattrade/core/theme/app_pallete.dart';
import 'package:flattrade/core/widgets/loader.dart';
import 'package:flattrade/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flattrade/features/auth/presentation/widgets/auth_field.dart';
import 'package:flattrade/features/auth/presentation/widgets/authenticate_button.dart';
import 'package:flattrade/features/auth/presentation/widgets/confirm_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailureState) {
            showSnackBar(context, state.failureMsg);
          } else if (state is AuthSuccessState) {
            showConfirmationDialog(context);
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Loader();
          } else {
            return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: Image.asset(
                            'assets/images/logo-blue.png',
                            width: 160,
                            // height: 50,
                          )),
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
                          AuthField(
                              labelText: 'User id',
                              controller: _useridController),
                          const SizedBox(
                            height: 15,
                          ),
                          AuthField(
                              labelText: 'Pan No', controller: _panController),
                          const SizedBox(
                            height: 15,
                          ),
                          // showDatePicker(context: context, firstDate: firstDate, lastDate: lastDate)
                          TextFormField(
                            controller: _dobController,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              hintText: 'DD-MM-YYYY',
                              label: Text("DOB"),
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          AuthButton(
                              btnfuc: () {
                                if (formKey.currentState!.validate()) {
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthForgetPasswordEvent(
                                        userId: _useridController.text.trim(),
                                        pan: _panController.text.trim(),
                                        dob: _dobController.text.trim(),
                                      ));
                                }
                              },
                              btnName: "Reset"),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Center(
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Remember password ?",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              WidgetSpan(
                                child: GestureDetector(
                                    onTap: () {
                                      showConfirmationDialog(context);
                                    },
                                    child: Text(" Back to Login",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                color:
                                                    AppPallete.primaryColor))),
                              )
                            ])),
                          )
                        ],
                      ),
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
