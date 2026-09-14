import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/sign%20in/sign_in_state.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';

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
}
