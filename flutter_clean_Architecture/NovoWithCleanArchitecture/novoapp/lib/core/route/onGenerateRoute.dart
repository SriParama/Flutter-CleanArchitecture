import 'package:flutter/material.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/flash_screen.dart';

import 'package:novoapp/features/auth/presentation/pages/LogInPages/loginWithPwdPage.dart';

import 'package:novoapp/features/novo/presentation/pages/novoDashPage.dart';

class PageConst {
  static const String flashscreen = '/';
  static const String loginPage = 'loginPage';
  static const String novoPage = 'novoPage';
  static const String forgotPasswordPage = 'forgotPasswordPage';
  static const String getOtpPage = 'getOtpPage';
  static const String createNewGroupPage = 'createNewGroupPage';
  static const String singleChatPage = 'singleChatPage';
}

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case PageConst.flashscreen:
        {
          return materialBuilder(widget: FlashScreenPage());
        }
      case PageConst.loginPage:
        {
          return materialBuilder(widget: LoginPage());
        }
      // case PageConst.forgotPasswordPage:
      //   {
      //     return materialBuilder(widget: ForgetPwdPage());
      //   }
      // case PageConst.getOtpPage:
      //   {
      //     return materialBuilder(widget: GetOtpPage());
      //   }

      case PageConst.novoPage:
        {
          return materialBuilder(widget: NovoDashBoardPage());
        }

      default:
        return materialBuilder(
          widget: ErrorPage(),
        );
    }
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("error"),
      ),
      body: Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
