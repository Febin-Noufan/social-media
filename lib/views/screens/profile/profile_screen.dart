import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/profile/bloc/bloc/profile_bloc.dart';
import 'package:flutter_application_1/views/widgets/myprofile/app_bar_profile.dart';
import 'package:flutter_application_1/views/widgets/myprofile/bio.dart';
import 'package:flutter_application_1/views/widgets/myprofile/profile_counts.dart';
import 'package:flutter_application_1/views/widgets/myprofile/profile_image.dart';
import 'package:flutter_application_1/views/widgets/myprofile/tab_bar_widget.dart';
import 'package:flutter_application_1/views/widgets/shimmer/profile.dart'; // Import your shimmer widgets
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(FetchUserData()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //_buildShimmerAppBar(),
                      //    const SizedBox(height: 40),
                      _buildShimmerProfileImage(),
                      const SizedBox(height: 40),
                      _buildShimmerBio(),
                      const SizedBox(height: 40),
                      _buildShimmerFollowCount(),
                      const SizedBox(height: 60),
                      _buildShimmerTabBar(),
                      const SizedBox(height: 60),
                      _buildShimmerPostGrid(),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileLoaded) {
              final data = state.userData.data() as Map<String, dynamic>;
              final profileImageUrl = data['profile'] ?? '';
              final name = data['name'] ?? '';
              final username = data['username'] ?? '';
              final bio = data['bio'] ?? '';

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ProfilePageAppBar(username: username),
                      ),
                      ProfileImage(imageUrl: profileImageUrl),
                      const SizedBox(height: 20),
                      ProfileBioWidget(
                          name: name, username: username, bio: bio),
                      const SizedBox(height: 20),
                      const ProfilePageFollowCount(),
                      const SizedBox(height: 20),
                      const TabBarWidgetProfile(),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              return Center(
                  child: Text(state.message,
                      style: const TextStyle(color: Colors.red)));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildShimmerAppBar() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[600]!,
      child: Container(
        height: 50,
        color: Colors.grey[800],
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
    );
  }

  Widget _buildShimmerProfileImage() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[600]!,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildShimmerBio() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[600]!,
      child: Column(
        children: [
          Container(
            width: 200,
            height: 20,
            color: Colors.grey[800],
          ),
          const SizedBox(height: 10),
          Container(
            width: 150,
            height: 20,
            color: Colors.grey[800],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerFollowCount() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[600]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildShimmerStat(),
          const SizedBox(width: 20),
          _buildShimmerStat(),
          const SizedBox(width: 20),
          _buildShimmerStat(),
        ],
      ),
    );
  }

  Widget _buildShimmerStat() {
    return Column(
      children: [
        Container(
          width: 50,
          height: 20,
          color: Colors.grey[800],
        ),
        const SizedBox(height: 5),
        Container(
          width: 40,
          height: 10,
          color: Colors.grey[800],
        ),
      ],
    );
  }

  Widget _buildShimmerTabBar() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[600]!,
      child: Container(
        height: 30,
        width: 400,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildShimmerPostGrid() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[600]!,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey[800],
          );
        },
      ),
    );
  }

  Widget _buildPostGrid() {
    // Replace this with your actual post grid widget
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 9, // Replace with actual post count
      itemBuilder: (context, index) {
        // Replace with actual post item widget
        return Container(
          color: Colors.blue, // Replace with post content
        );
      },
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String number;
  final String label;

  const ProfileStat({super.key, required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
