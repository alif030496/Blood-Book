// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:blood_book/donarDetails.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DonarList extends StatefulWidget {
  var selectedgroup;
  DonarList(this.selectedgroup);
  @override
  _DonarListState createState() => _DonarListState();
}

class _DonarListState extends State<DonarList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedgroup + " Blood Donar List",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("donar-information")
              .where("blood-group", isEqualTo: widget.selectedgroup)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something Wrong!!"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading Search Results..."),
              );
            }
            if (snapshot.data!.docs.length == 0) {
              return Center(
                child: Text(
                  "No donar found!!",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => DonarDetails(data)))),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: ListTile(
                        title: Text(data['name'],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                        subtitle: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            SizedBox(height: 10.h,),
                            Text(data['city'],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                          ],
                        ),
                      isThreeLine: false,
                        trailing: Text(data['blood-group'],style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.red),),
                       leading: Icon(Icons.person,size: 40,color: Colors.indigo,),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    ));
  }
}
