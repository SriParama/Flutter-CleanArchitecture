import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat/features/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:groupchat/features/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:groupchat/features/presentation/cubit/user/cubit/user_cubit.dart';
import 'package:groupchat/features/presentation/pages/homepage.dart';
import 'package:groupchat/features/presentation/pages/loginpage.dart';
import 'package:groupchat/firebase_options.dart';
import 'package:groupchat/on_generate_route.dart';
import 'injection_container.dart' as di;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<CredentialCubit>(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()..getUsers()),
      ],
      child: MaterialApp(
        title: 'Group Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
        initialRoute: "/",
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is AuthenticatedState) {
                  print('mainAuthenticationState homepage');
                  return HomePage(
                    uid: authState.uid,
                  );
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
