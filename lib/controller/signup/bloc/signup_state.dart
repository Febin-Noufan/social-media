part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object?> get props => [];
}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {}

class SignupErrorState extends SignupState {
  final String error;

  const SignupErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}

class SignupInvalidState extends SignupState {
  final String nameError;
  final String usernameError;
  final String emailError;
  final String passwordError;
  final String bioError;

  const SignupInvalidState({
    required this.nameError,
    required this.usernameError,
    required this.emailError,
    required this.passwordError,
    required this.bioError,
  });

  @override
  List<Object?> get props =>
      [nameError, usernameError, emailError, passwordError, bioError];
}
