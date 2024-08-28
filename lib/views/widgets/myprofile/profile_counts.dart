import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/profile/profile_screen.dart';

class ProfilePageFollowCount extends StatelessWidget {
  const ProfilePageFollowCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ProfileStat(number: '3', label: 'Posts'),
            ProfileStat(number: '0', label: 'Followers'),
            ProfileStat(number: '0', label: 'Following'),
          ],
        ),
        const SizedBox(height: 35),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     SizedBox(
        //       width: 150, // Set the desired width
        //       height: 30, // Set the desired height
        //       child: ElevatedButton(
        //         onPressed: () {
        //           // Add follow/unfollow action
        //         },
        //         style: ElevatedButton.styleFrom(
        //           foregroundColor: Colors.black, 
        //           backgroundColor: Colors.white, // Text color
        //         ),
        //         child: const Text('Edit Profile'),
        //       ),
        //     ),
        //     SizedBox(
        //       width: 150, // Set the desired width
        //       height: 30, // Set the desired height
        //       child: ElevatedButton(
        //         onPressed: () {
        //           // Add follow/unfollow action
        //         },
        //         style: ElevatedButton.styleFrom(
        //           foregroundColor: Colors.black, 
        //           backgroundColor: Colors.white, // Text color
        //         ),
        //         child: const Text('Edit Profile'),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
