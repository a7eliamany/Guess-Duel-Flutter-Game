import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:guess_duel/Functions/random_f.dart';
import 'package:guess_duel/cubit/Create%20game/create_game_state.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_cubit.dart';
import 'package:guess_duel/extensions/game_status_extension.dart';
import 'package:guess_duel/extensions/player_role_extension.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/models/Players/room_player_cache.dart';
import 'package:guess_duel/models/Rooms/rooms_model.dart';
import 'package:guess_duel/models/Room%20Settings/room_settings_model.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';

class CreateRoomCubit extends Cubit<CreateRoomState> {
  final InternetCubit internetCubit;

  CreateRoomCubit(this.internetCubit) : super(CreateRoomInitial());

  Future<void> createRoom(String roomName, RoomSettingsModel settings) async {
    emit(CreateRoomLoading());
    try {
      final hasNet = await internetCubit.hasInternet();
      if (!hasNet) {
        emit(CreateRoomError(error: "Please check your internet connection"));
        return;
      }
      final roomID = RandomF.getRandomRoomID(6);
      final userId = SharedPrefService.getId();

      if (userId == null) {
        emit(CreateRoomError(error: "User not logged in"));
        return;
      }

      final PlayerModel playerData = RoomPlayerCache.toPlayerModel(
        HiveService.userData.get(userId),
      );

      final RoomPlayer roomPlayer = RoomPlayer(
        roomPlayerStatus: RoomPlayerStatus.ready,
        playerModel: playerData,
        playerRole: PlayerRole.host,
      );

      final RoomModel roomModel = RoomModel(
        roomName: roomName,
        roomId: roomID,
        hostId: userId,
        currentTurnPlayerId: userId,
        maxPlayers: 2,
        playersCount: 1,
        winnerId: '',
        status: GameStatus.waiting,
        createdAt: Timestamp.now(),
        secretnumbers: {},
        isPrivate: settings.isPrivate ?? false,
      );

      final room = FirebaseFirestore.instance
          .collection(FirebaseCollections.rooms)
          .doc(roomID);

      await room.set(roomModel.toFirestore());
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.rooms)
          .doc(roomID)
          .collection(FirebaseCollections.roomPeople)
          .doc(roomPlayer.playerModel.firebaseID)
          .set(roomPlayer.toFirestore());
      settings = settings.copyWith(roomID: roomID);
      await room
          .collection(FirebaseCollections.roomSettings)
          .doc(roomID)
          .set(settings.toFirestore());

      await HiveService.roomsBox.put(roomID, roomModel);

      // save roomSettings to Hive

      await HiveService.roomSettings.put(roomID, settings);

      emit(CreateRoomSuccess(roomID));
    } catch (e) {
      emit(CreateRoomError(error: e.toString()));
    }
  }
}
