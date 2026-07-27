import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum InternetConnectionState { connected, disconnected }

class InternetCubit extends Cubit<InternetConnectionState> {
  InternetCubit() : super(InternetConnectionState.connected) {
    _init();
  }

  final InternetConnection _connection = InternetConnection();
  StreamSubscription? _subscription;
  bool _isListening = false;

  Future<void> _init() async {
    final hasNet = await _connection.hasInternetAccess;

    emit(
      hasNet
          ? InternetConnectionState.connected
          : InternetConnectionState.disconnected,
    );

    startListening();
  }

  void startListening() {
    if (_isListening) return;
    _isListening = true;

    _subscription = _connection.onStatusChange.listen((status) {
      emit(
        status == InternetStatus.connected
            ? InternetConnectionState.connected
            : InternetConnectionState.disconnected,
      );
    });
  }

  Future<bool> hasInternet() {
    return _connection.hasInternetAccess;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
