import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'snackbar_event.dart';

class SnackbarBloc extends Bloc<SnackbarEvent, void> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  SnackbarBloc({required this.scaffoldMessengerKey}) : super(null) {
    on<GlobleSnackbarEvent>(globleSnackbarEvent);
  }

  FutureOr<void> globleSnackbarEvent(
      GlobleSnackbarEvent event, Emitter<void> emit) {
    scaffoldMessengerKey.currentState!.clearSnackBars();
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          event.snackMessage,
          style: TextStyle(fontSize: 14.0, color: event.snackTextColor),
          textAlign: TextAlign.left,
        ),
        backgroundColor: event.snackbgColor,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        elevation: 20,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        // behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}
