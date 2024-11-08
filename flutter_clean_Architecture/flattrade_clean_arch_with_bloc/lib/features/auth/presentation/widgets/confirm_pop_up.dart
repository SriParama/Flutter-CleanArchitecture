import 'package:flattrade/core/theme/app_pallete.dart';
import 'package:flattrade/features/auth/presentation/pages/log_in_page.dart';
import 'package:flutter/material.dart';

void showConfirmationDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppPallete.whiteColor,
        surfaceTintColor: AppPallete.whiteColor,
        content: const Text("new password is sent your phone/email"),
        actions: [
          TextButton(
            onPressed: () {
              // Perform action on confirmation
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
            },
            child: const Text("Ok"),
          ),
        ],
      );
    },
  );
}
