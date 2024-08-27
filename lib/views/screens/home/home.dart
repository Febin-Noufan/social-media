import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets/home/home_app_bar.dart';
import 'package:flutter_application_1/views/widgets/home/post_builder.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              children: [
                HomeAppBar(),
                SizedBox(
                  height: 20,
                ),
                PostBuilderWidget()
              ],
            ),
          )),
    );
  }
}



 //  CustomScrollView(
        //   slivers: [
        //     SliverAppBar(
        //       expandedHeight: 120,
        //       pinned: true,
        //       backgroundColor: Colors.black,
        //       flexibleSpace: LayoutBuilder(
        //         builder: (context, constraints) {
        //           bool isPinned = constraints.biggest.height < 100;
        //           return Stack(
        //             children: [
        //               // Text when pinned
        //               Positioned(
        //                 left: 16,
        //                 top: 16,
        //                 child: isPinned
        //                     ? const Text(
        //                         'Have a nice day Febin',
        //                         style: TextStyle(
        //                           color: Colors.white,
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: 18,
        //                         ),
        //                       )
        //                     : const SizedBox.shrink(),
        //               ),
        //               // Icon button always positioned
        //               Positioned(
        //                 right: 12,
        //                 top: 10,
        //                 child: IconButton(
        //                   onPressed: () {},
        //                   icon: const Icon(
        //                     Icons.message_outlined,
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ),
        //               // Text when expanded
        //               if (!isPinned)
        //                 const Positioned(
        //                   top: 55,
        //                   left: 5,
        //                   right: 70,
        //                   child: Center(
        //                     child: Text(
        //                       'Have a nice day Febin',
        //                       style: TextStyle(
        //                         color: Colors.white,
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 24,
        //                         letterSpacing: 1.2,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //             ],
        //           );
        //         },
        //       ),
        //     ),
        //   Expanded(child: const  PostBuilderWidget()),
        //     // const SliverToBoxAdapter(
        //     //   child: SizedBox(
        //     //   //  height: 110,
        //     //     child:  
        //     //   ),
        //     // ),
          
        //   ],
        // ),