// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:novoapp/core/commonWidgets/loader.dart';
// import 'package:novoapp/core/cubits/internet_cubit/internet_cubit.dart';
// import 'package:novoapp/core/route/onGenerateRoute.dart';
// import 'package:novoapp/core/theme/theme.dart';
// import 'package:novoapp/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
// import 'package:novoapp/features/auth/presentation/blocs/auth_cookie/auth_cookie_bloc.dart';
// import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
// import 'package:novoapp/features/auth/presentation/pages/LogInPages/flash_screen.dart';
// import 'package:novoapp/features/auth/presentation/pages/LogInPages/loginWithPwdPage.dart';

// import 'package:novoapp/features/novo/presentation/bloc/Fetch_data_Cubit/fetch_data_cubit.dart';
// import 'package:novoapp/features/novo/presentation/pages/novoDashPage.dart';
// import 'package:novoapp/init_dependencies.dart' as di;
// import 'package:provider/provider.dart';

// import 'core/common/show_snackbar.dart';

// // final snackbarKey = GlobalKey<NavigatorState>();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark),
//   );
//   await di.initDependencies();
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (_) => di.serviceLocator<InternetCubit>(),
//           ),
//           BlocProvider(
//               create: (_) =>
//                   di.serviceLocator<AuthCookieCubit>()..appStarted()),
//           BlocProvider(
//             create: (_) => di.serviceLocator<AuthBloc>(),
//           ),
//           BlocProvider<FetchDataCubit>(
//             create: (_) =>
//                 di.serviceLocator<FetchDataCubit>()..getDashBoardData(),
//           ),
//         ],
//         child: MaterialApp(
//           title: 'NOVO',
//           debugShowCheckedModeBanner: false,
//           theme: ThemeClass.lighttheme,
//           initialRoute: '/',
//           onGenerateRoute: OnGenerateRoute.route,
//           builder: (context, child) {
//             return BlocSelector<InternetCubit, InternetState, bool>(
//               selector: (state) {
//                 return state is InternetConnected;
//               },
//               builder: (context, state) {
//                 if (state) {
//                   return FutureBuilder<void>(
//                     future: Future.delayed(const Duration(milliseconds: 3500)),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return FlashScreenPage();
//                       } else if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       } else {
//                         return

//                             // BlocListener(
//                             //   listener: (context, state) {
//                             //     print('+++++++++++++++');
//                             //     // Navigator.pushReplacement(
//                             //     //     context,
//                             //     //     MaterialPageRoute(
//                             //     //       builder: (context) => LoginPage(),
//                             //     //     ));
//                             //   },
//                             //   listenWhen: (previous, current) =>
//                             //       current is AuthCookieInvalid,
//                             // );
//                             BlocBuilder<AuthCookieCubit, AuthCookieState>(
//                           builder: (context, isLogged) {
//                             if (isLogged is AuthCookieValidated) {
//                               print('Authbuildervalidater+++++++++++++');
//                               return NovoDashBoardPage();
//                             } else {
//                               print('AuthBuilderInvalidator.......');
//                               return LoginPage();
//                             }
//                           },
//                         );
//                         //     BlocSelector<AuthCookieCubit, AuthCookieState,
//                         //         bool>(
//                         //   selector: (state) {
//                         //     return state is AuthCookieValidated;
//                         //   },
//                         //   builder: (context, isLogged) {
//                         //     if (isLogged is AuthCookieValidated) {
//                         //       print('Authbuildervalidater+++++++++++++');
//                         //       return NovoDashBoardPage();
//                         //     } else {
//                         //       print('AuthBuilderInvalidator.......');
//                         //       return LoginPage();
//                         //     }
//                         //   },
//                         // );

//                         //     BlocConsumer<AuthCookieCubit, AuthCookieState>(
//                         //   builder: (context, isLogged) {
//                         //     if (isLogged is AuthCookieValidated) {
//                         //       print('Authbuildervalidater+++++++++++++');
//                         //       return NovoDashBoardPage();
//                         //     } else {
//                         //       print('AuthBuilderInvalidator.......');
//                         //       return LoginPage();
//                         //     }
//                         //   },
//                         //   listener: (context, state) {
//                         //     if (state is AuthCookieValidated) {
//                         //       print('validate');
//                         //     } else {
//                         //       print('INvalidate');
//                         //       // Navigator.pushReplacement(
//                         //       //     context,
//                         //       //     MaterialPageRoute(
//                         //       //       builder: (context) => LoginPage(),
//                         //       //     ));
//                         //     }
//                         //   },
//                         // );

