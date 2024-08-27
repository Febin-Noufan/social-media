part of 'profile_bloc.dart';

// Profile States
abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final DocumentSnapshot userData;

  ProfileLoaded(this.userData);

  @override
  List<Object> get props => [userData];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object> get props => [message];
}