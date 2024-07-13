part of 'signin_bloc.dart';

sealed class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

final class SigninInitialState extends SigninState {}

final class SigninLoadingState extends SigninState {}

final class SigninSuccessState extends SigninState {}

final class SigninErrorState extends SigninState {
  final String error;

  const SigninErrorState({required this.error});

  // @override
  // List<Object?> get props => [error];
}

class SigninInvalidState extends SigninState {
  final String emailerror;
  final String passerror;

  const SigninInvalidState({required this.emailerror, required this.passerror});
}
