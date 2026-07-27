import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guess_duel/Functions/random_f.dart';
import 'package:guess_duel/cubit/SignIn/signin_state.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_cubit.dart';

import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SigninCubit extends Cubit<SigninState> {
  final InternetCubit internetCubit;
  SigninCubit(this.internetCubit) : super(SigninLoading());

  void checkSignin() async {
    final hasNet = await internetCubit.hasInternet();
    if (!hasNet) {
      emit(SigninFailure("Please check your internet connection"));
      return;
    }
    bool isA = FirebaseService.isUserSignedIn();
    if (isA) {
      emit(SigninSuccess());
    } else {
      emit(SignOut("No user signed in"));
    }
  }

  void signIn(String username) async {
    final hasNet = await internetCubit.hasInternet();
    if (!hasNet) {
      emit(SigninFailure("Please check your internet connection"));
      return;
    }
    final String uniqueUsername = "${username}_${RandomF.getUniqueID(5)}";
    final String uniqueID = "1${RandomF.getUniqueID(9)}";

    emit(SigninLoading());

    try {
      await FirebaseService.signInAnonymously();
      await FirebaseService.updateDisplayName(uniqueUsername);
      final String firebaseID = FirebaseService.getCurrentUserFirebaseID()!;
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.players)
          .doc(firebaseID)
          .set(
            PlayerModel(
              id: uniqueID,
              firebaseID: firebaseID,
              lvl: 1,

              username: uniqueUsername,
              createdAt: Timestamp.now(),
              lastSeen: Timestamp.now(),
            ).toFirestore(),
          );
      emit(SigninSuccess());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          emit(SigninFailure("Anonymous sign-in is not enabled."));
          break;
        default:
          emit(SigninFailure(e.code.toString()));
      }
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
