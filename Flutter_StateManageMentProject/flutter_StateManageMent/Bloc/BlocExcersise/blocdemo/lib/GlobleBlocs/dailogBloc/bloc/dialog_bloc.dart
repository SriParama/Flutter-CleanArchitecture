import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'dialog_event.dart';

class DialogBloc extends Bloc<DialogEvent, bool> {
  final GlobalKey<NavigatorState> navigatorkey;
  DialogBloc({required this.navigatorkey}) : super(false) {
    on<DailogOpenEvent>((event, emit) {
      _showDialog(event);
      emit(true);
    });
    on<DailogHideEvent>(
      (event, emit) {
        if (navigatorkey.currentState != null) {
          Navigator.of(navigatorkey.currentContext!).pop(); // Close the dialog
        }
        // navigatorkey.currentState?.pop();
        emit(false);
      },
    );
  }

  void _showDialog(DailogOpenEvent event) {
    showDialog(
      context: navigatorkey.currentContext!,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(event.title),
                    InkWell(
                      child: const Icon(Icons.close),
                      onTap: () {
                        add(DailogHideEvent());
                      },
                    )
                  ],
                ),
              ),
              event.content,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (event.confirmButtonText != null)
                    ElevatedButton(
                      onPressed: () {
                        event.onConfirm?.call();
                        // add(DailogHideEvent());
                      },
                      child: Text(event.confirmButtonText!),
                    ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
