// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_final_fields

import 'package:blood_book/nav_bars.dart';
import 'package:blood_book/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _bloodgroupController = TextEditingController();
  TextEditingController _lastdonationdateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _donationareaController = TextEditingController();

  Future<void> _selectdobDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
  }
  Future<void> _selectdonationDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
    _lastdonationdateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
  }



  sendUserDatatoFirestore() async {

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("donar-information");
    return _collectionRef
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set({
          "name": _nameController.text,
          "city": _cityController.text,
          "phone": _phoneController.text,
          "dob": _dobController.text,
          "gender": _genderController.text,
          "blood-group": _bloodgroupController.text,
          "last-donation-date": _lastdonationdateController.text,
          "donation-area": _donationareaController.text,
        })
        .then((value) => Fluttertoast.showToast(msg:"User data successfully added."))
        .catchError((error) => Fluttertoast.showToast(msg:"Something went wrong"));

  }

  List<String> gender = ["Male", "Female", "Other"];
  List<String> bloodgroup = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Fill this form to complete Sign Up",
                style: TextStyle(
                    fontSize: 22.sp, color: Colors.red),
              ),
              SizedBox(
                height: 15,
              ),


              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
//                        Center(
//                          child: Container(
//                            width: 200,
//                            child: Stack(overflow: Overflow.visible, children: [
//                              Center(
//                                child: Card(
//                                  elevation: 5,
//                                  shape: RoundedRectangleBorder(
//                                      borderRadius:
//                                      BorderRadius.all(Radius.circular(100))),
//                                  child: CircleAvatar(
//                                    radius: 90,
//                                    backgroundColor: Colors.white,
//                                    child: Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: ClipRRect(
//                                          borderRadius:
//                                          BorderRadius.all(Radius.circular(100)),
//                                          child: Image.asset(
//                                              "images/blood-donation.jpg")),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                              Positioned(
//                                  bottom: -0,
//                                  right: 13,
//                                  child: Card(
//                                      elevation: 5,
//                                      color: Colors.blueAccent,
//                                      shape: RoundedRectangleBorder(
//                                          borderRadius:
//                                          BorderRadius.all(Radius.circular(100))),
//                                      child: CircleAvatar(
//                                        radius: 30,
//                                        backgroundColor: Colors.transparent,
//                                        child: IconButton(
//                                            onPressed: () {},
//                                            icon: Icon(
//                                              Icons.camera_alt,
//                                              color: Colors.white,
//                                            )),
//                                      )))
//                            ]),
//                          ),
//                        ),
                        SizedBox(height: 10.h,),
                        TextFormField(
                            controller: _nameController,
                            validator: (_nameController) {
                              if (_nameController!.isEmpty) {
                                return 'Please input your Full Name.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Full Name",
                            )
                            ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            validator: (_phoneController) {
                              if (_phoneController!.isEmpty) {
                                return 'Please input your phone number.';
                              }
                              return null;
                            },
                            maxLength: 11,
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            inputFormatters:[FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),],
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                            controller: _cityController,
                            validator: (_cityController) {
                              if (_cityController!.isEmpty) {
                                return 'Please input your current city.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Current City",
                            )
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        TextFormField(
                            validator: (_dobController) {
                              if (_dobController!.isEmpty) {
                                return 'Please select your date of birth.';
                              }
                              return null;
                            }, cursorHeight: 0,
                            cursorWidth: 0,
                            showCursor: false,
                            keyboardType: TextInputType.none,
                            controller: _dobController,
                            decoration: InputDecoration(
                                hintText: "Date of Birth",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _selectdobDateFromPicker(context);
                                  },
                                ))),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            validator: (_genderController) {
                              if (_genderController!.isEmpty) {
                                return 'Please select your gender.';
                              }
                              return null;
                            }, cursorHeight: 0,
                            cursorWidth: 0,
                            showCursor: false,
                            keyboardType: TextInputType.none,
                            controller: _genderController,
                            decoration: InputDecoration(
                                hintText: "Gender",
                                suffixIcon: DropdownButton(
                                  dropdownColor: Colors.black26,borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                                    child: Text(e),
                                    onTap: () {
                                      setState(() {
                                        _genderController.text = e;
                                      });
                                    },
                                  ))
                                      .toList(),
                                  onChanged: (context) {},
                                ))),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            validator: (_bloodgroupController) {
                              if (_bloodgroupController!.isEmpty) {
                                return 'Select your blood group.';
                              }
                              return null;
                            },
                            cursorHeight: 0,
                            cursorWidth: 0,
                            showCursor: false,
                            keyboardType: TextInputType.none,
                            controller: _bloodgroupController,
                            decoration: InputDecoration(
                                hintText: "Blood Group",
                                suffixIcon: DropdownButton(
                                  dropdownColor: Colors.black26,borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                                    child: Text(e),
                                    onTap: () {
                                      setState(() {
                                        _bloodgroupController.text = e;
                                      });
                                    },
                                  ))
                                      .toList(),
                                  onChanged: (context) {},
                                ))),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            validator: (_lastdonationdateController) {
                              if (_lastdonationdateController!.isEmpty) {
                                return 'Please select your last blood donation date.';
                              }
                              return null;
                            }, cursorHeight: 0,
                            cursorWidth: 0,
                            showCursor: false,
                            keyboardType: TextInputType.none,
                            controller: _lastdonationdateController,
                            decoration: InputDecoration(
                                hintText: "Last Donation Date",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _selectdonationDateFromPicker(context);
                                  },
                                ))),
                        SizedBox(height: 20.h,)
                      ],
                    ),
                  ),
                ),
              ),

              customButton("Submit", () {
                if (_formkey.currentState!.validate()) {
                  sendUserDatatoFirestore();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeNavBar()));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
