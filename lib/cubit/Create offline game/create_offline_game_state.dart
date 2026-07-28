import 'package:guess_duel/models/offline/offline_game_model.dart';

class CreateOfflineGameState {
  final bool isCreated;
  final bool isLoading;
  final String errorMsg;
  final OfflineGameModel offlineGameModel;

  CreateOfflineGameState({
    required this.isLoading,
    required this.errorMsg,
    required this.offlineGameModel,
    required this.isCreated,
  });

  //copy with
  CreateOfflineGameState copyWith({
    bool? isLoading,
    String? errorMsg,
    OfflineGameModel? offlineGameModel,
    bool? isCreated,
  }) {
    return CreateOfflineGameState(
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
      offlineGameModel: offlineGameModel ?? this.offlineGameModel,
      isCreated: isCreated ?? this.isCreated,
    );
  }

  //getters
  bool get getIsLoading => isLoading;
  String get getErrorMsg => errorMsg;
}
