import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:guess_duel/cubit/Rooms/rooms_state.dart';
import 'package:guess_duel/extensions/game_status_extension.dart';
import 'package:guess_duel/models/Rooms/rooms_model.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';

class RoomsCubit extends Cubit<RoomsState> {
  RoomsCubit() : super(RoomsInitial());

  StreamSubscription? _roomsSub;

  void listenToRooms() {
    emit(RoomsLoading());

    try {
      _roomsSub = FirebaseService.getCollection(FirebaseCollections.rooms)
          .where("status", isEqualTo: GameStatus.waiting.toFirestore())
          .snapshots()
          .listen((snapshot) {
            if (isClosed) return;

            final rooms = snapshot.docs
                .map((doc) => RoomModel.fromFirestore(doc, null))
                .toList();

            emit(RoomsLoaded(rooms));
          });
    } catch (e) {
      Get.snackbar("Error", "something Wrong");
      emit(RoomsError("something Wrong"));
    }
  }

  @override
  Future<void> close() {
    _roomsSub?.cancel();
    return super.close();
  }
}
