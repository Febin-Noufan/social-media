import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/addpost/pos_add.dart';
import 'package:flutter_application_1/views/screens/gemini/gemini.dart';
import 'package:flutter_application_1/views/screens/home/home.dart';
import 'package:flutter_application_1/views/screens/profile/profile_screen.dart';

// A StatefulWidget that demonstrates the use of Floating Bottom Bar with navigation
class BottomNavigatorExample extends StatefulWidget {
  const BottomNavigatorExample({super.key, required this.title});

  final String title;

  @override
  State<BottomNavigatorExample> createState() => _BottomNavigatorExampleState();
}

class _BottomNavigatorExampleState extends State<BottomNavigatorExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const GeminiPage(),
   // const Center(child: Text('Search')),
     const AddPostPage(),
    //const Center(child: Text('Post')),
    //const Center(child: Text('Reels')),
   const MyProfileScreen()
    //const Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: FlashyTabBar(
          animationCurve: Curves.linear,
          backgroundColor: Colors.black,
          selectedIndex: _selectedIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: Icon(Icons.home,
                  color: _selectedIndex == 0 ? Colors.blue : Colors.white),
              title: Text('Home',
                  style: TextStyle(
                      color: _selectedIndex == 0 ? Colors.blue : Colors.white)),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.chat_bubble_outline,
                  color: _selectedIndex == 1 ? Colors.blue : Colors.white),
              title: Text('ChatBot',
                  style: TextStyle(
                      color: _selectedIndex == 1 ? Colors.blue : Colors.white)),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.add_box_rounded,
                  color: _selectedIndex == 2 ? Colors.blue : Colors.white),
              title: Text('post',
                  style: TextStyle(
                      color: _selectedIndex == 2 ? Colors.blue : Colors.white)),
            ),
            // FlashyTabBarItem(
            //   icon: Icon(Icons.slow_motion_video_outlined,
            //       color: _selectedIndex == 2 ? Colors.blue : Colors.white),
            //   title: Text('Reels',
            //       style: TextStyle(
            //           color: _selectedIndex == 2 ? Colors.blue : Colors.white)),
            // ),
            FlashyTabBarItem(
              icon: Icon(Icons.person,
                  color: _selectedIndex == 3 ? Colors.blue : Colors.white),
              title: Text('Profile',
                  style: TextStyle(
                      color: _selectedIndex == 3 ? Colors.blue : Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
