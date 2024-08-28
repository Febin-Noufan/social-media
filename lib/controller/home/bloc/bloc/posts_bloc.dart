import 'package:flutter_application_1/controller/home/bloc/bloc/posts_event.dart';
import 'package:flutter_application_1/controller/home/bloc/bloc/posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
  }

  Stream<List<Map<String, dynamic>>> get postsStream {
    return FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .asyncMap((snapshot) async {
          final posts = snapshot.docs.map((doc) => doc.data()).toList();

          for (var post in posts) {
            final userId = post['id'];
            final userDoc = await FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .get();
            final userData = userDoc.data();

            if (userData != null) {
              post['username'] = userData['username'] ?? 'Unknown user';
              post['userAvatarUrl'] = userData['profile'] ?? '';
            }
          }

          return posts;
        });
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    // No need to use this method anymore since we use StreamBuilder
  }
}
