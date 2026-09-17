import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guess_duel/cubit/sign%20in/sign_in_state.dart';
import 'package:guess_duel/models/History/history_model.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignOut("User is not signed in"));

  void checkSignIn() {
    final bool isSignedIn = FirebaseService.isUserSignedIn();
    if (isSignedIn) {
      emit(SignInSuccess());
    } else {
      emit(SignOut("User is not signed in"));
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    emit(SignInLoading());

    // Create account in firebase
    final UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          emit(SignInFailure("This email is already in use"));
          break;

        case 'invalid-email':
          emit(SignInFailure("Invalid email address"));
          break;

        case 'weak-password':
          emit(SignInFailure("Password is too weak"));
          break;

        case 'operation-not-allowed':
          emit(SignInFailure("Email/password sign-up is not enabled"));
          break;

        default:
          emit(SignInFailure("Failed to create account"));
      }

      return;
    }
    // push data to firebase
    await pushDataToFirebase(userCredential.user!.uid);

    emit(SignInSuccess());
  }

  Future<void> signIn(String email, String password) async {
    emit(SignInLoading());

    // sign in
    final UserCredential? userCredential;

    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          emit(SignInFailure("Email or password is incorrect"));
          break;

        case 'invalid-email':
          emit(SignInFailure("Invalid email address"));
          break;

        case 'user-disabled':
          emit(SignInFailure("This account has been disabled"));
          break;

        case 'too-many-requests':
          emit(SignInFailure("Too many attempts. Try again later"));
          break;

        default:
          emit(SignInFailure("Failed to sign in"));
      }

      return;
    }
    // get userdata from firebase
    await pullDataFromFirebase(userCredential.user!.uid);

    emit(SignInSuccess());
  }

  Future<void> signInWithGoogle() async {
    emit(SignInLoading());
    try {
      final UserCredential userCredential;
      try {
        // Trigger the authentication flow
        final GoogleSignInAccount googleUser = await GoogleSignIn.instance
            .authenticate();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth = googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        userCredential = await FirebaseAuth.instance.signInWithCredential(
          credential,
        );
      } catch (_) {
        emit(SignInFailure("You have cancelled the sign in process"));
        return;
      }

      // check if player is new
      final bool isNewUser =
          userCredential.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser) {
        await pushDataToFirebase(userCredential.user!.uid);
      } else {
        await pullDataFromFirebase(userCredential.user!.uid);
      }

      emit(SignInSuccess());
    } catch (_) {
      emit(SignInFailure("Something went wrong"));
    }
  }

  Future<void> signInWithFacebook() async {
    emit(SignInLoading());
    emit(SignInFailure("COMING SOON..."));
    return;
    try {
      final UserCredential userCredential;
      try {
        // Trigger the sign-in flow
        final LoginResult loginResult = await FacebookAuth.instance.login();
        // print('================ FACEBOOK ================');
        // print('STATUS: ${loginResult.status}');
        // print('MESSAGE: ${loginResult.message}');
        // print('ACCESS TOKEN: ${loginResult.accessToken}');
        // print('==========================================');

        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(
              loginResult.accessToken!.tokenString,
            );

        // Once signed in, return the UserCredential
        userCredential = await FirebaseAuth.instance.signInWithCredential(
          facebookAuthCredential,
        );
      } catch (e) {
        // coming soon
        // print("error is : ${e.toString()}");
        emit(SignInFailure(e.toString()));
        return;
      }

      final bool isNewUser =
          userCredential.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser) {
        await pushDataToFirebase(userCredential.user!.uid);
      } else {
        await pullDataFromFirebase(userCredential.user!.uid);
      }
    } catch (_) {
      emit(SignInFailure("Failed to sign in with Facebook"));
      return;
    }

    emit(SignInSuccess());
  }

  Future<void> logOut() async {
    emit(SignInLoading());

    // sign out from firebase
    await FirebaseAuth.instance.signOut();

    emit(SignOut("You have been signed out successfully"));

    // delete data from Hive
    await HiveService.clearAllBoxes();

    // delete for Sharedpref
    await SharedPrefService.clear();
  }

  Future<void> pushDataToFirebase(String firebaseID) async {
    // get local data if is exist
    final String? id = SharedPrefService.getId();
    if (id != null) {
      final StatsModel? statsModel = await HiveService.statsBox.get("Stats");

      final PlayerModel? playerModel = await HiveService.userData.get(id);
      // Upload stats to firebase
      try {
        if (statsModel != null) {
          await FirebaseFirestore.instance
              .collection(FirebaseCollections.players)
              .doc(firebaseID)
              .collection(FirebaseCollections.stats)
              .doc(firebaseID)
              .set(statsModel.toFirestore());
        }
        // Upload player data to firebase
        if (playerModel != null) {
          await FirebaseFirestore.instance
              .collection(FirebaseCollections.players)
              .doc(firebaseID)
              .set(playerModel.copyWith(firebaseID: firebaseID).toFirestore());
        }
      } on FirebaseException catch (e) {
        emit(SignInFailure(e.message ?? "Failed to sign up"));
        return;
      }
    }
  }

  Future<void> pullDataFromFirebase(String firebaseID) async {
    try {
      final playerData = await FirebaseFirestore.instance
          .collection(FirebaseCollections.players)
          .doc(firebaseID)
          .get();

      final statsData = await FirebaseFirestore.instance
          .collection(FirebaseCollections.players)
          .doc(firebaseID)
          .collection(FirebaseCollections.stats)
          .doc(firebaseID)
          .get();

      // clear date in hive if exists

      if (SharedPrefService.getId() != null) {
        await HiveService.clearAllBoxes();
      }

      //handle playerdata
      if (playerData.exists) {
        final PlayerModel playerModel = PlayerModel.fromFirestore(
          playerData.data()!,
        );

        //save to hive and sharedpref
        await HiveService.userData.put(playerModel.id, playerModel);
        await SharedPrefService.setId(playerModel.id);
        await SharedPrefService.setUsername(playerModel.username);
      }

      // handle statsData
      if (statsData.exists) {
        final StatsModel statsModel = StatsModel.fromFirestore(
          statsData.data()!,
        );
        await HiveService.statsBox.put("Stats", statsModel);
      }
    } catch (e) {
      emit(SignInFailure(e.toString()));
    }
  }
}
