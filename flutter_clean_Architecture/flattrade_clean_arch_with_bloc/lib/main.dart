import 'package:flattrade/core/common/show_snackbar.dart';
import 'package:flattrade/core/cubits/internet_cubit/internet_cubit.dart';
import 'package:flattrade/core/theme/theme.dart';
import 'package:flattrade/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flattrade/features/auth/presentation/pages/log_in_page.dart';
import 'package:flattrade/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<InternetCubit>(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
// context.read<InternetCubit>().monitorInternetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLATTRADE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeMode,
      home: BlocListener<InternetCubit, InternetState>(
        listener: (context, state) {
          if (state is InternetDisconnected) {
            showSnackBar(context, 'No internet');
          }
        },
        child: const LoginPage(),
      ),
    );
  }
}
