// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novoapp/core/common/globleVariables.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:provider/provider.dart';

class HistoryPriceInfoDailog extends StatelessWidget {
  HistoryPriceInfoDailog({
    super.key,
    required this.infoTitleUnit,
    required this.infoUnit,
    required this.infoTitleUnitPrice,
    required this.infoUnitPrice,
    required this.infoTitleAmount,
    required this.infoUnitAmount,
  });

  String infoTitleUnit;
  dynamic infoUnit;
  String infoTitleUnitPrice;
  dynamic infoUnitPrice;
  String infoTitleAmount;
  dynamic infoUnitAmount;

  double textHeight = 1.7;

  @override
  Widget build(BuildContext context) {
    var themeModeLight =
        Provider.of<NavigationProvider>(context, listen: false).themeMode ==
            ThemeMode.light;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              infoTitleUnit,
              style: themeModeLight
                  ? ThemeClass.Lighttheme.textTheme.bodyMedium!
                      .copyWith(height: textHeight)
                  : ThemeClass.Darktheme.textTheme.bodyMedium!
                      .copyWith(height: textHeight),
            ),
            Text(
              infoUnit.toString(),
              style: themeModeLight
                  ? ThemeClass.Lighttheme.textTheme.titleSmall!
                      .copyWith(height: textHeight)
                  : ThemeClass.Darktheme.textTheme.titleSmall!
                      .copyWith(height: textHeight),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              infoTitleUnitPrice,
              style: themeModeLight
                  ? ThemeClass.Lighttheme.textTheme.bodyMedium!
                      .copyWith(height: textHeight)
                  : ThemeClass.Darktheme.textTheme.bodyMedium!
                      .copyWith(height: textHeight),
            ),
            Text(
              rsFormat.format(infoUnitPrice),
              style: themeModeLight
                  ? ThemeClass.Lighttheme.textTheme.titleSmall!
                      .copyWith(height: textHeight)
                  : ThemeClass.Darktheme.textTheme.titleSmall!
                      .copyWith(height: textHeight),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              infoTitleAmount,
              style: themeModeLight
                  ? ThemeClass.Lighttheme.textTheme.bodyMedium!
                      .copyWith(height: textHeight)
                  : ThemeClass.Darktheme.textTheme.bodyMedium!
                      .copyWith(height: textHeight),
            ),
            Text(
              rsFormat.format(infoUnitAmount),
              style: themeModeLight
                  ? ThemeClass.Lighttheme.textTheme.titleSmall!
                      .copyWith(height: textHeight)
                  : ThemeClass.Darktheme.textTheme.titleSmall!
                      .copyWith(height: textHeight),
            )
          ],
        ),
      ],
    );
  }
}
