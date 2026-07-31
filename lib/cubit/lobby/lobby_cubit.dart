import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:guess_duel/cubit/lobby/lobby_state.dart';
import 'package:guess_duel/extensions/game_status_extension.dart';
import 'package:guess_duel/models/Players/room_player_cache.dart';
import 'package:guess_duel/models/Rooms/rooms_model.dart';
import 'package:guess_duel/models/lobby_model.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';

class LobbyCubit extends Cubit<LobbyDataState> {
  LobbyCubit() : super(LobbyInitial());

  StreamSubscription? lobbyStream;

  Future<void> getRoomData(String roomID) async {
    await lobbyStream?.cancel();
    emit(LobbyLoading());

    // check if room is Existed

    final roomModel = await waitForRoomData(roomID);

    if (roomModel == null) {
      Get.snackbar(
        "Error",
        "Failed to get Room Data Please check your internet and Try Again ",
      );
      emit(LobbyFailure(errorM: "Failed to load room"));
      return;
    }

    // stream for Players

    lobbyStream = FirebaseFirestore.instance
        .collection(FirebaseCollections.rooms)
        .doc(roomID)
        .collection(FirebaseCollections.roomPeople)
        .snapshots()
        .listen((players) {
          if (isClosed) return;
          if (players.docs.isEmpty) {
            emit(LobbyFailure(errorM: "Room is dismissed"));
            return;
          }

          // get players

          final List<RoomPlayer> p = players.docs
              .map((e) => RoomPlayer.fromFirestore(e.data()))
              .toList();
          final String? myID = SharedPrefService.getId();
          final RoomPlayer? opponentPlayer = _getOpponent(myID, p);
          final RoomPlayer? currentPlayer = _getMe(myID, p);

          // Store players data in Hive
          if (currentPlayer == null) {
            return;
          }
          HiveService.playersBox.put(
            HiveBoxPlayers.currentPlayer(roomID),
            RoomPlayerCache.fromModel(currentPlayer),
          );

          if (opponentPlayer != null) {
            HiveService.playersBox.put(
              HiveBoxPlayers.opponentPlayer(roomID),
              RoomPlayerCache.fromModel(opponentPlayer),
            );
          }

          HiveService.playersBox.put(
            roomID,
            p.map((player) => RoomPlayerCache.fromModel(player)).toList(),
          );

          // emit
          emit(
            LobbyLoaded(
              lobbyModel: LobbyModel(
                roomModel: roomModel,
                roomPlayers: p,
                currentPlayer: currentPlayer,
              ),
            ),
          );

          // Change game Status

          final bool allReady = p.every(
            (p) => (p.secretCode ?? '').length == 4,
          );

          if (roomModel.status != GameStatus.playing &&
              p.length > 1 &&
              allReady) {
            changeGameStatus(roomID, GameStatus.playing);
          } else if (p.length > 1 && !allReady) {
          } else if (p.length == 1) {
            changeGameStatus(roomID, GameStatus.waiting);
          }
        });
  }

  Future<RoomModel?> waitForRoomData(String roomID) async {
    for (int i = 0; i < 5; i++) {
      final room = HiveService.roomsBox.get(roomID);

      if (room != null) {
        return room;
      }

      await Future.delayed(const Duration(seconds: 2));
    }

    return null;
  }

  RoomPlayer? _getOpponent(String? myID, List<RoomPlayer> players) {
    if (myID == null) return null;
    try {
      return players.firstWhere((p) => p.playerModel.firebaseID != myID);
    } catch (_) {
      return null;
    }
  }

  RoomPlayer? _getMe(String? myID, List<RoomPlayer> players) {
    if (myID == null) return null;
    try {
      return players.firstWhere((p) => p.playerModel.firebaseID == myID);
    } catch (_) {
      return null;
    }
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
  Future<void> close() async {
    await lobbyStream?.cancel();
    return super.close();
  }
}
