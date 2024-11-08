import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat/const.dart';
import 'package:groupchat/features/domine/entities/user_entity.dart';
import 'package:groupchat/features/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:groupchat/features/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:groupchat/features/presentation/pages/homepage.dart';
import 'package:groupchat/features/presentation/widgets/container_button_widget.dart';
import 'package:groupchat/features/presentation/widgets/headerWidget.dart';
import 'package:groupchat/features/presentation/widgets/text_pwd_container_widget.dart';
import 'package:groupchat/features/presentation/widgets/theme/style.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/row_Text_widget.dart';
import '../widgets/text_container_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, creadentialState) {
        if (creadentialState is CredentialSuccess) {
          print('Autheniticated succes....');
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
        if (creadentialState is CredentialFailure) {
          print('Invalid Email and Password');
        }

        // TODO: implement listener
      },
      builder: (context, credenticalState) {
        if (credenticalState is CredentialLoading) {
          print('loading');
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (credenticalState is CredentialSuccess) {
          print('loginSuccess');
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is AuthenticatedState) {
                print('HomePageSucces');
                return HomePage(
                  uid: authState.uid,
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
    ));
  }

  _bodyWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 32),
        child: Column(
          children: [
            HeaderWidget(
              title: 'LogIn',
            ),
            TextFieldContainer(
              controller: _emailController,
              hintText: 'Enter your Email-Id',
              isObscureText: false,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email,
            ),
            SizedBox(
              height: 10,
            ),
            TextPwdFieldContainer(
              controller: _pwdController,
              hintText: 'Enter your Password',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.lock,
              sufixIcon: Icons.remove_red_eye_rounded,
            ),
            SizedBox(
              height: 10,
            ),
            _forgetPasswordWidget(context),
            SizedBox(
              height: 10,
            ),
            ContainerButtonWidget(
              title: 'LogIn',
              onTap: () {
                _submitSingIn();
                print('Click the login');
              },
            ),
            SizedBox(
              height: 10,
            ),
            RowTextWidget(
              text: "Don't have an Account",
              linkText: 'Register',
              onTab: () {
                Navigator.pushNamed(context, PageConst.registerPage);
              },
            ),
            SizedBox(
              height: 30,
            ),
            _rowGoogleWidget(),
            InkWell(
              onTap: () async {
                // Future<void> _launchUrl(String url) async {
                //   final Uri uri = Uri.parse(url);
                //   if (await canLaunchUrl(uri)) {
                //     await launchUrl(uri);
                //   } else {
                //     throw 'Could not launch $url';
                //   }
                // }

                await launchUrlString('novo://');

                // _launchUrl('novo:');
              },
              child: Icon(Icons.abc),
            )
          ],
        ),
      ),
    );
  }

  Widget _rowGoogleWidget() {
    return Center(
      child: InkWell(
          onTap: () {
            print('Google Account');
            BlocProvider.of<CredentialCubit>(context).submitGoogleAuth();
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(50)),
            child: Icon(
              Icons.g_mobiledata_rounded,
              size: 35,
              color: Colors.white,
            ),
          )),
    );
  }

  void _submitSingIn() {
    if (_emailController.text.isEmpty) {
      return;
    }
    if (_pwdController.text.isEmpty) {
      return;
    }
    BlocProvider.of<CredentialCubit>(context).submitSignIn(
        user: UserEntity(
            email: _emailController.text, password: _pwdController.text));
  }

  Widget _forgetPasswordWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(''),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, PageConst.forgotPasswordPage);
          },
          child: Text(
            'Forgot Password?',
            style: TextStyle(
                color: greenColor, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
