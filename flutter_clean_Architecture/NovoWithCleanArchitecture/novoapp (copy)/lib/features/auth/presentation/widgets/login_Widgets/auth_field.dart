// ignore_for_file: public_member_api_docs, sort_constructors_first, use_full_hex_values_for_flutter_colors
import 'package:flutter/material.dart';
import 'package:novoapp/core/common/globleVariables.dart';
import 'package:novoapp/core/theme/app_colors.dart';

class NameField extends StatelessWidget {
  const NameField({
    super.key,
    required this.userIdController,
    required this.labelname,
  });
  final TextEditingController userIdController;
  final String labelname;

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: myHeight * 0.012),
      child: TextFormField(
          style: TextStyle(
              // fontSize: 15,
              color: titleTextColorLight,
              fontWeight: FontWeight.normal),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.visiblePassword,
          controller: userIdController,
          textCapitalization: TextCapitalization.characters,
          inputFormatters: [
            UpperCaseTextFormatter(),
            NoSpecialCharactersFormatter(),
            // NoSpaceInputFormatter()
          ],
          decoration: InputDecoration(
            labelText: labelname,
            labelStyle: TextStyle(
                color: titleTextColorLight,
                fontWeight: FontWeight.w500,
                fontSize: 15,
                height: 1.62,
                fontFamily: 'inter'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromRGBO(244, 244, 246, 1),
                width: 2.0,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
            focusColor: const Color(0xFF03314B),
            errorStyle: const TextStyle(height: 0.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 2.0,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Color.fromRGBO(237, 237, 242, 1),
              ),
            ),
          ),
          validator: (value) => validator(value)),
    );
  }
}

class Passwordfield extends StatefulWidget {
  final TextEditingController passwordController;
  final String labelname;
  const Passwordfield({
    super.key,
    required this.passwordController,
    required this.labelname,
  });

  @override
  State<Passwordfield> createState() => PasswordfieldState();
}

// ignore: camel_case_types
class PasswordfieldState extends State<Passwordfield> {
  bool abscurepassword = true;

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        top: myHeight * 0.012,
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.text,
        controller: widget.passwordController,

        style: TextStyle(
            // fontSize: 15,
            color: titleTextColorLight,
            fontWeight: FontWeight.normal),
        // inputFormatters: [NoSpaceInputFormatter()],
        obscureText: abscurepassword,
        validator: (value) => validator(value),
        decoration: InputDecoration(
          labelText: widget.labelname,
          labelStyle: TextStyle(
              color: titleTextColorLight,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              height: 1.62,
              fontFamily: 'inter'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromRGBO(244, 244, 246, 1),
              width: 2.0,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
          errorStyle: const TextStyle(height: 0.0),
          focusColor: const Color(0xFF03314B),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 2.0,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: Color.fromRGBO(237, 237, 242, 1),
            ),
          ),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  abscurepassword = !abscurepassword;
                });
              },
              icon: Icon(
                abscurepassword ? Icons.visibility_off : Icons.visibility,
                color: const Color.fromRGBO(211, 213, 218, 1),
              )),
        ),
      ),
    );
  }
}

class PanCardField extends StatefulWidget {
  const PanCardField({
    super.key,
    required this.panController,
    required this.labelname,
  });
  final TextEditingController panController;
  final String labelname;
  @override
  State<PanCardField> createState() => PanCardFieldState();
}

class PanCardFieldState extends State<PanCardField> {
  String labelname = "";
  bool abscurepan = true;
  lastPosition() {
    widget.panController.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.panController.text.length));
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: myHeight * 0.012),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.visiblePassword,
        controller: widget.panController,
        textCapitalization: TextCapitalization.characters,
        inputFormatters: [
          UpperCaseTextFormatter(),
          NoSpecialCharactersFormatter(),
          // NoSpaceInputFormatter()
        ],
        style: TextStyle(
            // fontSize: 15,
            color: titleTextColorLight,
            fontWeight: FontWeight.normal),
        maxLength: 10,
        decoration: InputDecoration(
          counterText: '',
          labelText: widget.labelname,
          labelStyle: TextStyle(
              color: titleTextColorLight,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              height: 1.62,
              fontFamily: 'inter'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromRGBO(244, 244, 246, 1),
              width: 2.0,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
          focusColor: const Color(0xFF03314B),
          errorStyle: const TextStyle(height: 0.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 2.0,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: Color.fromRGBO(237, 237, 242, 1),
            ),
          ),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  abscurepan = !abscurepan;
                });
              },
              icon: Icon(
                abscurepan ? Icons.visibility_off : Icons.visibility,
                color: const Color.fromRGBO(211, 213, 218, 1),
              )),
        ),
        validator: (value) => validator(value),
      ),
    );
  }
}

class DobField extends StatefulWidget {
  const DobField({
    Key? key,
    required this.dobController,
    required this.labelname,
    required this.hindtext,
  }) : super(key: key);
  final TextEditingController dobController;
  final String labelname;
  final String hindtext;
  @override
  State<DobField> createState() => DobFieldState();
}

class DobFieldState extends State<DobField> {
  String labelname = "";
  bool abscurepan = true;
  lastPosition() {
    widget.dobController.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.dobController.text.length));
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: myHeight * 0.012),
      child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.dobController,
          keyboardType: TextInputType.visiblePassword,
          onChanged: lastPosition(),
          obscureText: abscurepan,
          textCapitalization: TextCapitalization.characters,
          inputFormatters: [
            UpperCaseTextFormatter(),
            NoSpecialCharactersFormatter(),
            // NoSpaceInputFormatter()
          ],
          style: TextStyle(
              // fontSize: 15,
              color: titleTextColorLight,
              fontWeight: FontWeight.normal),
          maxLength: 10,
          decoration: InputDecoration(
            counterText: '',
            labelText: widget.labelname,
            hintText: widget.hindtext,
            hintStyle: TextStyle(
                color: titleTextColorLight,
                fontSize: 15,
                height: 1.62,
                fontWeight: FontWeight.w500,
                fontFamily: 'inter'),
            labelStyle: TextStyle(
                color: titleTextColorLight,
                fontSize: 15,
                height: 1.62,
                fontWeight: FontWeight.w500,
                fontFamily: 'inter'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: titleTextColorLight,
                width: 2.0,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
            errorStyle: const TextStyle(height: 0.0),
            focusColor: const Color(0xFF03314B),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 2.0,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Color.fromRGBO(237, 237, 242, 1),
              ),
            ),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    abscurepan = !abscurepan;
                  });
                },
                icon: Icon(
                  abscurepan ? Icons.visibility_off : Icons.visibility,
                  color: const Color.fromRGBO(211, 213, 218, 1),
                )),
          ),
          validator: (value) => validator(value)),
    );
  }
}
