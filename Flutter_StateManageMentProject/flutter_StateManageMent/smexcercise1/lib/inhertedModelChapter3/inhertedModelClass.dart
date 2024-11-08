import 'package:flutter/material.dart';
import 'package:smexcercise1/inhertedModelChapter3/utils.dart';

class AvailableColorWidget extends InheritedModel<AvailableColors> {
  final AvailableColors color1;
  final AvailableColors color2;
  AvailableColorWidget({
    Key? key,
    required this.color1,
    required this.color2,
    required Widget child,
  }) : super(key: key, child: child);

  static AvailableColorWidget of(BuildContext context, AvailableColors aspect) {
    return InheritedModel.inheritFrom<AvailableColorWidget>(
      context,
      aspect: aspect,
    )!;
  }

  @override
  bool updateShouldNotify(covariant AvailableColorWidget oldWidget) {
    print('Update should  notify');
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(covariant AvailableColorWidget oldWidget,
      Set<AvailableColors> dependencies) {
    print('update should notifyDependent');

    if (dependencies.contains(AvailableColors.one) &&
        color1 != oldWidget.color1) {
      return true;
    }
    if (dependencies.contains(AvailableColors.two) &&
        color2 != oldWidget.color2) {
      return true;
    }
    return false;
  }
}

class ColorWidget extends StatelessWidget {
  final AvailableColors color;
  const ColorWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case AvailableColors.one:
        print('Color1 widget got rebuilt!');
        break;
      case AvailableColors.two:
        print('Color2 widget got rebuild!');
        break;
    }

    return Container();
  }
}
