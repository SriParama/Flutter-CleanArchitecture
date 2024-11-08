import 'package:flutter/material.dart';
import 'package:novo_clean_arch/appconst.dart';
import 'package:novo_clean_arch/features/presentation/pages/forget_password.dart';
import 'package:novo_clean_arch/features/presentation/pages/get_Otp_Page.dart';
import 'package:novo_clean_arch/features/presentation/pages/home_page.dart';

import 'features/presentation/pages/login_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case PageConst.loginPage:
        {
          return materialBuilder(widget: LoginPage());
        }
      case PageConst.forgotPasswordPage:
        {
          return materialBuilder(widget: ForgetPwdPage());
        }
      case PageConst.getOtpPage:
        {
          return materialBuilder(widget: GetOtpPage());
        }

      // case PageConst.homePage:
      //   {
      //     return materialBuilder(widget: HomePage());
      //   }

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
