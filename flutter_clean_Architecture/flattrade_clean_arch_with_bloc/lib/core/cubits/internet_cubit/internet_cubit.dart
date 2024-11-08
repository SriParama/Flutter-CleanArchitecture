import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flattrade/core/utils/text_contants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription<List<ConnectivityResult>>? connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        emitInternetConnected(APPTextConstants.netonnected);
      } else if (connectivityResult.contains(ConnectivityResult.none)) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetDisconnected() => emit(InternetDisconnected());

  void emitInternetConnected(String connectionType) =>
      emit(InternetConnected(status: connectionType));

  @override
  Future<void> close() {
    connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
