import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileBioWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final name;
  // ignore: prefer_typing_uninitialized_variables
  final username;
  // ignore: prefer_typing_uninitialized_variables
  final bio;
   const ProfileBioWidget({super.key, this.name, this.username, this.bio});
 // String nameUser = FirebaseAuth.instance.currentUser!.displayName.toString();

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
           name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, // Text color to white
            ),
          ),
          const SizedBox(height: 4),
           Text(
            bio,
            style: const TextStyle(color: Colors.white), // Text color to white
          ),
          const SizedBox(height: 4),
          // const Text(
          //   'www.johndoe.com',
          //   style: TextStyle(color: Colors.blue),
          // ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}