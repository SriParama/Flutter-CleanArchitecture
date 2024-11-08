import 'package:flutter/material.dart';
import 'package:novoapp/core/theme/app_colors.dart';
import 'package:novoapp/core/theme/theme.dart';
import 'package:novoapp/core/theme/themeprovider.dart';
import 'package:provider/provider.dart';

void customDialogBox(context, String title, var onSubmit) {
  // final darkTheme =
  //     Provider.of<NavigationProvider>(context).themeMode == ThemeMode.dark;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          title,
          // style:
          //     //  darkTheme
          //     //     ? ThemeClass.Darktheme.textTheme.titleMedium
          //     //     :
          //     ThemeClass.Lighttheme.textTheme.titleMedium
        ),
        actions: [
          SizedBox(
            height: 25.0,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0))),
                    backgroundColor: MaterialStatePropertyAll(
                        // darkTheme ? Colors.white :
                        appPrimeColor)),
                onPressed: () => onSubmit(),

                // () {
                //   // Navigator.of(context).pop();
                //   // loadingAlertBox(
                //   //     context, 'Logging Out...');
                //   onSubmit();
                //   // closeLogoutLoadingAlertBox();
                // },
                child: Text(
                  'Yes',
                  style: ThemeClass.Darktheme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                )),
          ),
          SizedBox(
            height: 25.0,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0))),
                    backgroundColor: MaterialStatePropertyAll(
                        // darkTheme ? Colors.white :
                        appPrimeColor)),
                onPressed: () => Navigator.of(context).pop(),
                child: Text('No',
                    style: ThemeClass.Darktheme.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold))),
          ),
        ],
      );
    },
  );
}
