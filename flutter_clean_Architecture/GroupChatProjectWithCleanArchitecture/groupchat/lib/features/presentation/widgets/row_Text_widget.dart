import 'package:flutter/material.dart';
import 'package:groupchat/features/presentation/widgets/theme/style.dart';

class RowTextWidget extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onTab;
  // final MainAxisAlignment? mainAxisAlignment;
  const RowTextWidget({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTab,
    // this.mainAxisAlignment
  });

  @override
  Widget build(BuildContext context) {
    return _rowTextWidget(text, linkText, onTab);
  }
}

Widget _rowTextWidget(String text, String linkText, VoidCallback onTab) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      SizedBox(
        width: 5,
      ),
      InkWell(
          onTap: onTab,
          child: Text(
            linkText,
            style: TextStyle(
                color: greenColor, fontSize: 15, fontWeight: FontWeight.w500),
          ))
    ],
  );
}
