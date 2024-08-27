import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;
  //final VoidCallback onEdit;

  const ProfileImage({
    Key? key,
    required this.imageUrl,
   // required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // Profile Image with Placeholder
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            child: ClipOval(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: 120,
                height: 120,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.grey[700],
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: 120,
                    height: 120,
                    child: Center(
                      child: Image.asset("assets/avargar.png"),
                      // child: CircularProgressIndicator(
                      //   value: loadingProgress.expectedTotalBytes != null
                      //       ? loadingProgress.cumulativeBytesLoaded /
                      //           loadingProgress.expectedTotalBytes!
                      //       : null,
                      // ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Edit Button Overlay
          Positioned(
            bottom: 0,
            right: 4,
            child: GestureDetector(
              onTap: () {
                
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
