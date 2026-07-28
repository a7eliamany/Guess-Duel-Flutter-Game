import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/Functions/random_f.dart';
import 'package:guess_duel/cubit/Create%20offline%20game/create_offline_game_state.dart';
import 'package:guess_duel/models/offline/offline_game_model.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';

class CreateOfflineGameCubit extends Cubit<CreateOfflineGameState> {
  CreateOfflineGameCubit()
    : super(
        CreateOfflineGameState(
          isLoading: false,
          errorMsg: "",
          offlineGameModel: const OfflineGameModel(id: ''),
          isCreated: false,
        ),
      );

  Future<void> createOfflineGame(OfflineGameModel offlineGameModel) async {
    emit(state.copyWith(isLoading: true, errorMsg: "", isCreated: false));
    await Future.delayed(const Duration(seconds: 3));
    try {
      // generate a secret code
      final secretCode = RandomF.generateSecretCode(
        offlineGameModel.digits,
        offlineGameModel.allowRepeatedDigits,
      );
      // set GameiD
      final gameId = RandomF.getRandomRoomID(6);

      offlineGameModel = offlineGameModel.copyWith(
        secretCode: secretCode,
        id: gameId,
      );
      // Save in local Storgae

      await HiveService.offlineGameBox.put(gameId, offlineGameModel);

      emit(
        state.copyWith(
          isLoading: false,
          offlineGameModel: offlineGameModel,
          isCreated: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMsg: "Failed to create game: ${e.toString()}",
          isCreated: false,
        ),
      );
    }
  }
}
