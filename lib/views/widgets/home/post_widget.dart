import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/addpost/serviese/post_service.dart';

class PostWidget extends StatefulWidget {
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
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _checkIfLiked();
  }

  Future<void> _checkIfLiked() async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final isLiked = await hasCurrentUserLikedPost(widget.postId, currentUserId);
    setState(() {
      _isLiked = isLiked;
    });
  }

  Future<bool> hasCurrentUserLikedPost(String postId, String currentUserId) async {
    final postLikesRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('post_likes')
        .doc(currentUserId);

    try {
      final docSnapshot = await postLikesRef.get();
      return docSnapshot.exists;
    } catch (e) {
      print('Error fetching like status: $e');
      return false;
    }
  }

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
                  backgroundImage: NetworkImage(widget.userAvatarUrl),
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/avargar.png',
                      image: widget.userAvatarUrl,
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
                        widget.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Post Image with Placeholder
            if (widget.postImageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.jpg',
                  image: widget.postImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            const SizedBox(height: 10),
            // Post Content
            Text(
              widget.postContent,
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
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: Colors.redAccent,
                      ),
                      onPressed: () async {
                        final currentUserId = FirebaseAuth.instance.currentUser!.uid;
                        await PostAddServiece().likePost(widget.postId, currentUserId);
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                    ),
                    Text('${widget.likesCount}'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.comment_outlined,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {},
                    ),
                    Text('${widget.commentsCount}'),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: Colors.black,
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
