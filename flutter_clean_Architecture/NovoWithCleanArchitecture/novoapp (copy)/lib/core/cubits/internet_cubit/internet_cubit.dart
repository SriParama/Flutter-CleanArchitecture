import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:novoapp/core/utils/global_const.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  final controller = StreamController<ConnectivityResult>();
  // StreamSubscription<List<ConnectivityResult>>? connectivityStreamSubscription;
  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
    connectivity.onConnectivityChanged.listen((event) {
      controller.sink.add(event.first);
    });
  }
  monitorInternetConnection() {
    controller.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        //print(event);
        emit(InternetDisconnected());
        // emitInternetDisconnected();
      } else {
        //print(event);
        emit(InternetConnected(status: "success"));
        // emitInternetConnected(AppContsTexts.netConnected);
      }
    });
    // return connectivityStreamSubscription =
    //     connectivity.onConnectivityChanged.listen((connectivityResult) {
    //   if (
    //       //   connectivityResult.contains(ConnectivityResult.mobile)
    //       //  ||
    //       connectivityResult.contains(ConnectivityResult.wifi)) {
    //     emitInternetConnected(AppContsTexts.netConnected);
    //   } else if (connectivityResult.contains(ConnectivityResult.none)) {
    //     emitInternetDisconnected();
    //   }
    // });
  }

  void emitInternetDisconnected() => emit(InternetDisconnected());
  void emitInternetConnected(String connectionType) =>
      emit(InternetConnected(status: connectionType));

  @override
  Future<void> close() {
    controller.close();
    return super.close();
  }

  @override
  void onChange(Change<InternetState> change) {
    print('internet change');
    print(change);
    super.onChange(change);
  }
}
