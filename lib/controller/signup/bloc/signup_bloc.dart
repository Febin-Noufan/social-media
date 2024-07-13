import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/controller/signup/servises/servises.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState()) {
    on<SignUpAdd>((event, emit) async {
      final nameError = _validateName(event.name);
      final usernameError = _validateUsername(event.username);
      final emailError = _validateEmail(event.email);
      final passwordError = _validatePassword(event.password);
      final bioError = _validateBio(event.bio);

      if (nameError != null ||
          usernameError != null ||
          emailError != null ||
          passwordError != null ||
          bioError != null) {
        emit(SignupErrorState(
            error: _getErrorMessage(nameError, usernameError, emailError,
                passwordError, bioError)));
      } else {
        emit(SignupLoadingState());

        SignUpController cntrl = SignUpController();
        final user =
            await cntrl.signUpWithEmailPassword(event.email, event.password);
        await cntrl.adduser(event.name, event.username, event.email,
            event.password, event.profile, event.bio);

        if (user != null) {
          emit(SignupSuccessState());
        } else {
          emit(const SignupErrorState(error: "Failed to sign up"));
        }
      }
    });
  }

  String? _validateName(String name) {
    if (name.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  String? _validateUsername(String username) {
    if (username.isEmpty) {
      return 'Username cannot be empty';
    }
    return null;
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateBio(String bio) {
    if (bio.isEmpty) {
      return 'Bio cannot be empty';
    }
    return null;
  }

  String _getErrorMessage(String? nameError, String? usernameError,
      String? emailError, String? passwordError, String? bioError) {
    final errors = [
      nameError,
      usernameError,
      emailError,
      passwordError,
      bioError
    ];
    return errors.firstWhere((error) => error != null)!;
  }
}
