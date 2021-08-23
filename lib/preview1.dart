import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Preview1 extends StatelessWidget {
  String title;
  String word;
  String imageName;
  String choice1;
  String choice2;
  String choice3;
  String answer;

  Preview1(
      {key,
      this.title,
      this.word,
      this.imageName,
      this.choice1,
      this.choice2,
      this.choice3,
      this.answer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: new Stack(children: <Widget>[
          new Container(
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.07,
                    right: MediaQuery.of(context).size.width * 0.07),
                color: Colors.white,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      //  "http://10.0.2.2/flutter_test/uploads/'${imageName}'"

                                      "http://10.0.2.2/flutter_test/uploads/${imageName}.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Text(word,
                            style: GoogleFonts.markaziText(
                              color: Colors.black,
                              fontSize: 23,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        child: Center(
                            child: Text(answer,
                                style: GoogleFonts.markaziText(
                                    color: Colors.grey,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold))),
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                            // Make rounded corners
                            borderRadius: BorderRadius.circular(15)),
                      )
                    ]),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Center(
                              child: Text(choice3,
                                  style: GoogleFonts.markaziText(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold))),
                          width: MediaQuery.of(context).size.width * 0.18,
                          height: MediaQuery.of(context).size.height * 0.12,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: Colors.orange,
                              ),
                              // Make rounded corners
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Container(
                          child: Center(
                              child: Text(choice2,
                                  style: GoogleFonts.markaziText(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold))),
                          width: MediaQuery.of(context).size.width * 0.18,
                          height: MediaQuery.of(context).size.height * 0.12,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: Colors.orange,
                              ),
                              // Make rounded corners
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Container(
                          child: Center(
                              child: Text(choice1,
                                  style: GoogleFonts.markaziText(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold))),
                          width: MediaQuery.of(context).size.width * 0.18,
                          height: MediaQuery.of(context).size.height * 0.12,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: Colors.orange,
                              ),
                              // Make rounded corners
                              borderRadius: BorderRadius.circular(15)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}
