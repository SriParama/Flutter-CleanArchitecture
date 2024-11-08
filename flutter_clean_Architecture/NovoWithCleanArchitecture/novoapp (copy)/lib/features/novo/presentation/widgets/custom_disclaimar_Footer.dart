import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novoapp/core/ThemeBloc/theme_bloc.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:provider/provider.dart';

class NovoFooterWidget extends StatelessWidget {
  final String disclimerText;
  const NovoFooterWidget({super.key, required this.disclimerText});

  @override
  Widget build(BuildContext context) {
    // final themeBloc = BlocProvider.of<ThemeBloc>(context);
    // final darkTheme = themeBloc.state.themeMode == ThemeMode.dark;
    final darkTheme =
        Provider.of<NavigationProvider>(context).themeMode == ThemeMode.dark;
    Color themeBasedColor =
        darkTheme ? titleTextColorDark : titleTextColorLight;
    // Color themeBasedColor = getThemeBasedColor(context);
    // final getTheme = GetTheme();
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
              color: const Color.fromRGBO(156, 155, 173, 1), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                disclimerText,
                // 'Your order will be placed on the exchange (NSE/BSE) at the end of the subscription period. Ensure to keep sufficient balance in your Trading account on the last day of the issue. Credit from stocks sold on the closing day of the issue will not be considered towards the purchase of the SGB.',
                style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    fontFamily: 'inter',
                    color: themeBasedColor),
                textAlign: TextAlign.justify,
                maxLines: 10,
                softWrap: true,
              )
            ],
          ),
        ));
  }
}
