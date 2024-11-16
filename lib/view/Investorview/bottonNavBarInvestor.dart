import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'AllPatentsScreen.dart';
import 'OrdersScreenInvestor.dart';
import 'chatScreen.dart';

class BottomNavBarInvestor extends StatefulWidget {
  const BottomNavBarInvestor({super.key});

  @override
  State<BottomNavBarInvestor> createState() => _BottomNavBarInvestorState();
}

class _BottomNavBarInvestorState extends State<BottomNavBarInvestor> {
  List<Widget> screens = [
    const AllPatentScreenInvestor(),
    const OrdersScreenInvestor(),
    const ChatScreenInvestor(),
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
