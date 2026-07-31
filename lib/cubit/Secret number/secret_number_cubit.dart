import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/Secret%20number/secret_number_state.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';

class SecretNumberCubit extends Cubit<SecretNumberState> {
  SecretNumberCubit() : super(SecretNumberState.initial());

  void onKeyPress(String key) {
    String digits = state.digits;

    if (key == 'backspace') {
      if (digits.isNotEmpty) {
        digits = digits.substring(0, digits.length - 1);
      }
    } else {
      if (digits.length < 4) {
        final code = digits.split("");
        for (int i = 0; i < code.length; i++) {
          if (key == code[i]) {
            return;
          }
        }
        digits += key;
      }
    }

    emit(state.copyWith(digits: digits, currentIndex: digits.length));
  }

  void confirm(String roomID, [String? secretCode]) async {
    if (state.digits.length == 4) {
      try {
        emit(state.copyWith(roomFlow: RoomFlow.waiting));

        final room = FirebaseFirestore.instance
            .collection(FirebaseCollections.rooms)
            .doc(roomID);

        await room
            .collection(FirebaseCollections.roomPeople)
            .doc(SharedPrefService.getId())
            .update({"secretCode": secretCode ?? state.digits});

        await room.update({
          'secret_numbers.${SharedPrefService.getId()}':
              secretCode ?? state.digits,
        });
      } catch (e) {
        print(e);
      }
      if (secretCode == null) {
        if (isClosed) return;
        emit(state.copyWith(roomFlow: RoomFlow.waiting));
      }
    }
  }
}
