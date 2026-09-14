class GetStartedState {}

class GetStartedInitial extends GetStartedState {}

class GetStartedOut extends GetStartedState {
  final String message;
  GetStartedOut(this.message);
}

class GetStartedLoading extends GetStartedState {}

class GetStartedSuccess extends GetStartedState {}

class GetStartedFailure extends GetStartedState {
  final String errorMessage;
  GetStartedFailure(this.errorMessage);
}
