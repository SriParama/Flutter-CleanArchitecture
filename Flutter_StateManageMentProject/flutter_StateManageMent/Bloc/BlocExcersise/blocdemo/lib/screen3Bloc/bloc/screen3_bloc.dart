import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'screen3_event.dart';
part 'screen3_state.dart';

class Screen3Bloc extends Bloc<Screen3Event, Screen3State> {
  Screen3Bloc() : super(Screen3Initial()) {
    on<Screen3Event>((event, emit) {
      // TODO: implement event handler
    });
  }
}
