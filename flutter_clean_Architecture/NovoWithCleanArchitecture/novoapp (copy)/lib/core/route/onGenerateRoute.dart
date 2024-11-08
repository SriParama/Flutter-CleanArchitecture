import 'package:flutter/material.dart';
import 'package:novoapp/core/commonWidgets/errorWidgets/pagenotFountErrorWidget.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/flash_screen.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/getOtp_page.dart';

import 'package:novoapp/features/auth/presentation/pages/LogInPages/loginWithPwdPage.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_InvestDetails_model.dart';
import 'package:novoapp/features/novo/presentation/pages/G-secScreens/gSecScreen.dart';
import 'package:novoapp/features/novo/presentation/pages/IpoScreens/ipoScreen.dart';
import 'package:novoapp/features/novo/presentation/pages/novo_DashBoardScreen.dart';

import 'package:novoapp/features/novo/presentation/pages/novo_MainScreen.dart';
import 'package:novoapp/features/novo/presentation/pages/sgbScreens/sgbPlaceOrder.dart';
import 'package:novoapp/features/novo/presentation/pages/sgbScreens/sgbScreen.dart';

import '../../features/auth/presentation/pages/LogInPages/forgetPwd_page.dart';

class PageConst {
  static const String flashscreen = '/';
  static const String loginPage = 'loginPage';

  static const String forgotPasswordPage = 'forgotPasswordPage';
  static const String getOtpPage = 'getOtpPage';
  static const String novoPage = 'novoPage';
  static const String novoDashBoard = 'novoDashBoard';
  static const String ipoScreen = 'ipoScreen';
  static const String sgbScreen = 'sgbScreen';
  static const String gsecScreen = 'gsecScreen';
  static const String sgbPlaceOrderScreen = 'sgbPlaceOrderScreen';
}

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case PageConst.flashscreen:
        {
          return materialBuilder(widget: SplashScreenPage());
        }
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

      case PageConst.novoPage:
        {
          return materialBuilder(widget: NovoMainScreen());
        }
      case PageConst.novoDashBoard:
        {
          return materialBuilder(
              widget: NovoDashBoardScreen(
            dashboardData: [],
          ));
        }
      case PageConst.ipoScreen:
        {
          return materialBuilder(widget: IpoScreen());
        }
      case PageConst.sgbScreen:
        {
          return materialBuilder(widget: SgbScreen());
        }
      case PageConst.sgbPlaceOrderScreen:
        {
          // SgbDetail data = settings.arguments as SgbDetail;
          // dynamic accountbalance;
          Map sgbData = settings.arguments as Map;

          // Map sgbData = {'SgbDetails': data, 'accountbalance': accountbalance};
          return materialBuilder(
              widget: SGBplaceOrderScreen(
            sgbMasterDetails: sgbData['SgbDetails'] as SgbDetail,
            accountBalance: sgbData['accountbalance'],
          ));
        }
      case PageConst.gsecScreen:
        {
          return materialBuilder(widget: GSecScreen());
        }

      default:
        return materialBuilder(
          widget: PageNotFoundErrorPage(),
        );
    }
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
