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
      print("Error adding post: $e");
      throw e;
    }
  }
}
