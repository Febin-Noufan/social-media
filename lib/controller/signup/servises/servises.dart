import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignUpController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
    final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print(e.message);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  adduser(String name,String username,String email,String password, profile,String bio) async{

    final uid=_auth.currentUser!.uid;

  TaskSnapshot uploadTask = await _storage.ref('profileImages/$uid').putFile(profile);
      String profileImageUrl = await uploadTask.ref.getDownloadURL();


    store.collection("users").doc(uid).set({
      'name':name,
      'username':username,
      'email':email,
      'password':password,
      'profile':profileImageUrl,
      'bio':bio,
    });
  }
}
