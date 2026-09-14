import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/constants/app_avatars.dart';
import 'package:guess_duel/cubit/profile/profile_state.dart';
import 'package:guess_duel/models/Players/room_player_cache.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(super.initialState);

  void getInitialValue() {
    emit(state.copyWith(isLoading: true));
    final RoomPlayerCache playerData = HiveService.userData.get(
      SharedPrefService.getId(),
    );

    emit(
      state.copyWith(
        username: playerData.username,
        avatarID: playerData.avatarID,
        createdAt: playerData.createdAt,
        firebaseID: playerData.firebaseID,
        isLoading: false,
      ),
    );
  }

  void updateIsEditing() {
    emit(state.copyWith(isEditing: !state.isEditing));
  }

  Future<void> avatarOnTap() async {
    emit(state.copyWith(isLoading: true));
    String avatarId = AppAvatars.getRandomAvatar().id;
    final RoomPlayerCache oldUserData = HiveService.userData.get(
      SharedPrefService.getId(),
    );
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.players)
          .doc(SharedPrefService.getId())
          .update({'avatarID': avatarId});

      await HiveService.userData.put(
        SharedPrefService.getId(),
        oldUserData.copyWith(avatarID: avatarId),
      );

      emit(
        state.copyWith(avatarID: avatarId, isLoading: false, isErorr: false),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, isErorr: true));
    }
  }

  Future<void> updateUsername(String username) async {
    emit(state.copyWith(isLoading: true));
    final RoomPlayerCache oldUserData = HiveService.userData.get(
      SharedPrefService.getId(),
    );
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.players)
          .doc(SharedPrefService.getId())
          .update({'username': username});

      await HiveService.userData.put(
        SharedPrefService.getId(),
        oldUserData.copyWith(username: username),
      );

      emit(
        state.copyWith(username: username, isLoading: false, isEditing: false),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, isErorr: true, isEditing: false));
    }
  }
}
