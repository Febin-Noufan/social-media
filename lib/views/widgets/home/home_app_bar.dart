import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 25,top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          Text("Have a nice day ",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
          // IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.chat,
          //       color: Colors.white,
          //     ))
        ],
      ),
    );
  }
}
