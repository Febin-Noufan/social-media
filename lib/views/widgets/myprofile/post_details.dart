import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostDetailsPage extends StatelessWidget {
  final Map<String, dynamic> post;

  const PostDetailsPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = post['image'] ?? '';
    final description = post['description'] ?? '';
    final likes = post['likesCount'] ?? 0;
  //  final username = post['username'] ?? 'Username';
    final profileImageUrl = post['profileImageUrl'] ?? '';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Header with user information
       
          // Post image
          Container(
            height: 400,
            width: double.infinity,
            color: Colors.grey[850],
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  )
                : const Center(
                    child: Icon(
                      Icons.image,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              
              child: Text(description,style: TextStyle(color: Colors.white),)),
          ),
          //    Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          //   child: RichText(
          //     text: TextSpan(
          //       style: const TextStyle(color: Colors.white),
          //       children: [
                  
          //         TextSpan( 
          //           text: description,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Action buttons and likes count
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.white),
                  onPressed: () {
                    // Like button
                  },
                ),
               // const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.comment_outlined, color: Colors.white),
                  onPressed: () {
                    // Comment button
                  },
                ),
               // const SizedBox(width: 16),
                // IconButton(
                //   icon: const Icon(Icons.share_outlined, color: Colors.white),
                //   onPressed: () {
                //     // Share button
                //   },
                // ),
                //const Spacer(),
                IconButton(
                  icon: const Icon(Icons.bookmark_border, color: Colors.white),
                  onPressed: () {
                    // Save button
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  '$likes likes',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Description
       
          // // Comment Section Placeholder
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: ListView.builder(
          //       itemCount: 5, // Example comment count
          //       itemBuilder: (context, index) {
          //         return Padding(
          //           padding: const EdgeInsets.symmetric(vertical: 4.0),
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               CircleAvatar(
          //                 radius: 15,
          //                 backgroundImage: const AssetImage('assets/default_profile.png'),
          //               ),
          //               const SizedBox(width: 10),
          //               Expanded(
          //                 child: RichText(
          //                   text: const TextSpan(
          //                     style: TextStyle(color: Colors.white),
          //                     children: [
          //                       TextSpan(
          //                         text: 'CommentUser ',
          //                         style: TextStyle(fontWeight: FontWeight.bold),
          //                       ),
          //                       TextSpan(
          //                         text: 'Great photo!',
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //               const Icon(Icons.favorite, color: Colors.white, size: 14),
          //             ],
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
