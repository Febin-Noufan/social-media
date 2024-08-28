import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostAddServiece {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addPostsToFirbase(String description, File imageFile) async {
    try {
      final uid = auth.currentUser!.uid;

      TaskSnapshot uploadTask = await _storage
          .ref('postImages/$uid/${DateTime.now()}')
          .putFile(imageFile);

      String imageUrl = await uploadTask.ref.getDownloadURL();

      await db
          .collection("posts")
          .doc("${uid}_${DateTime.now().millisecondsSinceEpoch}")
          .set({
        "id": uid,
        "description": description,
        "image": imageUrl,
        "like": 0,
        "postId": "${uid}_${DateTime.now().millisecondsSinceEpoch}",
        "timestamp": "${DateTime.timestamp()}",
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> likePost(String postId, String userId) async {
    final postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
    final userLikeRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection("post_likes")
        .doc(userId);

    try {
      final userLikeSnapshot = await userLikeRef.get();
      if (userLikeSnapshot.exists) {
        // User has already liked the post, so unlike it
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          final postSnapshot = await transaction.get(postRef);
          final likesCount = postSnapshot.data()?['likesCount'] ?? 0;
          transaction.update(postRef, {'likesCount': likesCount - 1});
          transaction.delete(userLikeRef);
        });
      } else {
        // User has not liked the post, so like it
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          final postSnapshot = await transaction.get(postRef);
          final likesCount = postSnapshot.data()?['likesCount'] ?? 0;
          transaction.update(postRef, {'likesCount': likesCount + 1});
          transaction.set(userLikeRef, {'userId': userId});
        });
      }
    } catch (e) {
      print("Failed to toggle like: $e");
    }
  }

  Future<bool> hasCurrentUserLikedPost(
      String postId, String currentUserId) async {
    final postLikesRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('post_likes')
        .doc(currentUserId); // Check for the current user's document

    try {
      // Fetch the document for the current user
      final docSnapshot = await postLikesRef.get();

      // Return true if the document exists, indicating the user liked the post
      return docSnapshot.exists;
    } catch (e) {
      // Handle any errors, e.g., network issues
      print('Error fetching like status: $e');
      return false; // Assume the user has not liked the post in case of error
    }
  }
}
