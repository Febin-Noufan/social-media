import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'profile_event.dart';
part 'profile_state.dart';
// Profile BLoC
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchUserData>(_onFetchUserData);
  }

  Future<void> _onFetchUserData(
      FetchUserData event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;
        final store = FirebaseFirestore.instance;
        final docSnapshot = await store.collection("users").doc(uid).get();
        if (docSnapshot.exists) {
          emit(ProfileLoaded(docSnapshot));
        } else {
          emit(ProfileError("User not found"));
        }
      } else {
        emit(ProfileError("No user logged in"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}