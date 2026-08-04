enum InternetConnectionState { connected, disconnected }

class InternetCheckState {
  final InternetConnectionState internetConnectionState;
  final bool isLoading;

  InternetCheckState({
    required this.internetConnectionState,
    required this.isLoading,
  });

  // copy with

  InternetCheckState copyWith({
    InternetConnectionState? internetConnectionState,
    bool? isLoading,
  }) {
    return InternetCheckState(
      internetConnectionState:
          internetConnectionState ?? this.internetConnectionState,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
