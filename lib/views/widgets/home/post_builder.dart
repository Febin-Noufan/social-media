import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application_1/controller/home/bloc/bloc/posts_bloc.dart';
import 'package:flutter_application_1/controller/home/bloc/bloc/posts_event.dart';
import 'package:flutter_application_1/controller/home/bloc/bloc/posts_state.dart';
import 'package:flutter_application_1/views/widgets/home/post_widget.dart';

class PostBuilderWidget extends StatelessWidget {
  const PostBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc()..add(FetchPosts()),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return _buildShimmerLoading();
          } else if (state is PostLoaded) {
            final posts = state.posts;

            if (posts.isEmpty) {
              return const Center(child: Text('No posts available'));
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final postContent = post['description'] ?? 'No content';
                final username = post['username'] ?? 'Unknown user';
                final postImageUrl = post['image'] ?? '';
                final timestamp = post['timestamp'] ?? 'Unknown time';
                final userAvatarUrl = post['userAvatarUrl'] ?? '';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: PostWidget(
                    postId: post["postId"],
                    commentsCount: post['commentsCount'] ?? 0,
                   likesCount : post['likesCount'] ?? 0,
                    postContent: postContent,
                    username: username,
                    postImageUrl: postImageUrl,
                    timestamp: timestamp.toString(),
                    userAvatarUrl: userAvatarUrl,
                  ),
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }



Widget _buildShimmerLoading() {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6, // Number of shimmer items to display
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with profile picture and username
                Row(
                  children: [
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Container(
                      width: 150.0,
                      height: 16.0,
                      color: Colors.grey[300],
                    ),
                    const Spacer(),
                    Container(
                      width: 30.0,
                      height: 16.0,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                // Placeholder for post image
                Container(
                  width: double.infinity,
                  height: 200.0,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 12.0),
                // Row for like, comment, and share buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 24.0,
                          height: 24.0,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(width: 16.0),
                        Container(
                          width: 24.0,
                          height: 24.0,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    Container(
                      width: 24.0,
                      height: 24.0,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                // Placeholder for post description
                Container(
                  width: double.infinity,
                  height: 16.0,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 4.0),
                Container(
                  width: 100.0,
                  height: 16.0,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

}
