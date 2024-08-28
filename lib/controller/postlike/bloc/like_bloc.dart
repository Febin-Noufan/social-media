import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'like_event.dart';
part 'like_state.dart';

class PostLikeBloc extends Bloc<PostLikeEvent, PostLikeState> {
  PostLikeBloc() : super(PostLikeInitial());

  Stream<PostLikeState> mapEventToState(PostLikeEvent event) async* {
    if (event is CheckPostLikeStatus) {
      yield* _mapCheckPostLikeStatusToState(event);
    } else if (event is LikePost) {
      yield* _mapLikePostToState(event);
    }
  }

  Stream<PostLikeState> _mapCheckPostLikeStatusToState(CheckPostLikeStatus event) async* {
    try {
      final postLikesRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(event.postId)
          .collection('post_likes')
          .doc(event.userId);

      final docSnapshot = await postLikesRef.get();
      yield PostLikeStatus(docSnapshot.exists);
    } catch (_) {
      yield PostLikeError();
    }
  }

  Stream<PostLikeState> _mapLikePostToState(LikePost event) async* {
    try {
      final postLikesRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(event.postId)
          .collection('post_likes')
          .doc(event.userId);

      final docSnapshot = await postLikesRef.get();
      if (docSnapshot.exists) {
        await postLikesRef.delete();
        yield PostLikeStatus(false);
      } else {
        await postLikesRef.set({});
        yield PostLikeStatus(true);
      }
    } catch (_) {
      yield PostLikeError();
    }
  }
}