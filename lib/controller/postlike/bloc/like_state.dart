part of 'like_bloc.dart';

abstract class PostLikeState extends Equatable {
  const PostLikeState();
}

class PostLikeInitial extends PostLikeState {
  @override
  List<Object> get props => [];
}

class PostLikeStatus extends PostLikeState {
  final bool isLiked;

  const PostLikeStatus(this.isLiked);

  @override
  List<Object> get props => [isLiked];
}

class PostLikeError extends PostLikeState {
  @override
  List<Object> get props => [];
}
