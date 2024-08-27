import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class AddPostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TextChanged extends AddPostEvent {
  final String text;

  TextChanged({required this.text});

  @override
  List<Object?> get props => [text];
}

class ImagePicked extends AddPostEvent {
  final File?  image;

  ImagePicked({required this.image});

  @override
  List<Object?> get props => [image];
}

class SubmitPost extends AddPostEvent {}
