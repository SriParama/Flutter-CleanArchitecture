// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/loginWithPwdPage.dart';
import 'package:novoapp/features/novo/presentation/pages/novo_MainScreen.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  // animation() async {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeClass.Lighttheme,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child:
                  // CircularProgressIndicator()
                  Image.asset(
                "assets/images/Novo_Animation .gif",
              ),
            )
          ],
        ),
      ),
    );
  }
}
