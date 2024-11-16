import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'AllPatentsScreen.dart';
import 'OrdersScreen.dart';
import 'chatScreen.dart';
import 'myPatentScreen.dart';

class BottomNavBarOwner extends StatefulWidget {
  const BottomNavBarOwner({super.key});

  @override
  State<BottomNavBarOwner> createState() => _BottomNavBarOwnerState();
}

class _BottomNavBarOwnerState extends State<BottomNavBarOwner> {
  List<Widget> screens = [
    const MyPatentsScreen(),
    const AllPatentScreenOwner(),
    const OrdersScreen(),
    const ChatScreenOwner(),
  ];
  int? _index = 0  ;

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
    backgroundColor: Colors.blueAccent,
    index: _index! ,
    height: 60,
  animationDuration: const Duration(milliseconds: 300),
  maxWidth:MediaQuery.of(context).size.width * 0.99,
  items:const [
     Padding(
      padding: EdgeInsets.all(3),
      child: const Icon(Icons.add, size: 25),
    ),
     Padding(
      padding: EdgeInsets.all(3),
      child: Icon(Icons.list, size: 25),
    ),
     Padding(
      padding: EdgeInsets.all(3),
      child: Icon(Icons.checklist, size: 25),
    ),
     Padding(
      padding: EdgeInsets.all(3),
      child: Icon(Icons.chat, size: 25),
    ),
  ],
    onTap: (index) {
      setState(() {
        _index = index ;
      });
    },
  ),
  body:screens[_index!],
      ),
    );
  }
}
