import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guess_duel/Functions/random_f.dart';
import 'package:guess_duel/cubit/SignIn/signin_state.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_cubit.dart';
import 'package:guess_duel/extensions/player_role_extension.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/models/Players/room_player_cache.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SigninCubit extends Cubit<SigninState> {
  final InternetCubit internetCubit;
  SigninCubit(this.internetCubit) : super(SigninInitial());

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
    final String uniqueUsername = "${username}_${RandomF.getUniqueID(5)}";
    final String uniqueID = "1${RandomF.getUniqueID(14)}";

    emit(SigninLoading());
    await Future.delayed(const Duration(seconds: 2));
    await SharedPrefService.setId(uniqueID);
    await SharedPrefService.setUsername(uniqueUsername);

    final RoomPlayerCache roomPlayerCache = RoomPlayerCache(
      firebaseID: uniqueID,
      username: uniqueUsername,
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
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.players)
          .doc(uniqueID)
          .set(playerModel.toFirestore());

      emit(SigninSuccess());
    } on FirebaseException catch (e) {
      emit(SigninFailure(e.message ?? "Error"));
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
  void signOut() async {
    emit(SigninLoading());
    try {
      await FirebaseService.signOut();
      emit(SignOut("Signed out successfully"));
    } on FirebaseAuthException catch (e) {
      emit(SigninFailure(e.code.toString()));
    }
  }
}
