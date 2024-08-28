part of 'like_bloc.dart';

abstract class PostLikeEvent extends Equatable {
  const PostLikeEvent();
}

class CheckPostLikeStatus extends PostLikeEvent {
  final String postId;
  final String userId;

  const CheckPostLikeStatus(this.postId, this.userId);

  @override
  List<Object> get props => [postId, userId];
}

class LikePost extends PostLikeEvent {
  final String postId;
  final String userId;

  const LikePost(this.postId, this.userId);

  @override
  List<Object> get props => [postId, userId];
}
