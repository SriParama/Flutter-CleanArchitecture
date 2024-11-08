import 'package:blocdemo/Common/route_names.dart';
import 'package:blocdemo/GlobleBlocs/snackbarBloc/bloc/snackbar_bloc.dart';
import 'package:blocdemo/GlobleCubits/ThemeCubit/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqlite_api.dart';

import 'Common/on_generate_route.dart';
import 'GlobleBlocs/dailogBloc/bloc/dialog_bloc.dart';
import 'GlobleBlocs/navigationBloc/bloc/navigation_bloc.dart';
import 'store/sqlite_store/store_theme_sqlite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Database sqliteDB = await DatabaseHelper.initializeDB();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationBloc(navigatorKey: navigatorKey),
        ),
        BlocProvider(
          create: (context) =>
              SnackbarBloc(scaffoldMessengerKey: scaffoldMessengerKey),
        ),
        BlocProvider(
          create: (context) => DialogBloc(navigatorkey: navigatorKey),
        ),
        // BlocProvider(
        //   create: (context) => ThemeCubit(db: sqliteDB),
        // ),
      ],
      child: MyApp(
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        sqlitedb: sqliteDB,
      ),
    ),
  );
}
// void main(List<String> args) {
//   runApp(Home());
// }

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final Database sqlitedb;
  const MyApp(
      {super.key,
      required this.navigatorKey,
      required this.scaffoldMessengerKey,
      required this.sqlitedb});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(db: sqlitedb),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          // final systemBrightness = MediaQuery.of(context).platformBrightness;
          final systemBrightness =
              SchedulerBinding.instance.platformDispatcher.platformBrightness;

          // Load the saved theme based on system brightness
          context.read<ThemeCubit>().loadTheme(systemBrightness);

          return MaterialApp(
            scaffoldMessengerKey: scaffoldMessengerKey,
            navigatorKey: navigatorKey,
            title: 'Flutter Bloc Demo',
            theme: theme,
            initialRoute: RouteNames.screen1,
            onGenerateRoute: (RouteSettings settings) =>
                Ongenerateroute(routeSettings: settings).routeFunction(),
            // home: const Screen1(),
          );
        },
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    final systemBrightness = MediaQuery.of(context).platformBrightness;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Text('Welcome to Screen1'),
              Container(
                height: 100,
                width: 100,
                color: Theme.of(context).colorScheme.onPrimary,
                child: Text('${Theme.of(context).brightness}'),
              ),
              const Spacer(),
              InkWell(
                child: Text('snackbar'),
                onTap: () {
                  BlocProvider.of<SnackbarBloc>(context).add(
                      GlobleSnackbarEvent(
                          snackMessage: 'Go To Screen 2',
                          snackbgColor: Colors.red,
                          snackTextColor: Colors.white));
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<DialogBloc>(context).add(DailogOpenEvent(
                      title: 'Welcome Bloc',
                      content: Text('Navigate To Screen2'),
                      confirmButtonText: 'Go to Screen2',
                      onConfirm: () {
                        BlocProvider.of<NavigationBloc>(context).add(
                            GlobalNavigationPushNamedEvent(
                                routeName: RouteNames.screen2));

                        Navigator.pop(context);

                        // BlocProvider.of<NavigationBloc>(context)
                        //     .add(GlobleNavigationPop());

                        // BlocProvider.of<DialogBloc>(context)
                        //     .add(DailogHideEvent());
                      },
                    ));
                    // BlocProvider.of<NavigationBloc>(context).add(
                    //     GlobalNavigationPushNamedEvent(
                    //         routeName: RouteNames.screen2));

                    // BlocProvider.of<SnackbarBloc>(context).add(
                    //     GlobleSnackbarEvent(snackMessage: 'Go To Screen 2'));
                  },
                  child: const Text('Go To Screen2')),
              ElevatedButton(
                onPressed: () {
                  themeCubit.toggleTheme(AppTheme.lightTheme, systemBrightness);
                },
                child: Text('Switch to Light Theme'),
              ),
              ElevatedButton(
                onPressed: () {
                  themeCubit.toggleTheme(AppTheme.darkTheme, systemBrightness);
                },
                child: Text('Switch to Dark Theme'),
              ),
              ElevatedButton(
                onPressed: () {
                  themeCubit.toggleTheme(
                      AppTheme.systemTheme, systemBrightness);
                },
                child: Text('Switch to System Theme'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Text('Welcome to Screen2'),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<NavigationBloc>(context).add(
                      GlobalNavigationPushNamedEvent(
                          routeName: RouteNames.screen3));
                  Navigator.pop(context);
                  // BlocProvider.of<NavigationBloc>(context).add(
                  //     GlobalNavigationPushNamedEvent(
                  //         routeName: RouteNames.screen3));
                  // BlocProvider.of<SnackbarBloc>(context).add(
                  //     GlobleSnackbarEvent(
                  //         snackMessage: 'Go To Screen 3',
                  //         snackbgColor: Colors.green,
                  //         snackTextColor: Colors.white));
                },
                child: const Text('Go To Screen3')),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Text('Welcome to Screen3'),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<DialogBloc>(context).add(DailogOpenEvent(
                    title: 'Welcome Bloc',
                    content: Text('Navigate To Screen1'),
                    confirmButtonText: 'Go to Screen1',
                    onConfirm: () {
                      BlocProvider.of<NavigationBloc>(context).add(
                          GlobalNavigationPushNamedEvent(
                              routeName: RouteNames.screen1));
                      Navigator.pop(context);
                      // BlocProvider.of<NavigationBloc>(context)
                      //     .add(GlobleNavigationPop());

                      // BlocProvider.of<DialogBloc>(context)
                      //     .add(DailogHideEvent());
                    },
                  ));
                  // BlocProvider.of<NavigationBloc>(context).add(
                  //     GlobalNavigationPushNamedEvent(
                  //         routeName: RouteNames.screen1));
                },
                child: const Text('Go To Screen1')),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
