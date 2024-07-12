part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SignUpAdd extends SignupEvent{
  String? email;
  String? password;
  String? name;
  File? profile;
  String? bio;
  String? username;

  SignUpAdd(
      {this.email,
      this.password,
      this.name,
      this.profile,
      this.bio,
      this.username});
}

class SignUpSuccess {}
