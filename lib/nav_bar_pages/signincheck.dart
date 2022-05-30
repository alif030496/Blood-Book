import 'package:blood_book/loginscreen.dart';

import 'package:blood_book/nav_bar_pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class checksignin extends StatefulWidget {
  @override
  _checksigninState createState() => _checksigninState();
}


class _checksigninState extends State<checksignin> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: FirebaseAuth.instance.currentUser==null? LoginScreen():Profile()),
    );
  }
}
