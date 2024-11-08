import 'package:flutter/material.dart';

class Chapter3Home extends StatefulWidget {
  const Chapter3Home({super.key});

  @override
  State<Chapter3Home> createState() => _Chapter3HomeState();
}

class _Chapter3HomeState extends State<Chapter3Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
    );
  }
}
