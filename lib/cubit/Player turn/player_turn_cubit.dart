import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/models/Players/room_player_cache.dart';
import 'package:guess_duel/models/Rooms/rooms_model.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';

class PlayerTurnCubit extends Cubit<bool> {
  PlayerTurnCubit() : super(true);

  StreamSubscription? playerTurn;
  void checkPlayerTurn(String roomID) async {
    final roomRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.rooms)
        .doc(roomID);

    playerTurn = roomRef.snapshots().listen((snapshot) {
      if (isClosed) return;

      if (!snapshot.exists) {
        return;
      }
      final RoomModel room = RoomModel.fromFirestore(snapshot, null);
      if (room.currentTurnPlayerId == SharedPrefService.getId()) {
        emit(true);
      } else {
        emit(false);
      }
    });
  }

  void changeTurn(String roomID) async {
    final roomRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.rooms)
        .doc(roomID);

    try {
      // get opponent ID

      final RoomPlayerCache oppenentData = HiveService.playersBox.get(
        HiveBoxPlayers.opponentPlayer(roomID),
      );

      final opponentID = oppenentData.id;

      //change turn
      await roomRef.update({"currentTurnPlayerId": opponentID});
    } catch (e) {
      emit(false);
    }
  }

  @override
  Future<void> close() {
    playerTurn?.cancel();
    return super.close();
  }
}
