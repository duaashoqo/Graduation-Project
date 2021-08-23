import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'E_type1.dart';
import 'NewLesson.dart';
import 'E_type2.dart';
import 'E_type3.dart';

class NewLessonOrExersize extends StatefulWidget {
  String title;
  String class_name;
  String calssName;
  bool flag;

  NewLessonOrExersize(
      {key, this.title, this.class_name, this.calssName, this.flag})
      : super(key: key);

  @override
  State<NewLessonOrExersize> createState() => _MyAppState();
}

class _MyAppState extends State<NewLessonOrExersize> {
  @override
  Widget build(BuildContext context) {
    print("helllllllllllllllllllllllllllllllllo");
    print(widget.calssName);
    String title2 = widget.title + "-" + "إضافة جديدة";

    return MaterialApp(
        title: 'Flutter Code Sample for Scaffold.of.',
        theme: ThemeData(primarySwatch: Colors.grey),
        home: Scaffold(
          body: new Stack(children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/sky2.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 120,
                    ),
                    MyScaffoldBody(
                      title: widget.title,
                      subject: widget.class_name,
                      calssName: widget.calssName,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyScaffoldBody2(
                        title: widget.title,
                        subject: widget.class_name,
                        calssName: widget.calssName,
                        flag: widget.flag)
                  ],
                ),
              ],
            ),
          ]),
          appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
                size: 18,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    title2,
                    style: GoogleFonts.amiri(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class MyScaffoldBody extends StatefulWidget {
  String title;
  String subject;
  String calssName;
  MyScaffoldBody({key, this.title, this.subject, this.calssName})
      : super(key: key);

  @override
  State<MyScaffoldBody> createState() => _MyScaffoldBodyState();
}

class _MyScaffoldBodyState extends State<MyScaffoldBody> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: queryData.size.height * 0.1,
          child: Row(children: <Widget>[
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, //background color of button
                      side: BorderSide(
                          width: 10,
                          color: Colors.white), //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(30)),
                      padding:
                          EdgeInsets.all(10) //content padding inside button
                      ),
                  onPressed: () {
                    print(
                        ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                    print(widget.subject);
                    print(widget.calssName);
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => newLesson(
                          title: widget.title + '-' + 'أضف درس',
                          sub: widget.subject,
                          calssName: widget.calssName,
                        ),
                      ),
                    );
                    //newListon();
                    //code to execute when this button is pressed.
                  },
                  child: Row(children: <Widget>[
                    IconButton(
                      icon: Center(
                        child: Icon(
                          Icons.add,
                          // Icons.more_horiz,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        // do something
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Text(
                            "إضـافة درس جـديد ",
                            style: GoogleFonts.amiri(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ],
                    )
                  ])),
            ),
          ]),
        ),
      ],
    ));
  }
}

class MyScaffoldBody2 extends StatefulWidget {
  String title;
  String subject;
  String calssName;
  bool flag;
  MyScaffoldBody2({key, this.title, this.subject, this.calssName, this.flag})
      : super(key: key);

  @override
  State<MyScaffoldBody2> createState() => _MyScaffoldBody2State();
}

class _MyScaffoldBody2State extends State<MyScaffoldBody2> {
  bool visibilityTag = false;

  void _changed(bool visibility) {
    setState(() {
      visibilityTag = visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: queryData.size.height * 0.1,
          // width: MediaQuery.of(context).size.width * 0.5,
          child: Row(children: <Widget>[
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: visibilityTag
                          ? Colors.grey
                          : Colors.orangeAccent, //background color of button
                      side: BorderSide(
                          width: 3,
                          color: visibilityTag
                              ? Colors.grey
                              : Colors.orangeAccent), //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(30)),
                      padding:
                          EdgeInsets.all(10) //content padding inside button
                      ),
                  onPressed: () {
                    _changed(!visibilityTag);
                    //code to execute when this button is pressed.
                  },
                  child: Row(children: <Widget>[
                    IconButton(
                      icon: Center(
                        child: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          // Icons.more_horiz,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        _changed(!visibilityTag);
                        // do something
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Text(
                            "إضـافة تـمرين جـديد  ",
                            style: GoogleFonts.amiri(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ],
                    ),
                  ])),
            ),
          ]),
        ),
        SizedBox(
          height: 4,
        ),
        visibilityTag
            ? SizedBox(
                // height: queryData.size.height * 0.08, //height of button
                // width: queryData.size.width * 5, //width of button

                child: Row(children: <Widget>[
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white, //background color of button
                            side: BorderSide(
                                width: 3,
                                color: Colors.white), //border width and color
                            elevation: 3, //elevation of button
                            shape: RoundedRectangleBorder(
                                //to set border radius to button
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(
                                10) //content padding inside button
                            ),
                        onPressed: () {
                          print("ttttttttttttttttttype1");
                          print(widget.calssName);

                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => type1(
                                title: widget.title + '-' + "أضف تمرين",
                                sub: widget.subject,
                                calssName: widget.calssName,
                                flag: widget.flag,
                              ),
                            ),
                          ); //code to execute when this button is pressed.
                        },
                        child: Row(children: <Widget>[
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.57,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text(
                                  "   الصـورة والحرف  ",
                                  style: GoogleFonts.amiri(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              )
                            ],
                          )
                        ])),
                  ),
                ]),
              )
            : Container(),
        SizedBox(
          height: 4,
        ),
        visibilityTag
            ? SizedBox(
                // height: queryData.size.height * 0.08, //height of button
                // width: queryData.size.width * 5, //width of button

                child: Row(children: <Widget>[
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white, //background color of button
                            side: BorderSide(
                                width: 3,
                                color: Colors.white), //border width and color
                            elevation: 3, //elevation of button
                            shape: RoundedRectangleBorder(
                                //to set border radius to button
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(
                                10) //content padding inside button
                            ),
                        onPressed: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => type2(
                                title: widget.title + '-' + "أضف تمرين",
                                sub: widget.subject,
                                calssName: widget.calssName,
                                flag: widget.flag,
                              ),
                            ),
                          ); //code to execute when this button is pressed.
                        },
                        child: Row(children: <Widget>[
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.57,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text(
                                  "  كتـابة الحرف الناقص ",
                                  style: GoogleFonts.amiri(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              )
                            ],
                          )
                        ])),
                  ),
                ]),
              )
            : Container(),
        SizedBox(
          height: 4,
        ),
        visibilityTag
            ? SizedBox(
                // height: queryData.size.height * 0.08, //height of button
                // width: queryData.size.width * 5, //width of button

                child: Row(children: <Widget>[
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white, //background color of button
                            side: BorderSide(
                                width: 3,
                                color: Colors.white), //border width and color
                            elevation: 3, //elevation of button
                            shape: RoundedRectangleBorder(
                                //to set border radius to button
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(
                                10) //content padding inside button
                            ),
                        onPressed: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => type3(
                                title: widget.title + '-' + "أضف تمرين",
                                sub: widget.subject,
                                calssName: widget.calssName,
                                flag: widget.flag,
                              ),
                            ),
                          ); //code to execute when this button is pressed.
                        },
                        child: Row(children: <Widget>[
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.57,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text(
                                  "   رسـم الحرف المنقط  ",
                                  style: GoogleFonts.amiri(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              )
                            ],
                          )
                        ])),
                  ),
                ]),
              )
            : Container()
      ],
    ));
  }
}
//  child: ElevatedButton(
//           child: const Text('SHOW BOTTOM SHEET'),
//           style: ButtonStyle(

//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18.0),
//                       side: BorderSide(color: Colors.white)))),
//           onPressed: () {},
//         )