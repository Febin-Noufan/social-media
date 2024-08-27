import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProfileFullScreen extends StatelessWidget {
  const ShimmerProfileFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                child: Container(
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Username
              Container(
                width: screenWidth * 0.6,
                height: 20.0,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 8.0),
              // Full Name
              Container(
                width: screenWidth * 0.4,
                height: 15.0,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16.0),
              // Bio
              Container(
                width: screenWidth * 0.8,
                height: 40.0,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 24.0),
              // Statistics Row
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatColumn(screenWidth),
                    const SizedBox(width: 20),
                    _buildStatColumn(screenWidth),
                    const SizedBox(width: 20),
                    _buildStatColumn(screenWidth),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(double screenWidth) {
    return Column(
      children: [
        Container(
          width: screenWidth * 0.1,
          height: screenWidth * 0.1,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 5),
        Container(
          width: screenWidth * 0.2,
          height: 15.0,
          color: Colors.grey[300],
        ),
      ],
    );
  }
}
