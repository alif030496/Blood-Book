// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:blood_book/nav_bar_pages/signincheck.dart';
import 'package:blood_book/nav_bar_pages/welcomescreen.dart';
import 'package:blood_book/nav_bar_pages/profile.dart';

import 'package:flutter/material.dart';



class HomeNavBar extends StatefulWidget {
  @override
  _HomeNavBarState createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  final pages=[Home(),checksignin()];
  var _currentindex=0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(


      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: _currentindex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,

              ),
              label: "Home"),

          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,

              ),
              label: "Profile"),
        ],
        onTap: (index){
          setState(() {
            _currentindex=index;
          });

        },
      ),
      body: pages[_currentindex],
    ));
  }
}

