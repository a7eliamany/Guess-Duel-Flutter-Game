import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:guess_duel/Functions/game_utils.dart';
import 'package:guess_duel/extensions/game_status_extension.dart';
import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/Players/room_player_cache.dart';
import 'package:guess_duel/models/Rooms/rooms_model.dart';
import 'package:guess_duel/cubit/Attempts/attempts_state.dart';
import 'package:guess_duel/screens/game_result_screen/game_result_screen.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';

class AttemptsCubit extends Cubit<AttemptsState> {
  AttemptsCubit() : super(AttemptsInitial());

  StreamSubscription? attemptsListen;

  void getAttempts(String roomID) {
    attemptsListen = FirebaseFirestore.instance
        .collection(FirebaseCollections.rooms)
        .doc(roomID)
        .collection(FirebaseCollections.attempts)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .listen((data) async {
          if (isClosed) return;
          final attempts = data.docs.map((doc) {
            return AttemptModel.fromFirestore(doc.data());
          }).toList();
          if (attempts.isNotEmpty) {
            HiveService.attemptsBox.put(roomID, attempts);
          }

          for (var attempt in attempts) {
            if (attempt.correctNumbers == 4 && attempt.correctPlaces == 4) {
              emit(AttemptsLoaded(attempts: attempts));
              await goToGameResultScreen(roomID, attempt.userId);
              return;
            }
          }
          emit(AttemptsLoaded(attempts: attempts));
        });
  }

  void addAttempts(String roomID, String attempt) async {
    try {
      //get players data from Hive

      final RoomPlayerCache? opponentPlayerData = HiveService.playersBox.get(
        HiveBoxPlayers.opponentPlayer(roomID),
      );

      final RoomPlayerCache currentPlayerData = HiveService.playersBox.get(
        HiveBoxPlayers.currentPlayer(roomID),
      );

      // check if opponent not null

      if (opponentPlayerData == null) return;

      if (opponentPlayerData.secretCode == null) {
        emit(AttemptsFailure(errorMsg: "Opponent data not ready"));
        return;
      }

      // check attempt

      final String currentPlayerID = currentPlayerData.firebaseID;

      final opponentSecretNumber = opponentPlayerData.secretCode!;

      final AttemptCheck checkAttempt = AttemptCheck.fromMap(
        attempt.checkAttempt(secretNumber: opponentSecretNumber),
      );

      // add attempt

      final AttemptModel attemptModel = AttemptModel(
        userId: currentPlayerID,
        attempt: attempt,
        correctNumbers: checkAttempt.correctNumbers,
        correctPlaces: checkAttempt.correctPlaces,
        createdAt: Timestamp.now(),
      );

      await FirebaseFirestore.instance
          .collection(FirebaseCollections.rooms)
          .doc(roomID)
          .collection(FirebaseCollections.attempts)
          .add(attemptModel.toFirestore());
    } catch (e) {
      emit(AttemptsFailure(errorMsg: e.toString()));
    }
  }

  Future<void> resetSecretNumber(String roomID) async {
    final room = FirebaseFirestore.instance
        .collection(FirebaseCollections.rooms)
        .doc(roomID);

    await room
        .collection(FirebaseCollections.roomPeople)
        .doc(FirebaseService.getCurrentUserFirebaseID())
        .update({"secretCode": ''});
  }

  Future<void> resetAttempts(String roomID) async {
    final roomRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.rooms)
        .doc(roomID);
    final batch = FirebaseFirestore.instance.batch();
    final attempts = await roomRef
        .collection(FirebaseCollections.attempts)
        .get();
    for (var doc in attempts.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
    await HiveService.attemptsBox.delete(roomID);
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

  Future<void> goToGameResultScreen(String roomID, String attemptUserId) async {
    // update winner ID in the room

    final roomRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.rooms)
        .doc(roomID);

    await roomRef.update({"winner_id": attemptUserId});

    //get data from Hive

    final List<AttemptModel> attempts = HiveService.attemptsBox.get(roomID);

    final RoomPlayerCache opponentPlayer = HiveService.playersBox.get(
      HiveBoxPlayers.opponentPlayer(roomID),
    );
    final RoomModel roomData = HiveService.roomsBox.get(roomID);

    // game result screen specific data

    final String myID = FirebaseService.getCurrentUserFirebaseID()!;

    final List<AttemptModel> yourAttempts = attempts
        .where((attempt) => attempt.userId == myID)
        .toList();
    final String? opponentSecretCode =
        roomData.secretnumbers[opponentPlayer.firebaseID];

    final bool isWin = roomData.winnerId == myID;

    // go to game result screen
    Get.to(
      () => BlocProvider(
        create: (_) => AttemptsCubit(),
        child: GameResultScreen(
          roomID: roomID,
          attempts: yourAttempts,
          opponentSecretCode: opponentSecretCode!,
          isWin: isWin,
          players: [
            FirebaseService.getCurrentUserDisplayName()!,
            opponentPlayer.username,
          ],
        ),
      ),
    );
    //update game status
    await changeGameStatus(roomID, GameStatus.finished);
    // reset data

    resetAttempts(roomID);
    resetSecretNumber(roomID);
  }

  @override
  Future<void> close() {
    attemptsListen?.cancel();
    return super.close();
  }
}
