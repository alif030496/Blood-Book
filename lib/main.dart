import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:blood_book/splashScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBhDz9tCdcDVpDfyOCKno4NItJuGTzivRY",
          appId: "1:131609830861:android:eafe845a9c95c9e2039084",
          messagingSenderId: "131609830861",
          projectId: "blood-book-56737"));
  runApp(MyApp());
}
final navigatorkey= GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375,812),
      builder:(){
      return MaterialApp(
        navigatorKey: navigatorkey,
        debugShowCheckedModeBanner: false,
        title: 'Blood Book',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: SplashScreen(),
      );
    });
  }
}

