import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novo_clean_arch/features/domin/usecases/get_dashBoard_datails_usecase.dart';
import 'package:novo_clean_arch/features/presentation/cubit/fetchData/cubit/fetch_cubit.dart';

import 'features/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'features/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'features/presentation/pages/home_page.dart';
import 'features/presentation/pages/login_page.dart';
import 'on_generate_route.dart';
import 'injection_container.dart' as di;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

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
        BlocProvider<FetchCubit>(
            create: (_) => di.sl<FetchCubit>()..getDashBoardData()),
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
                if (authState is Authenticated) {
                  print('mainAuthenticationState homepage');
                  return HomePage(
                    cookie: authState.cookie,
                    // uid: authState.uid,
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
