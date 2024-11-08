import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat/const.dart';
import 'package:groupchat/features/domine/entities/user_entity.dart';
import 'package:groupchat/features/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:groupchat/features/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:groupchat/features/presentation/pages/homepage.dart';
import 'package:groupchat/features/presentation/widgets/container_button_widget.dart';
import 'package:groupchat/features/presentation/widgets/row_Text_widget.dart';
import 'package:groupchat/features/presentation/widgets/text_container_widget.dart';
import 'package:groupchat/features/presentation/widgets/theme/style.dart';

import '../widgets/headerWidget.dart';
import '../widgets/text_pwd_container_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _confirmpwdController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _userController.dispose();
    _pwdController.dispose();
    _confirmpwdController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
        if (credentialState is CredentialFailure) {
          print('Invalid Email and password');
        }
      },
      builder: (context, credentialState) {
        if (credentialState is CredentialLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (credentialState is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is AuthenticatedState) {
                print('HomepageReg');
                return HomePage(
                  uid: authState.uid,
                );
              } else {
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
              title: 'Registration',
            ),
            SizedBox(
              height: 20,
            ),
            _prifileWidget(),
            SizedBox(
              height: 20,
            ),
            TextFieldContainer(
              controller: _userController,
              hintText: 'Username',
              isObscureText: false,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.person,
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldContainer(
              controller: _emailController,
              hintText: 'Email',
              isObscureText: false,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email,
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              indent: 120,
              endIndent: 120,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            TextPwdFieldContainer(
              controller: _pwdController,
              hintText: 'Password',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.lock,
              sufixIcon: Icons.remove_red_eye_rounded,
            ),
            SizedBox(
              height: 10,
            ),
            TextPwdFieldContainer(
              controller: _confirmpwdController,
              hintText: 'Confirm Password',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.lock,
              sufixIcon: Icons.remove_red_eye_rounded,
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldContainer(
              controller: _dobController,
              hintText: 'D.O.B',
              isObscureText: false,
              keyboardType: TextInputType.datetime,
              prefixIcon: Icons.email,
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldContainer(
              controller: _genderController,
              hintText: 'Gender',
              isObscureText: false,
              keyboardType: TextInputType.text,
              prefixIcon: Icons.email,
            ),
            SizedBox(
              height: 10,
            ),
            ContainerButtonWidget(
                title: 'Register',
                onTap: () {
                  _submitSignUp();
                }),
            SizedBox(
              height: 10,
            ),
            RowTextWidget(
                text: 'Do you have already an account?',
                linkText: 'Login',
                // mainAxisAlignment: MainAxisAlignment.center,
                onTab: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, PageConst.loginPage, (route) => false);
                }),
            SizedBox(
              height: 10,
            ),
            _rowDataWidget()
          ],
        ),
      ),
    );
  }

  void _submitSignUp() {
    if (_userController.text.isEmpty) {
      return;
    }
    if (_emailController.text.isEmpty) {
      return;
    }
    if (_pwdController.text == _confirmpwdController.text) {
    } else {
      print('both password must be same');
      return;
    }

    BlocProvider.of<CredentialCubit>(context).submitSignUp(
        user: UserEntity(
            name: _userController.text,
            email: _emailController.text,
            password: _pwdController.text,
            isOnline: false,
            status: '',
            profileUrl: '',
            dob: _dobController.text.isEmpty ? '' : _dobController.text,
            gender:
                _genderController.text.isEmpty ? '' : _genderController.text));
  }

  Widget _prifileWidget() {
    return Column(
      children: [
        Container(
          height: 62,
          width: 62,
          decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
          child: Image.asset('assets/profile_default.png'),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          'Add profile photo',
          style: TextStyle(color: primaryColor),
        )
      ],
    );
  }

  Widget _rowDataWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'By clicking register, you agree to the ',
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: colorC1C1C1),
        ),
        Text(
          'Privacy Policy',
          style: TextStyle(
              color: greenColor, fontSize: 12, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
