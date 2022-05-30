// ignore_for_file: prefer_const_constructors

import 'package:blood_book/widgets/customButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
class addDonarinfo extends StatefulWidget {
  @override
  _addDonarinfoState createState() => _addDonarinfoState();
}

class _addDonarinfoState extends State<addDonarinfo> {

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
    showDialog(
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ));

    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("donar-information");
    return _collectionRef
        .doc(_phoneController.text)
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
  final _donarformkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
//      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Add Donar",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                "Fill this form to add Donar Information",
                style: TextStyle(
                    fontSize: 20.sp, color: Colors.red,fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 15,
            ),


            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: _donarformkey,
                  child: Column(
                    children: [
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
                          },
                          cursorHeight: 0,
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
                                dropdownColor: Colors.black54,borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                                dropdownColor: Colors.black54,borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                              hintText: "Last Blood Donation Date",
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

            customButton("Save", () {
              if (_donarformkey.currentState!.validate()) {
              sendUserDatatoFirestore();
              Navigator.pop(context);
              }
            })
          ],
        ),
      ),
    ));
  }
}
