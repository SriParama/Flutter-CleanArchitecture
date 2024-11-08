// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:novoapp/core/common/show_snackbar.dart';
// import 'package:novoapp/core/commonWidgets/loader.dart';
// import 'package:novoapp/features/auth/presentation/blocs/auth_cookie_cubit/auth_cookie_cubit.dart';
// import 'package:novoapp/features/auth/presentation/pages/LogInPages/loginWithPwdPage.dart';
// import 'package:novoapp/main.dart';

// class IpoPage extends StatefulWidget {
//   const IpoPage({super.key});

//   @override
//   State<IpoPage> createState() => _IpoPageState();
// }

// class _IpoPageState extends State<IpoPage> {
//   @override
//   void initState() {
//     intial();
//     super.initState();
//   }

//   intial() async {
//     //print(await context.read<AuthCookieCubit>().loggedIn());
//     context.read<AuthCookieCubit>().loggedIn();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: BlocConsumer<AuthCookieCubit, AuthCookieState>(
//       builder: (context, state) {
//         //print('********Ipo State ==$state');
//         if (state is AuthCookieInitial) {
//           return Loader();
//         } else {
//           return Center(
//             child: Text('IPO'),
//           );
//         }
//       },
//       listener: (context, state) {
//         //print('Ipo State ==$state');
//         if (state is AuthCookieInvalid) {
//           showSnackBar(context, state.failureMsg);
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => LoginPage(),
//               ),
//               (route) => false);
//         }
//       },
//     )

//         //  BlocSelector<AuthCookieCubit, AuthCookieState, bool>(
//         //   selector: (state) {
//         //     //print('ipoState');
//         //     //print('ipoState $state');
//         //     return state is AuthCookieValidated;
//         //   },
//         //   builder: (context, state) {
//         //     if (state) {
//         //       //print('AuthCookievalid');
//         //       return Center(
//         //         child: Text('IPO'),
//         //       );
//         //     } else {
//         //       //print('*******AuthCookieInvalid');
//         //       return LoginPage();
//         //     }
//         //   },
//         // ),
//         );
//   }
// }
