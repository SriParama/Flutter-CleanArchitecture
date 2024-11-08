import 'package:flutter/material.dart';

import 'theme/style.dart';

class TextFieldContainer extends StatelessWidget {
  final TextEditingController? controller;
  final bool? isObscureText;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final double borderRadius;
  final Color? color;
  final VoidCallback? iconClickEvent;
  const TextFieldContainer(
      {super.key,
      this.keyboardType,
      this.prefixIcon,
      this.hintText,
      this.controller,
      this.isObscureText,
      this.borderRadius = 10,
      this.color,
      this.iconClickEvent});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: color == null ? color747480.withOpacity(.2) : color,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        obscureText: isObscureText == true ? true : false,
        keyboardType: keyboardType ?? TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: InkWell(
              onTap: iconClickEvent, child: Icon(prefixIcon ?? Icons.circle)),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
