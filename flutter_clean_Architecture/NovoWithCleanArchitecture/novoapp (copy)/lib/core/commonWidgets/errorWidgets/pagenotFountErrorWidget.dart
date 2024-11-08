import 'package:flutter/material.dart';

class PageNotFoundErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("error"),
      ),
      body: Center(
        child: Text("PageNot Found"),
      ),
    );
  }
}
