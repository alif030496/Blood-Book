import 'dart:async';
import 'package:blood_book/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blood_book/nav_bars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(milliseconds: 3200),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>HomeNavBar())));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset("images/blood-animated.gif",fit:BoxFit.cover,)),
    );
  }
}
