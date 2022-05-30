// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:blood_book/nav_bar_pages/profile.dart';
import 'package:blood_book/nav_bar_pages/signincheck.dart';
import 'package:blood_book/nav_bars.dart';
import 'package:blood_book/signupscreen.dart';
import 'package:blood_book/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blood_book/main.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  LogIn() async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      var authCredential = userCredential.user;

      if (authCredential!.uid.isNotEmpty) {
        Fluttertoast.showToast(msg: "Login Successful");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'Incorrect email or password.');
        Navigator.pop(context);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Incorrect email or password.');
        Navigator.pop(context);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  'Welcome to Blood Book !',
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Expanded(
                  child: Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.r),
                      topLeft: Radius.circular(30.r)),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            Image.asset("images/blood-donation.jpg"),
//                            Text(
//                              'Log In',
//                              style: TextStyle(
//                                fontFamily: 'Product Sans',
//                                fontSize: 30.sp,
//                                fontWeight: FontWeight.bold,
//                                color: const Color(0xFFFF6B6B),
//                                letterSpacing: 0.88,
//                                height: 0.82,
//                              ),
//                            ),
//                            SizedBox(
//                              height: 5.h,
//                            ),
//                            Text(
//                              'Glad to see you back my sdfsdsbuddy.',
//                              style: TextStyle(
//                                fontFamily: 'Product Sans',
//                                fontSize: 14.0.sp,
//                                color: const Color(0xFFBBBBBB),
//                                letterSpacing: 0.56,
//                                height: 1.0,
//                              ),
//                            ),
                            SizedBox(
                              height: 70.h,
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 60.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.r))),
                                          child: Icon(
                                            Icons.email_outlined,
                                            size: 35.w,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            validator: (_emailController) {
                                              if (_emailController!.isEmpty) {
                                                return 'Please input your e-mail.';
                                              }
                                              return null;
                                            },
                                            controller: _emailController,
                                            decoration: InputDecoration(
                                                hintText: "example@mail.com",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black38),
                                                labelText: "Email",
                                                labelStyle: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15.sp)),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 60.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.r))),
                                          child: Icon(
                                            Icons.lock_outline,
                                            size: 35.w,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                              validator: (_passwordController) {
                                                if (_passwordController!
                                                    .isEmpty) {
                                                  return 'Please input your password.';
                                                }
                                                return null;
                                              },
                                              controller: _passwordController,
                                              obscureText: _obscureText,
                                              decoration: InputDecoration(
                                                hintText: "password",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black38),
                                                labelText: "Password",
                                                labelStyle: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15.sp),
                                                suffixIcon: _obscureText == true
                                                    ? IconButton(
                                                        icon: Icon(Icons
                                                            .visibility_off),
                                                        onPressed: () {
                                                          setState(() {
                                                            _obscureText =
                                                                !_obscureText;
                                                          });
                                                        },
                                                      )
                                                    : IconButton(
                                                        icon: Icon(
                                                            Icons.visibility),
                                                        onPressed: () {
                                                          setState(() {
                                                            _obscureText =
                                                                !_obscureText;
                                                          });
                                                        },
                                                      ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 60.h,
                            ),
                            customButton(
                              "Log In",
                              () {
                                if (_formKey.currentState!.validate()) {
                                  LogIn();

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              HomeNavBar())));
                                }
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Center(
                              child: Wrap(
                                children: [
                                  Text("Don't have an account?",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black38,
                                      )),
                                  GestureDetector(
                                    child: Text(" Sign Up",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red,
                                        )),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  SignUpScreen()));
//
//
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
//                            customButton("Skip Log In", () {
//                              Navigator.pushReplacement(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: ((context) => HomeNavBar())));
//                            }),
                          ])),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
