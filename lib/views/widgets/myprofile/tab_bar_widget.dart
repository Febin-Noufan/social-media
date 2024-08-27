import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets/myprofile/posts_grid.dart';

class TabBarWidgetProfile extends StatefulWidget {
  const TabBarWidgetProfile({super.key});

  @override
  _TabBarWidgetProfileState createState() => _TabBarWidgetProfileState();
}

class _TabBarWidgetProfileState extends State<TabBarWidgetProfile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black,
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(icon: Icon(Icons.grid_on), text: 'Grid'),
              Tab(icon: Icon(Icons.video_collection), text: 'Reels'),
            ],
          ),
        ),
        SizedBox(
          height: 300, // Define a fixed height or wrap this in a Flexible widget
          child: TabBarView(
            controller: _tabController,
            children: [
              const PostGridWidget(),
              _buildTabContent('Reels View Content'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent(String content) {
    return Center(
      child: Text(
        content,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
