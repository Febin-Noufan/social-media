part of 'profile_bloc.dart';
// Profile Events
abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUserData extends ProfileEvent {}