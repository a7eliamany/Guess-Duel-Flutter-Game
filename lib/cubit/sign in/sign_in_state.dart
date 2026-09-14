class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String errorMessage;
  SignInFailure(this.errorMessage);
}

class SignOut extends SignInState {
  final String message;
  SignOut(this.message);
}
