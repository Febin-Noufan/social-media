import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/controller/addpost/bloc/postadd_event.dart';
import 'package:flutter_application_1/controller/addpost/bloc/postadd_state.dart';
import 'package:flutter_application_1/controller/addpost/serviese/post_service.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostState.initial()) {
    on<TextChanged>((event, emit) {
      emit(state.copyWith(text: event.text));
    });

    on<ImagePicked>((event, emit) {
      emit(state.copyWith(image: event.image));
    });

    on<SubmitPost>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));

      if (state.image != null) {
        await PostAddServiece().addPostsToFirbase(
          state.text,
          state.image!,
        );
      }

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }
}
