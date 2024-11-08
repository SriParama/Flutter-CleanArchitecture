import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'index_change_state.dart';

class IndexChangeCubit extends Cubit<int> {
  int _previousIndex;
  IndexChangeCubit()
      : _previousIndex = 0,
        super(0);
  void changeIndex(int newIndex) {
    _previousIndex = state;
    emit(newIndex);
  }

  int get previousIndex => _previousIndex;
}
