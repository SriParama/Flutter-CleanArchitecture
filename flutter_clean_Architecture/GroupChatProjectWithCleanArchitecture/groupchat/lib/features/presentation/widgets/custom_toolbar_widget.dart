import 'package:flutter/material.dart';

import 'theme/style.dart';

typedef ToolBarIndexController = Function(int index);

class CustomTabBar extends StatelessWidget {
  final ToolBarIndexController tabClickListener;
  final int? pageindex;

  const CustomTabBar(
      {Key? key, this.pageindex = 0, required this.tabClickListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TabBarCustomButton(
              width: 50,
              text: "Groups",
              textColor: pageindex == 0 ? textIconColor : textIconColorGray,
              borderColor: pageindex == 0 ? textIconColor : Colors.transparent,
              onTap: () {
                tabClickListener(0);
              },
            ),
          ),
          Expanded(
            child: TabBarCustomButton(
              text: "Users",
              textColor: pageindex == 1 ? textIconColor : textIconColorGray,
              borderColor: pageindex == 1 ? textIconColor : Colors.transparent,
              onTap: () {
                tabClickListener(1);
              },
            ),
          ),
          Expanded(
            child: TabBarCustomButton(
              text: "Profile",
              textColor: pageindex == 2 ? textIconColor : textIconColorGray,
              borderColor: pageindex == 2 ? textIconColor : Colors.transparent,
              onTap: () {
                tabClickListener(2);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TabBarCustomButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color borderColor;
  final double borderWidth;
  final Color textColor;
  final VoidCallback onTap;

  const TabBarCustomButton({
    Key? key,
    this.text = "",
    this.width = 50.0,
    this.height = 50.0,
    this.borderColor = Colors.white,
    this.borderWidth = 3.0,
    this.textColor = Colors.white,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: borderColor, width: borderWidth))),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
        ),
      ),
    );
  }
}
