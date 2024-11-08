import 'package:flutter/material.dart';
import 'package:smexcercise1/inheritedWidgetChapter2/inheritedClass.dart';
import 'package:uuid/uuid.dart';

class ApiProvider extends InheritedWidget {
  final Api api;
  final String uuid;
  ApiProvider({Key? key, required this.api, required Widget child})
      : uuid = const Uuid().v4(),
        super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    return uuid != oldWidget.uuid;
  }

  static ApiProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
}

class ChildHomePage extends StatefulWidget {
  const ChildHomePage({super.key});

  @override
  State<ChildHomePage> createState() => _ChildHomePageState();
}

class _ChildHomePageState extends State<ChildHomePage> {
  @override
  Widget build(BuildContext context) {
    ValueKey _textKey = const ValueKey<String?>(null);
    return Scaffold(
      appBar: AppBar(
        title: Text(ApiProvider.of(context).api.getDateAndTime() ?? ''),
      ),
      body: GestureDetector(
        onTap: () {
          final api = ApiProvider.of(context).api;
          final dateAndTime = api.getDateAndTime();
          setState(() {
            _textKey = ValueKey(dateAndTime);
          });
        },
        child: DateTimeWidget(key: _textKey),
      ),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;

    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(api.getDateAndTime() ??
          'Tap the Screen to fetch the DateAndTime....'),
    );
  }
}
