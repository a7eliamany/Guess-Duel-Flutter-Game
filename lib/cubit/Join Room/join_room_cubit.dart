import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/Join%20Room/join_room_state.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_cubit.dart';
import 'package:guess_duel/extensions/player_role_extension.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/models/Players/room_player_cache.dart';
import 'package:guess_duel/models/room_settings_model.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';

class JoinRoomCubit extends Cubit<JoinRoomState> {
  JoinRoomCubit(this.internetCubit) : super(JoinRoomInitial());

  final InternetCubit internetCubit;

  Future<void> joinRoom(String roomId) async {
    emit(JoinRoomLoading());
    try {
      final hasNet = await internetCubit.hasInternet();
      if (!hasNet) {
        emit(JoinRoomFailure(errorM: "Please check your internet connection"));
        return;
      }

      final room = FirebaseFirestore.instance
          .collection(FirebaseCollections.rooms)
          .doc(roomId);
      List<RoomPlayer> players = await FirebaseService.getPeopleRoomData(
        roomId,
      );
      if (players.length > 1) {
        emit(JoinRoomFailure(errorM: "Room is full"));
        return;
      }
      final userID = SharedPrefService.getId();
      if (userID == null) {
        emit(JoinRoomFailure(errorM: "User not logged in"));
        return;
      }
      final PlayerModel playerData = RoomPlayerCache.toPlayerModel(
        HiveService.playersBox.get(userID),
      );
      final RoomPlayer roomPlayerData = RoomPlayer(
        roomPlayerStatus: RoomPlayerStatus.idle,
        playerModel: playerData,
        playerRole: PlayerRole.player,
      );
      await room
          .collection(FirebaseCollections.roomPeople)
          .doc(userID)
          .set(roomPlayerData.toFirestore());

      // Update room playersCount in Firestore to include the joining player
      await room.update({"playersCount": players.length + 1});

      emit(JoinRoomLoaded(roomId: roomId));
    } catch (e) {
      emit(JoinRoomFailure(errorM: "Something Wrong"));
    }
  }

  Future<bool> isRoomExist(String roomId) async {
    try {
      final room = await FirebaseFirestore.instance
          .collection(FirebaseCollections.rooms)
          .doc(roomId)
          .get();
      if (!room.exists) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> checkRoomStatus(String roomId) async {
    emit(JoinRoomLoading());

    try {
      //chect if Room is Exist
      if (!await isRoomExist(roomId)) {
        emit(JoinRoomFailure(errorM: "Room not Found"));
        return;
      }

      // get room settings

      final RoomSettingsModel? roomSettings = await getRoomSettings(roomId);
      if (roomSettings == null) {
        emit(JoinRoomFailure(errorM: "Something Wrong"));
        return;
      }
      //check if the room is private and password

      // 1: room is private
      if (roomSettings.isPrivate!) {
        emit(CheckingRoomPassword(password: roomSettings.roomPassword!));
        return;
      } else {
        // 2: room is not private

        emit(JoinRoomLoading());
        await joinRoom(roomId);
      }
    } catch (e) {
      emit(JoinRoomFailure(errorM: "Something Wrong"));
    }
  }

  Future<RoomSettingsModel?> getRoomSettings(String roomId) async {
    try {
      final roomSettings = await FirebaseFirestore.instance
          .collection(FirebaseCollections.rooms)
          .doc(roomId)
          .collection(FirebaseCollections.roomSettings)
          .doc(roomId)
          .get();
      if (!roomSettings.exists) {
        return null;
      } else {
        return RoomSettingsModel.fromFirestore(roomSettings.data()!);
      }
    } catch (e) {
      emit(JoinRoomFailure(errorM: "Something Wrong"));
      return null;
    }
  }
}
