import 'package:flutter/material.dart';
import 'package:novoapp/core/theme/app_colors.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback btnfuc;
  final String btnName;
  const AuthButton({super.key, required this.btnfuc, required this.btnName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        elevation: 2,
        minWidth: 250,
        height: 45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        color: appPrimeColor,
        onPressed: btnfuc,
        child: Text(
          btnName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 1.04,
          ),
        ),
      ),
    );
  }
}
