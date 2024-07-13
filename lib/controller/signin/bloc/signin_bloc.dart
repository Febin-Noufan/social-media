import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/controller/signin/servises/servis.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitialState()) {
    on<SigninButtonClick>((event, emit) async {
      final emailError = validateEmail(event.email);
      final passwordError = validatePassword(event.password);

      if (emailError != null || passwordError != null) {
        emit(SigninErrorState(
            error: getErrorMessage(emailError, passwordError)));
      } else {
        emit(SigninLoadingState());
        SigninController cntr = SigninController();
        final user = await cntr.signIn(event.email, event.password);

        if (user != null) {
          emit(SigninSuccessState());
        } else {
          emit(const SigninErrorState(error: "Faild to sign in"));
        }
      }
    });
  }

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String getErrorMessage(
    String? emailError,
    String? passwordError,
  ) {
    final errors = [
      emailError,
      passwordError,
    ];
    return errors.firstWhere((error) => error != null)!;
  }
}
