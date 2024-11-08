import 'package:flutter/material.dart';
import 'package:groupchat/const.dart';
import 'package:groupchat/features/presentation/pages/create_new_group_page.dart';
import 'package:groupchat/features/presentation/pages/loginpage.dart';
import 'package:groupchat/features/presentation/pages/single_chat_page.dart';

import 'features/presentation/pages/forgot_password_page.dart';
import 'features/presentation/pages/register_Page.dart';

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
          return materialBuilder(widget: ForgotPwdPage());
        }
      case PageConst.registerPage:
        {
          return materialBuilder(widget: RegisterPage());
        }
      case PageConst.createNewGroupPage:
        {
          return materialBuilder(widget: CreateNewGroupPage());
        }
      case PageConst.singleChatPage:
        {
          return materialBuilder(widget: SingleChatPage());
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
