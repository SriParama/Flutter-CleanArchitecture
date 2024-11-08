import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final bool buttonDisable;
  final Function onSubmit;

  const CustomActionButton(
      {super.key,
      required this.buttonColor,
      required this.buttonText,
      required this.buttonDisable,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 5),
        elevation: 2,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        color: buttonColor,
        onPressed: buttonDisable
            ? null
            : () {
                onSubmit();
              },
        child: Text(
          buttonText,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
