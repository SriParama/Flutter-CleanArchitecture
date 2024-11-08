import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:novoapp/features/novo/data/novo_data_source/models/sgbModel/sgb_OrderDetails_model.dart';
import 'package:novoapp/features/novo/presentation/widgets/custom_HistoryPriceInfoDialog.dart';
import 'package:provider/provider.dart';

sgbHistoryPriceInfoDailog(SgbOrderHistoryArr infoDetails, context) {
  var themeModeLight =
      Provider.of<NavigationProvider>(context, listen: false).themeMode ==
          ThemeMode.light;

  double textHeight = 1.7;
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                // width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16.0),
                color: sgbPrimaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        infoDetails.name,
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                        style: ThemeClass.Lighttheme.textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        CupertinoIcons.multiply,
                        color: titleTextColorLight,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Allotment Status',
                          style: ThemeClass.Lighttheme.textTheme.displayMedium!
                              .copyWith(height: textHeight),
                        ),
                        Text(
                          infoDetails.rbiStatus,
                          style: themeModeLight
                              ? ThemeClass.Lighttheme.textTheme.bodyMedium!
                                  .copyWith(height: textHeight)
                              : ThemeClass.Darktheme.textTheme.bodyMedium!
                                  .copyWith(height: textHeight),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Form Verification Status',
                          style: ThemeClass.Lighttheme.textTheme.displayMedium!
                              .copyWith(height: textHeight),
                        ),
                        Text(
                          infoDetails.dpStatus,
                          style: themeModeLight
                              ? ThemeClass.Lighttheme.textTheme.bodyMedium!
                                  .copyWith(height: textHeight)
                              : ThemeClass.Darktheme.textTheme.bodyMedium!
                                  .copyWith(height: textHeight),
                        )
                      ],
                    ),
                    Divider(
                      color: subTitleTextColor,
                    ),
                    HistoryPriceInfoDailog(
                      infoTitleUnit: 'Request Unit',
                      infoUnit: infoDetails.requestedUnit,
                      infoTitleUnitPrice: 'Request UnitPrice',
                      infoUnitPrice: infoDetails.requestedUnitPrice,
                      infoTitleAmount: 'Amount Payable',
                      infoUnitAmount: infoDetails.requestedAmount,
                    ),
                    Divider(
                      color: subTitleTextColor,
                    ),
                    HistoryPriceInfoDailog(
                      infoTitleUnit: 'Applied Unit',
                      infoUnit: infoDetails.appliedUnit,
                      infoTitleUnitPrice: 'Applied UnitPrice',
                      infoUnitPrice: infoDetails.appliedUnitPrice,
                      infoTitleAmount: 'Amount Payable',
                      infoUnitAmount: infoDetails.appliedAmount,
                    ),
                    Divider(
                      color: subTitleTextColor,
                    ),
                    HistoryPriceInfoDailog(
                      infoTitleUnit: 'Alloted Unit',
                      infoUnit: infoDetails.allotedUnit,
                      infoTitleUnitPrice: 'Alloted UnitPrice',
                      infoUnitPrice: infoDetails.allotedUnitPrice,
                      infoTitleAmount: 'Amount Payable',
                      infoUnitAmount: infoDetails.allotedAmount,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
