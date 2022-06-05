// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_final_fields, non_constant_identifier_names, prefer_is_empty, prefer_const_literals_to_create_immutables

import 'package:blood_book/addDonarinfo.dart';
import 'package:blood_book/donarList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

List<String> bloodgroup = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
TextEditingController _bloodgroupController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Blood Book",
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap again to Exit.'),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 0.8.sw,
                      child: TextFormField(
                        validator: (_bloodgroupController) {
                          if (_bloodgroupController!.isEmpty) {
                            return 'Select blood group to find donar.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.none,
                        cursorHeight: 0,
                        cursorWidth: 0,
                        showCursor: false,
                        style: TextStyle(fontSize: 22),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0))),
                            suffixIcon: DropdownButton(
                              alignment: AlignmentDirectional.bottomEnd,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              dropdownColor: Colors.black54,
                              elevation: 5,
                              underline: Container(
                                color: Colors.black,
                              ),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.red,
                                size: 50,
                              ),
                              items: bloodgroup
                                  .map((e) => DropdownMenuItem(

                                        value: e,
                                        child: Text(e,style: TextStyle( color: Colors.white),),
                                        onTap: () {
                                          setState(() {
                                            _bloodgroupController.text = e;
                                          });
                                        },
                                      ))
                                  .toList(),
                              onChanged: (context) {},
                            ),
                            labelText: "Search Blood Donars",
                            labelStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400)),
                        controller: _bloodgroupController,
                      ),
                    ),
                    Container(
                      width: 0.12.sw,
                      //color: Colors.red,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Colors.red),
                      child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(_bloodgroupController);
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: ((context) => DonarList(
                                          _bloodgroupController.text))));
                            }
                          }),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                child: Container(
                  width: ScreenUtil().screenWidth,
                 // color: Colors.grey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: ((context) => addDonarinfo())));
                              },
                              child: Container(
                                height: 200.h,
                                width: 0.4.sw,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22.0.r)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Container(
                                      height: 145.h,
                                      //width: 0.3.sw,
                                      child: Image.asset(
                                        "images/add_donar.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Center(
                                        child: Text(
                                      "Add Donar",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    )),
                                  ],
                                ),
                              ),
                            ),

//                            GestureDetector(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    CupertinoPageRoute(
//                                        builder: ((context) => addDonarinfo())));
//                              },
//                              child: Container(
//                                height: 200.h,
//                                width: 0.4.sw,
//                                decoration: BoxDecoration(
//                                  color: Colors.blueGrey,
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(22.0.r)),
//                                ),
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  children: [
//
//                                    Container(
//                                      height: 145.h,
//                                      //width: 0.3.sw,
//                                      child: Image.asset(
//                                        "images/add_donar.png",
//                                        fit: BoxFit.cover,
//                                      ),
//                                    ),
//                                    SizedBox(height: 10.h),
//                                    Center(
//                                        child: Text(
//                                      "Add Donar",
//                                      style: TextStyle(
//                                          fontWeight: FontWeight.w500,
//                                          color: Colors.white),
//                                    )),
//                                  ],
//                                ),
//                              ),
//                            ),


                          ],
                        ),
                SizedBox(height: 20.h,),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//
//                            GestureDetector(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    CupertinoPageRoute(
//                                        builder: ((context) => addDonarinfo())));
//                              },
//                              child: Container(
//                                height: 200.h,
//                                width: 0.4.sw,
//                                decoration: BoxDecoration(
//                                  color: Colors.blueGrey,
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(22.0.r)),
//                                ),
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  children: [
//
//                                    Container(
//                                      height: 145.h,
//                                      //width: 0.3.sw,
//                                      child: Image.asset(
//                                        "images/add_donar.png",
//                                        fit: BoxFit.cover,
//                                      ),
//                                    ),
//                                    SizedBox(height: 10.h),
//                                    Center(
//                                        child: Text(
//                                      "Add Donar",
//                                      style: TextStyle(
//                                          fontWeight: FontWeight.w500,
//                                          color: Colors.white),
//                                    )),
//                                  ],
//                                ),
//                              ),
//                            ),
//
//                            GestureDetector(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    CupertinoPageRoute(
//                                        builder: ((context) => addDonarinfo())));
//                              },
//                              child: Container(
//                                height: 200.h,
//                                width: 0.4.sw,
//                                decoration: BoxDecoration(
//                                  color: Colors.blueGrey,
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(22.0.r)),
//                                ),
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  children: [
//
//                                    Container(
//                                      height: 145.h,
//                                      //width: 0.3.sw,
//                                      child: Image.asset(
//                                        "images/add_donar.png",
//                                        fit: BoxFit.cover,
//                                      ),
//                                    ),
//                                    SizedBox(height: 10.h),
//                                    Center(
//                                        child: Text(
//                                      "Add Donar",
//                                      style: TextStyle(
//                                          fontWeight: FontWeight.w500,
//                                          color: Colors.white),
//                                    )),
//                                  ],
//                                ),
//                              ),
//                            ),
//
//
//                          ],
//                        ),
//                        SizedBox(height: 20.h,),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//
//                            GestureDetector(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    CupertinoPageRoute(
//                                        builder: ((context) => addDonarinfo())));
//                              },
//                              child: Container(
//                                height: 200.h,
//                                width: 0.4.sw,
//                                decoration: BoxDecoration(
//                                  color: Colors.blueGrey,
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(22.0.r)),
//                                ),
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  children: [
//
//                                    Container(
//                                      height: 145.h,
//                                      //width: 0.3.sw,
//                                      child: Image.asset(
//                                        "images/add_donar.png",
//                                        fit: BoxFit.cover,
//                                      ),
//                                    ),
//                                    SizedBox(height: 10.h),
//                                    Center(
//                                        child: Text(
//                                      "Add Donar",
//                                      style: TextStyle(
//                                          fontWeight: FontWeight.w500,
//                                          color: Colors.white),
//                                    )),
//                                  ],
//                                ),
//                              ),
//                            ),
//
//                            GestureDetector(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    CupertinoPageRoute(
//                                        builder: ((context) => addDonarinfo())));
//                              },
//                              child: Container(
//                                height: 200.h,
//                                width: 0.4.sw,
//                                decoration: BoxDecoration(
//                                  color: Colors.blueGrey,
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(22.0.r)),
//                                ),
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  children: [
//
//                                    Container(
//                                      height: 145.h,
//                                      //width: 0.3.sw,
//                                      child: Image.asset(
//                                        "images/add_donar.png",
//                                        fit: BoxFit.cover,
//                                      ),
//                                    ),
//                                    SizedBox(height: 10.h),
//                                    Center(
//                                        child: Text(
//                                      "Add Donar",
//                                      style: TextStyle(
//                                          fontWeight: FontWeight.w500,
//                                          color: Colors.white),
//                                    )),
//                                  ],
//                                ),
//                              ),
//                            ),
//
//
//                          ],
//                        ),
                       // SizedBox(height: 10.h,),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
