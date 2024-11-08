import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:novoapp/core/utils/global_const.dart';

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
      if (
          //   connectivityResult.contains(ConnectivityResult.mobile)
          //  ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        emitInternetConnected(AppContsTexts.netConnected);
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

  @override
  void onChange(Change<InternetState> change) {
    print('internet change');
    print(change);
    super.onChange(change);
  }
}
