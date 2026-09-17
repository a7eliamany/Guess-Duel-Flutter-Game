import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/constants/app_avatars.dart';
import 'package:guess_duel/cubit/profile/profile_state.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
    : super(ProfileState(createdAt: DateTime(2026).millisecondsSinceEpoch));

  void getInitialValue() {
    emit(state.copyWith(isLoading: true));
    final PlayerModel playerData = HiveService.userData.get(
      SharedPrefService.getId(),
    );

    emit(
      state.copyWith(
        id: playerData.id,
        username: playerData.username,
        avatarID: playerData.avatarID,
        createdAt: playerData.createdAt.millisecondsSinceEpoch,
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
    final PlayerModel oldUserData = HiveService.userData.get(
      SharedPrefService.getId(),
    );

    if (FirebaseService.isUserSignedIn()) {
      try {
        await FirebaseFirestore.instance
            .collection(FirebaseCollections.players)
            .doc(state.firebaseID)
            .update({'avatarID': avatarId});
      } catch (_) {}
    }
    await HiveService.userData.put(
      SharedPrefService.getId(),
      oldUserData.copyWith(avatarID: avatarId),
    );

    emit(state.copyWith(avatarID: avatarId, isLoading: false, isErorr: false));
  }

  Future<void> updateUsername(String username) async {
    emit(state.copyWith(isLoading: true));
    final PlayerModel oldUserData = HiveService.userData.get(
      SharedPrefService.getId(),
    );
    if (FirebaseService.isUserSignedIn()) {
      try {
        await FirebaseFirestore.instance
            .collection(FirebaseCollections.players)
            .doc(oldUserData.firebaseID)
            .update({'username': username});
      } catch (_) {}
    }
    await HiveService.userData.put(
      SharedPrefService.getId(),
      oldUserData.copyWith(username: username),
    );
    emit(
      state.copyWith(username: username, isLoading: false, isEditing: false),
    );
  }
}
