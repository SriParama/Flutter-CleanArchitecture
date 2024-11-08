import 'package:flutter/material.dart';

import 'theme/style.dart';

class TextPwdFieldContainer extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? sufixIcon;
  final TextInputType? keyboardType;
  TextPwdFieldContainer({
    super.key,
    this.keyboardType,
    this.prefixIcon,
    this.sufixIcon,
    this.hintText,
    this.controller,
  });

  @override
  State<TextPwdFieldContainer> createState() => _TextPwdFieldContainerState();
}

class _TextPwdFieldContainerState extends State<TextPwdFieldContainer> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: color747480.withOpacity(.2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        obscureText: isObscureText,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIcon ?? Icons.circle),
          suffixIcon: InkWell(
              onTap: () {
                setState(() {});
                isObscureText = !isObscureText;
              },
              child: isObscureText
                  ? Icon(Icons.remove_red_eye_rounded)
                  : Icon(Icons.panorama_fish_eye_outlined)
              //  Icon(widget.sufixIcon ?? Icons.circle)

              ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
