// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/loginWithPwdPage.dart';
import 'package:novoapp/features/novo/presentation/pages/novoDashPage.dart';

class FlashScreenPage extends StatefulWidget {
  const FlashScreenPage({super.key});

  @override
  State<FlashScreenPage> createState() => _FlashScreenPageState();
}

class _FlashScreenPageState extends State<FlashScreenPage> {
  @override
  void initState() {
    // animation();
    super.initState();
  }

  // animation() async {
  //   await Future.delayed(const Duration(milliseconds: 3500), () async {
  //     await Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (context) {
  //       return BlocSelector<AuthCookieCubit, AuthCookieState, bool>(
  //         selector: (state) {
  //           return state is AuthCookieValidated;
  //         },
  //         builder: (context, isLogged) {
  //           if (isLogged) {
  //             return NovoDashBoardPage();
  //           } else {
  //             return LoginPage();
  //           }
  //         },
  //       );
  //     }));
  //     // PageTransition(
  //     //     child: const LoginPage(), type: PageTransitionType.fade));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
