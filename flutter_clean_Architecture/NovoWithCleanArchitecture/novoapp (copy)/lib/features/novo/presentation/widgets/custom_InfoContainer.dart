// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:novoapp/core/ThemeBloc/theme_bloc.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:provider/provider.dart';

class InfoContainer extends StatelessWidget {
  InfoContainer({super.key, required this.infoMsg});
  String infoMsg;

  @override
  Widget build(BuildContext context) {
    // final themeBloc = BlocProvider.of<ThemeBloc>(context);
    // final themeModeDark = themeBloc.state.themeMode == ThemeMode.dark;
    final themeModeDark =
        Provider.of<NavigationProvider>(context).themeMode == ThemeMode.dark;
    final lightThemeMode =
        Provider.of<NavigationProvider>(context).themeMode == ThemeMode.light;
    Color themeBasedColor =
        themeModeDark ? titleTextColorDark : titleTextColorLight;
    return Container(
      // height: 40,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: themeModeDark
              ? Colors.white10 // Light mode
              : const Color.fromRGBO(235, 237, 236, 1),
        ),
        boxShadow: themeModeDark
            ? null
            : [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 230, 228, 228).withOpacity(0.5),
                  offset: const Offset(
                      0, 1.0), // Offset (x, y) controls the shadow's position
                  blurRadius: 15, // Spread of the shadow
                  spreadRadius:
                      5.0, // Positive values expand the shadow, negative values shrink it
                ),
              ],
        gradient: LinearGradient(
            colors: [const Color.fromRGBO(255, 243, 224, 1), infoColorStart],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,

            // tileMode: TileMode.decal,
            stops: const [0.98, 1.0]
            // radius: 0.5, // Adjust the radius (0.0 to 1.0)
            ),
        borderRadius: const BorderRadius.all(Radius.circular(7.0)),
      ),
      child: Text(infoMsg,
          //'IPO window will remain open from 10 AM to 5 PM,\nHowever your may apply after 5PM as offline.',
          textAlign: TextAlign.justify,
          style: ThemeClass.Lighttheme.textTheme.bodyMedium!
              .copyWith(fontSize: 13)),
    );
  }
}
