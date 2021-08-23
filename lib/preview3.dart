import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Preview3 extends StatelessWidget {
  String title;
  String word;
  String imageName;

  Preview3({
    key,
    this.title,
    this.word,
    this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/sky.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.07,
                  right: MediaQuery.of(context).size.width * 0.07),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.grey[50],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title,
                          style: GoogleFonts.markaziText(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                      // RichText(
                      //   text: new TextSpan(
                      //     // Note: Styles for TextSpans must be explicitly defined.
                      //     // Child text spans will inherit styles from parent
                      //     style: new TextStyle(
                      //       fontSize: 14.0,
                      //       color: Colors.black,
                      //     ),
                      //     children: <TextSpan>[
                      //       new TextSpan(
                      //           text: answer,
                      //           style: GoogleFonts.markaziText(
                      //               color: Colors.grey,
                      //               fontSize: 23,
                      //               fontWeight: FontWeight.bold)),
                      //       new TextSpan(
                      //           text: word,
                      //           style: GoogleFonts.markaziText(
                      //               color: Colors.black,
                      //               fontSize: 23,
                      //               fontWeight: FontWeight.bold)),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Colors.orange,
                            ),
                            // Make rounded corners
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "http://10.0.2.2/flutter_test/uploads/${imageName}.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.3,
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Divider(
                    thickness: MediaQuery.of(context).size.height * 0.001,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/pen-2.png",
                        fit: BoxFit.scaleDown,
                        width: 50,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