//                         //     BlocListener<AuthCookieCubit, AuthCookieState>(
//                         //   listenWhen: (previous, current) =>
//                         //       current is AuthCookieInvalid,
//                         //   listener: (context, state) {
//                         //     if (state is AuthCookieValidated) {
//                         //       // Check if already on the target page before navigating
//                         //       // if (ModalRoute.of(context)!.settings.name !=
//                         //       //     NovoDashBoardPage.routeName) {
//                         //       print('==================');
//                         //       // Navigator.pushReplacement(
//                         //       //     context,
//                         //       //     MaterialPageRoute(
//                         //       //       builder: (context) => NovoDashBoardPage(),
//                         //       //     ));
//                         //       // Navigator.pushNamedAndRemoveUntil(
//                         //       //   context,
//                         //       //   NovoDashBoardPage.routeName,
//                         //       //   (Route<dynamic> route) => false,
//                         //       // );
//                         //       // }
//                         //     } else if (state is AuthCookieInvalid) {
//                         //       Navigator.pushReplacement(
//                         //           context,
//                         //           MaterialPageRoute(
//                         //             builder: (context) => LoginPage(),
//                         //           ));
//                         //       // Check if already on the target page before navigating
//                         //       //   if (ModalRoute.of(context)!.settings.name !=
//                         //       //       LoginPage.routeName) {
//                         //       //     Navigator.pushNamedAndRemoveUntil(
//                         //       //       context,
//                         //       //       LoginPage.routeName,
//                         //       //       (Route<dynamic> route) => false,
//                         //       //     );
//                         //       //   }
//                         //     }
//                         //   },
//                         //   child: BlocBuilder<AuthCookieCubit, AuthCookieState>(
//                         //     buildWhen: (previous, current) =>
//                         //         current is AuthCookieInvalid,
//                         //     builder: (context, state) {
//                         //       if (state is AuthCookieValidated) {
//                         //         return NovoDashBoardPage();
//                         //       } else {
//                         //         return LoginPage();
//                         //       }
//                         //     },
//                         //   ),
//                         // );

//                         //     BlocSelector<AuthCookieCubit, AuthCookieState,
//                         //         bool>(
//                         //   selector: (state) {
//                         //     return state is AuthCookieValidated;
//                         //   },
//                         //   builder: (context, isLogged) {
//                         //     if (isLogged) {
//                         //       print('+++++++++++++');
//                         //       return NovoDashBoardPage();
//                         //     } else {
//                         //       print('-------------');
//                         //       return LoginPage();
//                         //     }
//                         //   },
//                         // );
//                       }
//                     },
//                   );
//                 } else {
//                   return ErrorPage();
//                 }
//               },
//             );
//           },
//         ));
//   }
// }

// // Future<void> initializeApp(BuildContext context) async {
// //   await Future.delayed(const Duration(milliseconds: 3500));
// // }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/commonWidgets/loader.dart';
import 'package:novoapp/core/cubits/internet_cubit/internet_cubit.dart';
import 'package:novoapp/core/route/onGenerateRoute.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie/auth_cookie_bloc.dart';
import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/flash_screen.dart';
import 'package:novoapp/features/auth/presentation/pages/LogInPages/loginWithPwdPage.dart';

import 'package:novoapp/features/novo/presentation/bloc/Fetch_data_Cubit/fetch_data_cubit.dart';
import 'package:novoapp/features/novo/presentation/pages/novoDashPage.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
      ],
      child: MaterialApp(
        title: 'Group Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
        initialRoute: "/",
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCookieCubit, AuthCookieState>(
              builder: (context, authState) {
                if (authState is AuthCookieValidated) {
                  print('mainAuthenticationState homepage');
                  return NovoDashBoardPage();
                } else {
                  print('mainAuthenticationState login');
                  return LoginPage();
                }
              },
            );
          }
        },
      ),
    );
  }
}

class AuthNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCookieCubit, AuthCookieState>(
        listener: (context, state) {
          if (state is AuthCookieValidated) {
            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   NovoDashBoardPage.routeName,
            //   (Route<dynamic> route) => false,
            // );
          } else if (state is AuthCookieInvalid) {
            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   LoginPage.routeName,
            //   (Route<dynamic> route) => false,
            // );
          }
        },
        child: BlocBuilder<InternetCubit, InternetState>(
          // bloc: InternetCubit(connectivity: ),
          // buildWhen: (previous, current) =>
          //     current is InternetConnected && previous is InternetDisconnected,
          builder: (context, internetState) {
            if (internetState is InternetConnected) {
              return FutureBuilder<void>(
                future: Future.delayed(const Duration(milliseconds: 3500)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return FlashScreenPage();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return BlocBuilder<AuthCookieCubit, AuthCookieState>(
                      builder: (context, authState) {
                        if (authState is AuthCookieValidated) {
                          print('+++++++++++builder show dashboard');
                          return NovoDashBoardPage();
                        } else {
                          print('---------------------builder show login');
                          return LoginPage();
                        }
                      },
                    );
                  }
                },
              );
            } else {
              print('disconnect Internet');
              return ErrorPage();
            }
          },
        ),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Error')),
      body: Center(child: Text('No Internet Connection')),
    );
  }
}
