import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obsuretext;

  const AuthField({
    super.key,
    this.obsuretext = false,
    required this.labelText,
    required this.controller,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  // const AuthField({super.key});

  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.characters,
      validator: (value) {
        if (value!.isEmpty) {
          return "${widget.labelText} should not empty";
        }
        return null;
      },
      controller: widget.controller,
      obscureText: widget.labelText == "Password" ? isVisible : false,
      decoration: InputDecoration(
        
          labelText: widget.labelText,
          suffixIconColor: const Color(0xFF8198A5),
          suffixIcon: widget.labelText == "Password"
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                      // widget.obsuretext = !widget.obsuretext;
                    });
                  },
                  icon: isVisible
                      ? const Icon(CupertinoIcons.eye_slash_fill)
                      : const Icon(CupertinoIcons.eye_fill))
              : null),
    );
  }
}
