part of 'signin_bloc.dart';

sealed class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class SigninButtonClick extends SigninEvent {
  final String email;
  final String password;

  const SigninButtonClick({required this.email, required this.password});
}
