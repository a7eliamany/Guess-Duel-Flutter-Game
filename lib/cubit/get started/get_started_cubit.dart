import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/Functions/random_f.dart';
import 'package:guess_duel/constants/app_avatars.dart';
import 'package:guess_duel/cubit/get%20started/get_started_state.dart';
import 'package:guess_duel/cubit/internet%20check/internet_check_cubit.dart';
import 'package:guess_duel/models/History/history_model.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';
import 'package:uuid/v4.dart';

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

  Future<void> getStarted(String username) async {
    emit(GetStartedLoading());

    // id , username , current session id

    final String uniqueID = "1${RandomF.getUniqueID(12)}";
    final String currentSessionId = const UuidV4().generate();
    await SharedPrefService.setId(uniqueID);
    await SharedPrefService.setUsername(username);
    await SharedPrefService.setcurrentSessionId(currentSessionId);

    // player data

    final PlayerModel playerModel = PlayerModel(
      id: uniqueID,
      lvl: 1,
      firebaseID: FirebaseAuth.instance.currentUser?.uid ?? uniqueID,
      username: username,
      lastSeen: Timestamp.now(),
      createdAt: Timestamp.now(),
      avatarID: AppAvatars.getRandomAvatar().id,
      currentSessionId: currentSessionId,
    );

    // store data in hive
    await HiveService.userData.put(uniqueID, playerModel);
    await HiveService.statsBox.put("Stats", StatsModel());

    // store data in firebase (if user is signed in)
    if (FirebaseService.isUserSignedIn()) {
      try {
        await FirebaseFirestore.instance
            .collection(FirebaseCollections.players)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(playerModel.toFirestore());

        await FirebaseFirestore.instance
            .collection(FirebaseCollections.players)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(FirebaseCollections.stats)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(StatsModel().toFirestore());

        emit(GetStartedSuccess());
      } on FirebaseException catch (e) {
        emit(GetStartedFailure(e.message ?? "Error"));
      }
    } else {
      emit(GetStartedSuccess());
    }
  }
}
