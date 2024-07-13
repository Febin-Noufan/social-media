part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class SignUpAdd extends SignupEvent {
  final String name;
  final String username;
  final String email;
  final String password;
  final File? profile;
  final String bio;

  const SignUpAdd({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    this.profile,
    required this.bio,
  });

  @override
  List<Object?> get props => [name, username, email, password, profile, bio];
}
