// ignore_for_file: prefer_const_constructors

import 'package:blood_book/widgets/customButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'nav_bar_pages/profile.dart';

class editProfile extends StatefulWidget {
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  bool updatedob = false;
  bool updategender = false;
  bool updatebloodgroup = false;
  bool updatedonationdate = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _updatedobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _updategenderController = TextEditingController();
  TextEditingController _bloodgroupController = TextEditingController();
  TextEditingController _updatebloodgroupController = TextEditingController();
  TextEditingController _lastdonationdateController = TextEditingController();
  TextEditingController _updatelastdonationdateController = TextEditingController();

  Future<void> _selectdobDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _updatedobController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectdonationDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _updatelastdonationdateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  setDatatoTextField(data) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _editformkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
//                  Center(
//                    child: Container(
//                      width: 200,
//                      child: Stack(overflow: Overflow.visible, children: [
//                        Center(
//                          child: Card(
//                            elevation: 5,
//                            shape: RoundedRectangleBorder(
//                                borderRadius:
//                                    BorderRadius.all(Radius.circular(100))),
//                            child: CircleAvatar(
//                              radius: 90,
//                              backgroundColor: Colors.white,
//                              child: Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: ClipRRect(
//                                    borderRadius:
//                                        BorderRadius.all(Radius.circular(100)),
//                                    child: Image.asset(
//                                        "images/blood-donation.jpg")),
//                              ),
//                            ),
//                          ),
//                        ),
//                        Positioned(
//                            bottom: -0,
//                            right: 13,
//                            child: Card(
//                                elevation: 5,
//                                color: Colors.blueAccent,
//                                shape: RoundedRectangleBorder(
//                                    borderRadius:
//                                        BorderRadius.all(Radius.circular(100))),
//                                child: CircleAvatar(
//                                  radius: 30,
//                                  backgroundColor: Colors.transparent,
//                                  child: IconButton(
//                                      onPressed: () {},
//                                      icon: Icon(
//                                        Icons.camera_alt,
//                                        color: Colors.white,
//                                      )),
//                                )))
//                      ]),
//                    ),
//                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  TextFormField(
                    validator: (_nameController) {
                      if (_nameController!.isEmpty) {
                        return 'Please input your Full Name.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Full Name",
                        hintStyle:
                            TextStyle(fontSize: 14, color: Colors.black38),
                        labelText: "Full Name",
                        labelStyle: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp)),
                    controller: _nameController =TextEditingController(text: data["name"]),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  TextFormField(
                    maxLength: 11,
                    validator: (_phoneController) {
                      if (_phoneController!.isEmpty) {
                        return 'Please input your contact number.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                    ],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Contact Number",
                        hintStyle:
                            TextStyle(fontSize: 14, color: Colors.black38),
                        labelText: "Contact Number",
                        labelStyle: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp)),
                    controller: _phoneController =TextEditingController(text: data["phone"]),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    validator: (_cityController) {
                      if (_cityController!.isEmpty) {
                        return 'Please input your current city.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Current City",
                        hintStyle:
                            TextStyle(fontSize: 14, color: Colors.black38),
                        labelText: "Current City",
                        labelStyle: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp)),
                    controller: _cityController =TextEditingController(text: data["city"]),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  TextFormField(
                    validator: (_updatelastdonationdateController) {
                      if (_updatelastdonationdateController!.isEmpty) {
                        return 'Select your last blood donation date.';
                      }
                      return null;
                    },
                    cursorHeight: 0,
                    cursorWidth: 0,
                    showCursor: false,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            updatedonationdate = !updatedonationdate;
                            _selectdonationDateFromPicker(context);
                          },
                        ),
                        hintText: "Select date from calendar",
                        hintStyle:
                            TextStyle(fontSize: 14, color: Colors.black38),
                        labelText: "Last Blood Donation Date",
                        labelStyle: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp)),
                    controller: updatedonationdate == false
                        ? _lastdonationdateController = TextEditingController(
                            text: data['last-donation-date'])
                        : _updatelastdonationdateController,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  TextFormField(
                    validator: (_updatebloodgroupController) {
                      if (_updatebloodgroupController!.isEmpty) {
                        return 'Please select your blood group.';
                      }
                      return null;
                    },
                    cursorHeight: 0,
                    cursorWidth: 0,
                    showCursor: false,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: DropdownButton(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          dropdownColor: Colors.black54,
                          elevation: 0,
                          underline: Container(
                            color: Colors.white,
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.red,
                            size: 40,
                          ),
                          items: bloodgroup
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e,style: TextStyle( color: Colors.white),),
                                    onTap: () {
                                      setState(() {
                                        updatebloodgroup = !updatebloodgroup;
                                        _updatebloodgroupController.text = e;
                                      });
                                    },
                                  ))
                              .toList(),
                          onChanged: (context) {},
                        ),
                        hintText: "Select blood Group",
                        hintStyle:
                            TextStyle(fontSize: 14, color: Colors.black38),
                        labelText: "Blood Group",
                        labelStyle: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp)),
                    controller: updatebloodgroup == false
                        ? _bloodgroupController =
                            TextEditingController(text: data["blood-group"])
                        : _updatebloodgroupController,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  TextFormField(
                    validator: (_updatedobController) {
                      if (_updatedobController!.isEmpty) {
                        return 'Please select your date of birth.';
                      }
                      return null;
                    },
                    cursorHeight: 0,
                    cursorWidth: 0,
                    showCursor: false,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            updatedob = !updatedob;
                            _selectdobDateFromPicker(context);
                          },
                        ),
                        hintText: "Select date from calendar",
                        hintStyle:
                            TextStyle(fontSize: 14, color: Colors.black38),
                        labelText: "Date of Birth",
                        labelStyle: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp)),
                    controller: updatedob == false
                        ? _dobController =
                            TextEditingController(text: data['dob'])
                        : _updatedobController,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  TextFormField(
                    validator: (_updategenderController) {
                      if (_updategenderController!.isEmpty) {
                        return 'Please select your gender.';
                      }
                      return null;
                    },
                    cursorHeight: 0,
                    cursorWidth: 0,
                    showCursor: false,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: DropdownButton(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          dropdownColor: Colors.black54,
                          elevation: 0,
                          underline: Container(
                            color: Colors.white,
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.red,
                            size: 40,
                          ),
                          items: gender
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e,style: TextStyle( color: Colors.white),),
                                    onTap: () {
                                      setState(() {
                                        updategender = !updategender;
                                        _updategenderController.text = e;
                                      });
                                    },
                                  ))
                              .toList(),
                          onChanged: (context) {},
                        ),
                        hintText: "Select Gender",
                        hintStyle:
                            TextStyle(fontSize: 14, color: Colors.black38),
                        labelText: "Gender",
                        labelStyle: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp)),
                    controller: updategender == false
                        ? _genderController =
                            TextEditingController(text: data["gender"])
                        : _updategenderController,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ),
        ),
        customButton("Save", () {
          if (_editformkey.currentState!.validate()) {
            updateData();
          }
          Navigator.pop(context);
        }),
      ],
    );
  }

  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("donar-information");
    return _collectionRef
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
          "name": _nameController.text,
          "city": _cityController.text,
          "phone": _phoneController.text,
          "dob": updatedob == false
              ? _dobController.text
              : _updatedobController.text,
          "gender": updategender == false
              ? _genderController.text
              : _updategenderController.text,
          "blood-group": updatebloodgroup == false
              ? _bloodgroupController.text
              : _updatebloodgroupController.text,
          "last-donation-date": updatedonationdate == false
              ? _lastdonationdateController.text
              : _updatelastdonationdateController.text,
        })
        .then((value) => Fluttertoast.showToast(msg: "Update Successfull."))
        .catchError((error) => Fluttertoast.showToast(msg: "Something wrong"));
  }

  List<String> gender = ["Male", "Female", "Other"];
  List<String> bloodgroup = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
  final _editformkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("donar-information")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return setDatatoTextField(data);
          },
        ),
      ),
    ));
  }
}
