import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/graphPage.dart';
import '../pages/home.dart';
import '../pages/logout.dart';
import '../pages/triallog.dart';


class Menubar extends StatefulWidget {
  @override
  State<Menubar> createState() => _MenubarState();
}

class _MenubarState extends State<Menubar> {
  int currentIndex = 0;
  final pages = [
    HomePage(),
    SubmitPage(),
    GraphPage(),
    UserPage()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.cyan.shade400,
        type: BottomNavigationBarType.fixed, //no slide emotion


        elevation: 5,
        iconSize: 38,
        //
        selectedIconTheme: IconThemeData(color: Colors.white, size: 44),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.cyan.shade50,
        selectedLabelStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        unselectedFontSize: 16,
        showUnselectedLabels: true,
        //
        currentIndex: currentIndex,
        onTap: (value){
          currentIndex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',),
          BottomNavigationBarItem(
              icon: Icon(Icons.collections_outlined),
              label: 'Trial'),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              label: 'Graph'),
          BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              label: 'Sign Out'),
        ],
      ),

    );
  }
}
