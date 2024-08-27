import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/auth/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageAppBar extends StatelessWidget {
  final String username;
  const ProfilePageAppBar({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title:  Text(username),
      actions: [
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Are Shure to logout"),
                    actions: [
                      TextButton(onPressed: () {}, child: const Text("Cancel")),
                      TextButton(
                          onPressed: () async {
                            FirebaseAuth.instance.signOut();
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            bool isLoggedIn =
                                prefs.getBool('isLoggedIn') ?? false;
                            isLoggedIn = false;
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SigninScreen(),
                                ));
                          },
                          child: const Text("Logout"))
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.more_horiz_outlined))
      ],
    );
  }
}
