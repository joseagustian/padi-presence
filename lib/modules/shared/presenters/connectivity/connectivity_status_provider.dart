
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityStatusState {
  final bool isConnected;

  ConnectivityStatusState({
    required this.isConnected
  });

  ConnectivityStatusState copyWith({
    bool? isConnected
  }) {
    return ConnectivityStatusState(
      isConnected: isConnected ?? this.isConnected
    );
  }

}

class ConnectivityStatusProvider extends StateNotifier<ConnectivityStatusState> {

  StreamSubscription<InternetStatus>? _connectionChangeStream;


  ConnectivityStatusProvider() : super(ConnectivityStatusState(isConnected: true)) {
    _init();
    _checkConnectionStatus();
  }

  void _init() async {
    bool isConnected = await InternetConnection().hasInternetAccess;
    state = state.copyWith(isConnected: isConnected);
  }

  void _checkConnectionStatus() async {

    final listener = InternetConnection().onStatusChange.listen((status) {
      if (status == InternetStatus.connected) {
        state = state.copyWith(isConnected: true);
      } else {
        state = state.copyWith(isConnected: false);
      }
    });

    _connectionChangeStream = listener;

  }


  @override
  void dispose() {
    _connectionChangeStream?.cancel();
    super.dispose();
  }

}

final connectivityStatusProvider = StateNotifierProvider<ConnectivityStatusProvider, ConnectivityStatusState>((ref) {
  return ConnectivityStatusProvider();
});

