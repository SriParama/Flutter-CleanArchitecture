import 'package:flutter/material.dart';
import 'package:groupchat/const.dart';
import 'package:groupchat/features/presentation/widgets/container_button_widget.dart';
import 'package:groupchat/features/presentation/widgets/headerWidget.dart';

import '../widgets/row_Text_widget.dart';
import '../widgets/text_container_widget.dart';

class ForgotPwdPage extends StatefulWidget {
  const ForgotPwdPage({super.key});

  @override
  State<ForgotPwdPage> createState() => _ForgotPwdPageState();
}

class _ForgotPwdPageState extends State<ForgotPwdPage> {
  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: Column(
            children: [
              HeaderWidget(
                title: 'Forgot Password',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                  "Don't worry! Just fill in your email and ${AppConst.appName} will sent you a link to reset your password."),
              SizedBox(
                height: 30,
              ),

              TextFieldContainer(
                controller: _emailController,
                hintText: 'Enter your Email-Id',
                isObscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
              ),

              SizedBox(
                height: 20,
              ),
              // _forgetPasswordWidget(),

              ContainerButtonWidget(
                title: 'Send Password Reset Email',
                onTap: () {
                  print('Send Password Reset Email');
                },
              ),
              SizedBox(
                height: 10,
              ),
              RowTextWidget(
                text: "Remember the account information?",
                linkText: 'Login',
                onTab: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, PageConst.loginPage, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
