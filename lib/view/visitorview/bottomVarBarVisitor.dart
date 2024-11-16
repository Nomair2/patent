import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'AllPatentsScreenVisitor.dart';

class BottomNavBarVisitor extends StatefulWidget {
  const BottomNavBarVisitor({super.key});

  @override
  State<BottomNavBarVisitor> createState() => _BottomNavBarVisitorState();
}

class _BottomNavBarVisitorState extends State<BottomNavBarVisitor> {
  List<Widget> screens = [
    const AllPatentScreenVisitor(),
  ];
  int? _index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.blueAccent,
          index: _index!,
          height: 60,
          animationDuration: const Duration(milliseconds: 300),
          maxWidth: MediaQuery.of(context).size.width * 0.99,
          items: const [
            Padding(
              padding: EdgeInsets.all(3),
              child: Icon(Icons.list, size: 25),
            ),
          ],
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
        ),
        body: screens[_index!],
      ),
    );
  }
}
