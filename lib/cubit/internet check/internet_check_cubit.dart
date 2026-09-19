import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_state.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetCubit extends Cubit<InternetCheckState> {
  InternetCubit()
    : super(
        InternetCheckState(
          internetConnectionState: InternetConnectionState.disconnected,
          isLoading: false,
        ),
      );

  final InternetConnection _connection = InternetConnection();
  StreamSubscription? _subscription;

  // Future<void> _init() async {
  //   emit(state.copyWith(isLoading: true));
  //   final hasNet = await _connection.hasInternetAccess;

  //   emit(
  //     state.copyWith(
  //       internetConnectionState: hasNet
  //           ? InternetConnectionState.connected
  //           : InternetConnectionState.disconnected,
  //       isLoading: false,
  //     ),
  //   );
  // }

  // void startListening() {
  //   if (_isListening) return;
  //   _isListening = true;

  //   _subscription = _connection.onStatusChange.listen((status) {
  //     emit(
  //       status == InternetStatus.connected
  //           ? InternetConnectionState.connected
  //           : InternetConnectionState.disconnected,
  //     );
  //   });
  // }

  Future<bool> hasInternet() async {
    final hasNet = await _connection.hasInternetAccess;

    return hasNet;
  }

  Future<void> retryConnection() async {
    emit(state.copyWith(isLoading: true));
    final hasNet = await _connection.hasInternetAccess;

    if (hasNet) {
      emit(
        state.copyWith(
          internetConnectionState: InternetConnectionState.connected,
          isLoading: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          internetConnectionState: InternetConnectionState.disconnected,
          isLoading: false,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
