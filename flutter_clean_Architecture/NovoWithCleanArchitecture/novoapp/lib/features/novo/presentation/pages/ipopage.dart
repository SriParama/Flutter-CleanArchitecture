import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/loginWithPwdPage.dart';

class IpoPage extends StatelessWidget {
  const IpoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocSelector<AuthCookieCubit, AuthCookieState, bool>(
        selector: (state) {
          print('ipoState');
          print('ipoState $state');
          return state is AuthCookieValidated;
        },
        builder: (context, state) {
          if (state) {
            return Center(
              child: Text('IPO'),
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
