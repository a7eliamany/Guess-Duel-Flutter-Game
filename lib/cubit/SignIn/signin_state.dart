class SigninState {}

class SigninInitial extends SigninState {}

class SignOut extends SigninState {
  final String message;
  SignOut(this.message);
}

class SigninLoading extends SigninState {}

class SigninSuccess extends SigninState {}

class SigninFailure extends SigninState {
  final String errorMessage;
  SigninFailure(this.errorMessage);
}
