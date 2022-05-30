// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:blood_book/editProfile.dart';
import 'package:blood_book/nav_bars.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/customButton.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  setDatatoTextField(data) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.h,
                ),
//                Center(
//                  child: Container(
//                    width: 200,
//                    child: Stack(overflow: Overflow.visible, children: [
//                      Center(
//                        child: Card(
//                          elevation: 5,
//                          shape: RoundedRectangleBorder(
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(100))),
//                          child: CircleAvatar(
//                            radius: 90,
//                            backgroundColor: Colors.white,
//                            child: Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: ClipRRect(
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(100)),
//                                  child:
//                                      Image.asset("images/blood-donation.jpg")),
//                            ),
//                          ),
//                        ),
//                      ),
//                      Positioned(
//                          bottom: -0,
//                          right: 13,
//                          child: Card(
//                              elevation: 5,
//                              color: Colors.blueAccent,
//                              shape: RoundedRectangleBorder(
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(100))),
//                              child: CircleAvatar(
//                                radius: 25,
//                                backgroundColor: Colors.transparent,
//                                child: IconButton(
//                                    onPressed: () {
//                                      Navigator.push(
//                                          context,
//                                          MaterialPageRoute(
//                                              builder: ((context) =>
//                                                  editProfile())));
//                                    },
//                                    icon: Icon(
//                                      Icons.edit,
//                                      color: Colors.white,
//                                    )),
//                              )))
//                    ]),
//                  ),
//                ),
                SizedBox(
                  height: 13.h,
                ),
                Center(
                    child: Text(
                  data['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                )),
                SizedBox(
                  height: 20.h,
                ),
                ListTile(
                  leading: Icon(
                    Icons.opacity,
                    color: Colors.red,
                    size: 35,
                  ),
                  title: Text(
                    'Blood Group: ' + data['blood-group'],
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.calendar_today,
                    color: Colors.indigo,
                    size: 35,
                  ),
                  title: Text(
                    "Last Donation: " + data['last-donation-date'],
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 35,
                  ),
                  title: Text(
                    data['city'],
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.call,
                    color: Colors.lightBlue,
                    size: 35,
                  ),
                  title: Text(
                    "Contact Number",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  subtitle: Text(data['phone'],
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                ),
                ListTile(
                  leading: Icon(
                    Icons.cake,
                    color: Colors.indigo,
                    size: 35,
                  ),
                  title: Text(
                    "Date of Birth",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  subtitle: Text(data['dob'],
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                ),
                ListTile(
                  leading: Container(
                      height: 35,
                      width: 40,
                      child: Image.asset(
                        "images/gender_icon.png",
                        fit: BoxFit.scaleDown,
                      )),
                  title: Text(
                    data['gender'],
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                ),




      ],
    ))),

        customButton("Edit Profile", () {
          Navigator.push(context,MaterialPageRoute(builder: ((context) =>editProfile())));
        }),
      ]);
  }

  Logout() {
    FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(msg: "Logged Out");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => HomeNavBar())));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Profile",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
                onPressed: () {
                  Logout();
                },
                icon: Icon(
                  Icons.power_settings_new,
                  size: 40,
                )),
          )
        ],
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap again to Exit.'),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("donar-information")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var data = snapshot.data;
              if (snapshot.data == null) {
                return Center(
                  child:
                      CircularProgressIndicator(), //CircularProgressIndicator(),
                );
              }

              return setDatatoTextField(data);
            },
          ),
        ),
      ),
    ));
  }
}
