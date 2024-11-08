import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/ThemeBloc/theme_bloc.dart';
import 'package:novoapp/core/commonWidgets/errorWidgets/internetErrorWidget.dart';
import 'package:novoapp/core/commonWidgets/loader.dart';
import 'package:novoapp/core/cubits/IndexChange_cubit/index_change_cubit.dart';
import 'package:novoapp/core/cubits/internet_cubit/internet_cubit.dart';
import 'package:novoapp/core/route/onGenerateRoute.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie/auth_cookie_bloc.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/flash_screen.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/loginWithPwdPage.dart';
import 'package:novoapp/features/novo/presentation/bloc/Gsec_PlaceOrder_Bloc/post_gsec_order_bloc.dart';
import 'package:novoapp/features/novo/presentation/bloc/SGB_PlaceOrder_Bloc/post_sgb_order_bloc.dart';

import 'package:novoapp/features/novo/presentation/cubit/Fetch_data_Cubit/fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/cubit/Gsec_fetch_data_Cubit/gsec_fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/cubit/Sgb_FetchData_Cubit/sgb_fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/pages/novo_MainScreen.dart';
import 'package:novoapp/init_dependencies.dart' as di;
import 'package:provider/provider.dart';

import 'core/common/show_snackbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark),
  );
  await di.initDependencies();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // setContext(context);
    return MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create: (_) => di.serviceLocator<ThemeBloc>(),
          // ),
          BlocProvider(
            create: (_) => di.serviceLocator<IndexChangeCubit>(),
          ),
          BlocProvider(
            create: (_) => di.serviceLocator<InternetCubit>(),
          ),
          BlocProvider(
            create: (_) => di.serviceLocator<AuthCookieCubit>()..appStarted(),
          ),
          BlocProvider(
            create: (_) => di.serviceLocator<AuthBloc>(),
          ),
          BlocProvider<FetchDataCubit>(
            create: (_) =>
                di.serviceLocator<FetchDataCubit>()..getDashBoardData(),
          ),
          BlocProvider<SgbFetchDataCubit>(
            create: (_) => di.serviceLocator<SgbFetchDataCubit>()..getSGBData(),
          ),
          BlocProvider<SgbOrderBloc>(
            create: (_) => di.serviceLocator<SgbOrderBloc>(),
          ),
          BlocProvider<GsecFetchDataCubit>(
            create: (_) =>
                di.serviceLocator<GsecFetchDataCubit>()..getGsecData(),
          ),
          BlocProvider<GsecOrderBloc>(
            create: (_) => di.serviceLocator<GsecOrderBloc>(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: OverlayService.navigatorKey,
          title: 'NOVO',
          debugShowCheckedModeBanner: false,
          scrollBehavior: MyBehavior(),
          theme: ThemeClass.Lighttheme,
          darkTheme: ThemeClass.Darktheme,
          themeMode: Provider.of<NavigationProvider>(context).themeMode,
          // theme: themeState.themeData,
          // themeMode: themeState.themeMode,
          initialRoute: '/',
          onGenerateRoute: OnGenerateRoute.route,
          routes: {
            '/': (context) => AuthNavigation(),
          },
        ));
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class AuthNavigation extends StatefulWidget {
  @override
  State<AuthNavigation> createState() => _AuthNavigationState();
}

class _AuthNavigationState extends State<AuthNavigation> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    // Show splash screen for 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSplash
        ? SplashScreenPage()
        : BlocBuilder<AuthCookieCubit, AuthCookieState>(
            builder: (context, state) {
              if (state is AuthCookieValidated) {
                return NovoMainScreen();
              } else if (state is AuthCookieInvalid) {
                return LoginPage();
              } else if (state is AuthCookieInitial) {
                print('++++++++++++initial+++++++');
                return SplashScreenPage();
              } else {
                print('-------else---------');
                return Loader();
              }
            },
          );
  }
}

// class _AuthNavigationState extends State<AuthNavigation> {
//   bool _showSplash = true;

//   @override
//   void initState() {
//     super.initState();
//     _checkCookieValidation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, state) {
//         return Theme(
//           data: state.themeData,
//           child: _showSplash
//               ? SplashScreenPage()
//               : BlocSelector<AuthCookieCubit, AuthCookieState, bool>(
//                   selector: (state) {
//                     return state is AuthCookieValidated;
//                   },
//                   builder: (context, cookieValidated) {
//                     return cookieValidated ? NovoMainScreen() : LoginPage();
//                   },
//                 ),
//         );
//       },
//     );
//   }

//   void _checkCookieValidation() {
//     final authCookieCubit = context.read<AuthCookieCubit>();
//     authCookieCubit.add(CheckCookieValidationEvent());
//     authCookieCubit.stream.listen((state) {
//       if (state is AuthCookieValidated) {
//         setState(() {
//           _showSplash = false;
//         });
//       }
//     });
//   }
// }



// class AuthNavigation extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initialize(),
//       builder: (context, AsyncSnapshot<void> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return SplashScreenPage();
//         } else {
//           return BlocBuilder<ThemeBloc, ThemeState>(
//             builder: (context, state) {
//               return Theme(
//                 data: state.themeData,
//                 child: BlocSelector<AuthCookieCubit, AuthCookieState, bool>(
//                   selector: (state) {
//                     return state is AuthCookieValidated;
//                   },
//                   builder: (context, cookieValidated) {
//                     if (cookieValidated) {
//                       return NovoMainScreen();
//                     } else {
//                       return LoginPage();
//                     }
//                   },
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }

//   Future<void> _initialize() async {
//     await Future.delayed(Duration(seconds: 3));
//   }
// }
// class ErrorPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Error')),
//       body: Center(child: Text('No Internet Connection')),
//     );
//   }
// }
