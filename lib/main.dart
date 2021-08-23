// import 'package:admin_kg1/second.dart';
// import 'package:admin_kg1/second_exc.dart';
// import 'package:admin_kg1/newLissonOrExc.dart';
// import 'package:admin_kg1/videos.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
// import 'ChangePassword.dart';
// import 'E_type1.dart';
import 'Home.dart';
//import 'ParentHome.dart';

import 'package:firebase_core/firebase_core.dart';

//import 'child_home.dart';

// import 'Screens/Welcome/welcome_screen.dart';

// void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Auth',
        // theme: ThemeData(
        //   primaryColor: kPrimaryColor,
        //   scaffoldBackgroundColor: Colors.white,
        // ),
        home: Home()
        //     second(
        //   title: "hhhhh",
        //   imageName: "uType2",
        //   word: "kk",
        //   answer: "ppp",
        // ),

        // initialRoute: '/',
        // routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // '/': (context) => Home(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        // '/Teacher': (context) => teacher(),
        //   '/Parent': (context) => parent(),
        //   '/Child': (context) => child(),
        //   '/LogIn': (context) => Login(),
        //   '/LogInChild': (context) => LoginChild(),
        //   '/EmailVerify': (context) => EmailVerify(),
        //   '/ChangePassword': (context) => ChangePassword(),
        // },
        );
  }
}
