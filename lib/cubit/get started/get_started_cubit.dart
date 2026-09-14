import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guess_duel/Functions/random_f.dart';
import 'package:guess_duel/constants/app_avatars.dart';
import 'package:guess_duel/cubit/get%20started/get_started_state.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_cubit.dart';
import 'package:guess_duel/extensions/player_role_extension.dart';
import 'package:guess_duel/models/History/history_model.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/models/Players/room_player_cache.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class GetStartedCubit extends Cubit<GetStartedState> {
  final InternetCubit internetCubit;
  GetStartedCubit(this.internetCubit) : super(GetStartedInitial());

  // void checkSignin() async {
  //   final hasNet = await internetCubit.hasInternet();
  //   if (!hasNet) {
  //     emit(SigninFailure("Please check your internet connection"));
  //     return;
  //   }
  //   bool isA = FirebaseService.isUserSignedIn();
  //   if (isA) {
  //     emit(SigninSuccess());
  //   } else {
  //     emit(SignOut("No user signed in"));
  //   }
  // }

  void getStarted(String username) async {
    emit(GetStartedLoading());
    final String uniqueID = "1${RandomF.getUniqueID(14)}";

    await SharedPrefService.setId(uniqueID);
    await SharedPrefService.setUsername(username);

    final RoomPlayerCache roomPlayerCache = RoomPlayerCache(
      firebaseID: uniqueID,
      avatarID: AppAvatars.getRandomAvatar().id,
      username: username,
      lvl: 1,
      playerRole: PlayerRole.player.toFirestore(),
      roomPlayerStatus: RoomPlayerStatus.idle.toFireStore(),
      lastSeen: Timestamp.now().millisecondsSinceEpoch,
      createdAt: Timestamp.now().millisecondsSinceEpoch,
    );

    final PlayerModel playerModel = RoomPlayerCache.toPlayerModel(
      roomPlayerCache,
    );
    await HiveService.userData.put(uniqueID, roomPlayerCache);
    await HiveService.statsBox.put("Stats", StatsModel());
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.players)
          .doc(uniqueID)
          .set(playerModel.toFirestore());

      await FirebaseFirestore.instance
          .collection(FirebaseCollections.players)
          .doc(uniqueID)
          .collection(FirebaseCollections.stats)
          .doc(uniqueID)
          .set(StatsModel().toFirestore());

      emit(GetStartedSuccess());
    } on FirebaseException catch (e) {
      emit(GetStartedFailure(e.message ?? "Error"));
    }
  }

  Future<void> userLastSeen(String userID) async {
    final playerRef = FirebaseService.getCollection(
      FirebaseCollections.players,
    );

    await playerRef.doc(userID).update({
      "lastSeen": FieldValue.serverTimestamp(),
    });
  }

  // for debugging
  void getOut() async {
    emit(GetStartedLoading());
    try {
      await FirebaseService.signOut();
      emit(GetStartedOut("Signed out successfully"));
    } on FirebaseAuthException catch (e) {
      emit(GetStartedFailure(e.code.toString()));
    }
  }
}
