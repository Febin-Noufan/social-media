import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String postId;
  final String username;
  final String userAvatarUrl;
  final String postContent;
  final String postImageUrl;
  final String timestamp;
  final int likesCount;
  final int commentsCount;

  const PostWidget({
    super.key,
    required this.postId,
    required this.username,
    required this.userAvatarUrl,
    required this.postContent,
    required this.postImageUrl,
    required this.timestamp,
    required this.likesCount,
    required this.commentsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(userAvatarUrl),
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/avargar.png',
                      image: userAvatarUrl,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      // Uncomment if you need to show the timestamp again
                      // Text(
                      //   timestamp,
                      //   style: TextStyle(
                      //     color: Colors.grey[500],
                      //     fontSize: 13,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Post Image with Placeholder
            if (postImageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.jpg',
                  image: postImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            const SizedBox(height: 10),
            // Post Content
            Text(
              postContent,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey[300]),
            // Interaction Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {},
                    ),
                    Text('$likesCount'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.comment_outlined,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {},
                    ),
                    Text('$commentsCount'),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.share_outlined,
                    color: Colors.greenAccent,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
