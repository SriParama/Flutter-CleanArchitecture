import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'screen1_event.dart';
part 'screen1_state.dart';

class Screen1Bloc extends Bloc<Screen1Event, Screen1State> {
  Screen1Bloc() : super(Screen1Initial()) {
    on<Screen1Event>((event, emit) {
      // TODO: implement event handler
    });
  }
}
