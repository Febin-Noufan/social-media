import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/controller/signup/servises/servises.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState()) {
    on<SignUpAdd>((event, emit) async {
      emit(SignupLoadingState());

      SignUpController cntrl = SignUpController();
      final user = await cntrl.signUpWithEmailPassword(
          event.email.toString(), event.password.toString());
      await cntrl.adduser(
          event.name.toString(),
          event.username.toString(),
          event.email.toString(),
          event.password.toString(),
          event.profile,
          event.bio.toString());

      if (user != null) {
        emit(SignupSuccessState());
      } else {
        emit(const SignupErrorState(error: ""));
      }
    });
  }
}
