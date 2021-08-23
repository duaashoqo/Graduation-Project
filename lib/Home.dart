import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LogInChild.dart';
import 'LogInParent.dart';
import 'LogInTeacher.dart';

class Home extends StatelessWidget {
  const Home({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(fit: StackFit.expand, children: <Widget>[
        // Image(
        //   image: new AssetImage("assets/images/cat.jpg"),
        // ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "اختر نوع حسابك",
              style: GoogleFonts.amiri(color: Colors.black, fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) => new LogInTeacher(),
                );
                Navigator.of(context).push(route);
              }, // Handle your callback.
              splashColor: Colors.red.withOpacity(0.5),

              child: Container(
                // color: Colors.green,
                height: 150,
                width: 230,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.red[700]),
                child: Image.asset(
                  "assets/images/teaccher2.png",
                  fit: BoxFit.contain,
                  width: 200,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) => new LoginChild(),
                );
                Navigator.of(context).push(route);
              }, // Handle your callback.
              splashColor: Colors.red.withOpacity(0.5),

              child: Container(
                // color: Colors.green,
                height: 150,
                width: 230,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.orange),
                child: Image.asset(
                  "assets/images/children1.png",
                  fit: BoxFit.contain,
                  width: 300,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) => new LogInParent(),
                );
                Navigator.of(context).push(route);
              }, // Handle your callback.
              splashColor: Colors.red.withOpacity(0.5),

              child: Container(
                height: 150,
                width: 230,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.green),
                child: Image.asset(
                  "assets/images/family.png",
                  fit: BoxFit.contain,
                  width: 300,
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
