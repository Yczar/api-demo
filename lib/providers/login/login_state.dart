abstract class LoginState {}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateError extends LoginState {
  LoginStateError(
    this.errorMessage,
  );

  final String errorMessage;
}

class LoginStateLoaded extends LoginState {}
