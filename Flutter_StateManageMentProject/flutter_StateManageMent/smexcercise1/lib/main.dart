import 'package:flutter/material.dart';
import 'package:smexcercise1/inheritedWidgetChapter2/inheritedexample.dart';
import 'package:smexcercise1/statemanagementChapter1/valueNotifier.dart';

import 'inheritedWidgetChapter2/inheritedClass.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: false,
    ),
    home: const VLexample(),

    // home: ApiProvider(api: Api(), child: const ChildHomePage()),

    routes: {'/new-contact': (context) => const NewContactView()},
  ));
}
