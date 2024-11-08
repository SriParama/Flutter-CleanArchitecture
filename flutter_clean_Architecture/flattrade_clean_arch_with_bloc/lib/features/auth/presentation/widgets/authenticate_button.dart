import 'package:flattrade/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback btnfuc;
  final String btnName;
  const AuthButton({super.key, required this.btnfuc, required this.btnName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.70,
        child: DecoratedBox(
          decoration: const BoxDecoration(
              color: AppPallete.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: ElevatedButton(
            onPressed: btnfuc,
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(395, 55),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            child: Text(
              btnName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 1.04,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
