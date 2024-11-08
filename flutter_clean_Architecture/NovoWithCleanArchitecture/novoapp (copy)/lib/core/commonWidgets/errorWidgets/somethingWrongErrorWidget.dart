import 'package:flutter/material.dart';

class SomethingWentWrongErrorPage extends StatelessWidget {
  const SomethingWentWrongErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Something Went Wrong..."),
    );

    // Scaffold(
    //   appBar: AppBar(
    //     title: Text("error"),
    //   ),
    //   body: Center(
    //     child: Text("Something Went Wrong..."),
    //   ),
    // );
  }
}
