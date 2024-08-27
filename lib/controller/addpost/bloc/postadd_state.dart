import 'dart:io';
import 'package:equatable/equatable.dart';

class AddPostState extends Equatable {
  final String text;
  final File? image;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const AddPostState({
    required this.text,
    required this.image,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory AddPostState.initial() {
    return const AddPostState(
      text: '',
      image: null,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  AddPostState copyWith({
    String? text,
    File? image,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return AddPostState(
      text: text ?? this.text,
      image: image ?? this.image,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props => [text, image, isSubmitting, isSuccess, isFailure];
}
