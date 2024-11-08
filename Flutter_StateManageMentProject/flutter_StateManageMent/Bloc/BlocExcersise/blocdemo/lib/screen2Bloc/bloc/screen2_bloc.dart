import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'screen2_event.dart';
part 'screen2_state.dart';

class Screen2Bloc extends Bloc<Screen2Event, Screen2State> {
  Screen2Bloc() : super(Screen2Initial()) {
    on<Screen2Event>((event, emit) {
      // TODO: implement event handler
    });
  }
}
