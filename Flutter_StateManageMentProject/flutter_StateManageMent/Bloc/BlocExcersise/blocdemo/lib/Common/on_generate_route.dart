import 'package:blocdemo/Common/route_names.dart';
import 'package:blocdemo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screen1Bloc/bloc/screen1_bloc.dart';

class Ongenerateroute {
  final RouteSettings routeSettings;
  Ongenerateroute({required this.routeSettings});

  routeFunction() {
    switch (routeSettings.name) {
      case RouteNames.screen1:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => Screen1Bloc(), // Inject Screen1Bloc here
            child: const Screen1(),
          ),
        );

      case RouteNames.screen2:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => Screen1Bloc(), // Inject Screen1Bloc here
            child: const Screen2(),
          ),
        );
      case RouteNames.screen3:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => Screen1Bloc(), // Inject Screen1Bloc here
            child: const Screen3(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Route Name Not Found'),
            ),
          ),
        );
    }
  }
}
