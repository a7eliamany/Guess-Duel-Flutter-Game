import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:guess_duel/cubit/start%20game/game_status_state.dart';
import 'package:guess_duel/extensions/game_status_extension.dart';
import 'package:guess_duel/extensions/player_role_extension.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/models/Rooms/rooms_model.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';

class GameStatusCubit extends Cubit<GameStatusState> {
  GameStatusCubit() : super(GameStateInitial());

  StreamSubscription? gameStatus;

  Future<void> gameStatusListen(String roomID) async {
    await gameStatus?.cancel();

    gameStatus = FirebaseFirestore.instance
        .collection(FirebaseCollections.rooms)
        .doc(roomID)
        .snapshots()
        .listen((room) {
          if (isClosed) return;
          if (!room.exists) {
            Get.snackbar("Alert", "Room is no longer exist");
            emit(GameStateDissmissed());
            return;
          } else {
            try {
              final RoomModel roomData = RoomModel.fromFirestore(room, null);
              HiveService.roomsBox.put(roomID, roomData);

              if (roomData.status == GameStatus.waiting) {
                emit(LobbyState(roomID: roomID));
              } else if (roomData.status == GameStatus.secretCode) {
                emit(SecretNumberState(roomID: roomID));
              } else if (roomData.status == GameStatus.playing) {
                emit(PlayingState(roomID: roomID));
              } else if (roomData.status == GameStatus.finished) {
                emit(GameStateFinished());
              } else {
                emit(GameStateInitial());
              }
            } catch (e) {
              emit(GameStateDissmissed());

              Get.snackbar("Error", "$e");
              gameStatus?.cancel();
            }
          }
        });
  }

  Future<void> startGame(
    String roomID,
    bool isPlayersReady, [
    RoomPlayer? player,
  ]) async {
    emit(GameStateLoading());

    try {
      if (isPlayersReady) {
        await changeGameStatus(roomID, GameStatus.secretCode);
        if (player != null) {
          toggleReady(roomID, player);
        }
      } else {
        emit(GameStartFailure(errorM: "All players must be ready"));
      }
    } on FirebaseException catch (e) {
      emit(GameStartFailure(errorM: e.message ?? "Error"));
    }
  }

  Future<void> toggleReady(String roomID, RoomPlayer roomPlayer) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.rooms)
          .doc(roomID)
          .collection(FirebaseCollections.roomPeople)
          .doc(roomPlayer.playerModel.id)
          .update({
            "RoomPlayerStatus":
                (roomPlayer.roomPlayerStatus == RoomPlayerStatus.idle)
                ? RoomPlayerStatus.ready.toFireStore()
                : RoomPlayerStatus.idle.toFireStore(),
          });
    } on FirebaseException catch (e) {
      emit(GameStartFailure(errorM: e.message ?? "Failed"));
    }
  }

  Future<void> closeLobby(String roomID) async {
    final userId = SharedPrefService.getId();
    final room = await FirebaseFirestore.instance
        .collection(FirebaseCollections.rooms)
        .doc(roomID)
        .get();
    if (!room.exists) {
      return;
    }
    final RoomModel roomModel = RoomModel.fromFirestore(room, null);

    if (roomModel.hostId == userId) {
      final roomRef = FirebaseFirestore.instance
          .collection(FirebaseCollections.rooms)
          .doc(roomID);
      final players = await roomRef
          .collection(FirebaseCollections.roomPeople)
          .get();

      final attempts = await roomRef
          .collection(FirebaseCollections.attempts)
          .get();

      final roomSettings = await roomRef
          .collection(FirebaseCollections.roomSettings)
          .get();
      final WriteBatch batch = FirebaseFirestore.instance.batch();
      for (var doc in players.docs) {
        batch.delete(doc.reference);
      }
      for (var doc in attempts.docs) {
        batch.delete(doc.reference);
      }
      for (var doc in roomSettings.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      await roomRef.delete();
    } else {
      final room = FirebaseFirestore.instance
          .collection(FirebaseCollections.rooms)
          .doc(roomID);
      await room
          .collection(FirebaseCollections.roomPeople)
          .doc(userId)
          .delete();

      final List? players = HiveService.playersBox.get(roomID) as List?;
      final int updatedCount = (players != null && players.isNotEmpty)
          ? players.length - 1
          : 0;
      await room.update({"playersCount": updatedCount});
    }

    await HiveService.clearStorageAll(roomID);
  }

  Future<void> changeGameStatus(String roomID, GameStatus gameStatus) async {
    try {
      final roomRef = FirebaseFirestore.instance
          .collection(FirebaseCollections.rooms)
          .doc(roomID);
      final doc = await roomRef.get();
      if (doc.exists) {
        // final room = RoomModel.fromFirestore(doc, null);
        // if (room.status == GameStatus.finished) return;

        await roomRef.update({"status": gameStatus.toFirestore()});
      }
    } catch (e) {
      //
    }
  }

  @override
  Future<void> close() {
    gameStatus?.cancel();

    return super.close();
  }
}
