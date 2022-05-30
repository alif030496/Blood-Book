// ignore_for_file: prefer_const_constructors

import 'package:blood_book/widgets/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DonarDetails extends StatefulWidget {
  var data;
  DonarDetails(this.data);


  @override
  _DonarDetailsState createState() => _DonarDetailsState();
}
const String url = 'https://www.facebook.com/groups/450418232489024/?ref=share';
class _DonarDetailsState extends State<DonarDetails> {
  setDatatoTextField(data) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0,bottom: 18.0,left: 12.0,right: 12.0),
            child: Card(
              borderOnForeground: true,
              elevation: 45,
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Center(
                          child: Container(
                              width: 200,
                              child: Center(
                                  child: Card(
                                      elevation: 15,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      child: CircleAvatar(
                                          radius: 70,
                                          backgroundColor: Colors.redAccent,
                                          child: Text(
                                            widget.data['blood-group'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 50,
                                                color: Colors.white),
                                          )))))),
                      SizedBox(
                        height: 35.h,
                      ),
                      ListTile(
                        leading: Container(
                            height: 35,
                            width: 40,
                            child: Icon(Icons.person,size: 40,color: Colors.indigo,),),
                        title: Text(
                          widget.data['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 22),
                        ),
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
                          widget.data['gender'],
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 22),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 35,
                        ),
                        title: Text(
                          widget.data['city'],
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 22),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.calendar_today,
                          color: Colors.indigo,
                          size: 35,
                        ),
                        title: Text("Last Donation: "+widget.data['last-donation-date'],
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20)),
//                        subtitle: Text(
//                          widget.data['last-donation-date'],
//                          style: TextStyle(
//                              fontWeight: FontWeight.w500, fontSize: 15),
//                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Container(
                          height: 50,
                          width: 0.35.sw,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                            BorderRadius.all(Radius.circular(100.0)),
                          ),

                          //width: 0.8.sw,
                          child: FlatButton(
                            onPressed: () {
                              UrlLauncher.launch('tel:${widget.data['phone']}');
                            },
                            child: Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                          Container(
                            height: 50,
                            width: 0.35.sw,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                            ),

                            //width: 0.8.sw,
                            child: FlatButton(
                              onPressed: () {
                                UrlLauncher.launch('sms:${widget.data['phone']}');
                              },
                              child: Icon(
                                Icons.message,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),

                        ],
                      ),
                    SizedBox(height: 25.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //Text("Powered By",style: TextStyle(fontSize: 30,color: Colors.black54),),
                              Container(
                                  height: 120,
                                  width: 120,                    child: Image.asset(
                                "images/logo.jpg",fit: BoxFit.scaleDown,
                              )),

                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  UrlLauncher.launch(url);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                    height: 100.h,
                                    width: 180.h,
                                    child: Image.asset("images/follow-us-on-facebook.webp",fit: BoxFit.cover,)),
                              ),
                            ],
                          ),
                        ],
                      )


                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text("Donar Details",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("donar-information")
            .doc()
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var data = snapshot.data;
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(), //CircularProgressIndicator(),
            );
          }
          return setDatatoTextField(data);
        },
      ),
    ));
  }
}
