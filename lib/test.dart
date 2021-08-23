import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'E_type1.dart';
import 'NewLesson.dart';
import 'E_type2.dart';
import 'E_type3.dart';

class test extends StatefulWidget {
  String title;
  String class_name;
  String calssName;
  test({key, this.title, this.class_name, this.calssName}) : super(key: key);

  @override
  State<test> createState() => _MyAppState();
}

class _MyAppState extends State<test> {
  @override
  Widget build(BuildContext context) {
    print("helllllllllllllllllllllllllllllllllo");
    print(widget.calssName);
    String title2 = widget.title + '-' + widget.class_name;

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
                      title: title2,
                      subject: widget.class_name,
                      calssName: widget.calssName,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyScaffoldBody2(
                      title: title2,
                      subject: widget.class_name,
                      calssName: widget.calssName,
                    )
                  ],
                ),
              ],
            ),
          ]),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Align(
              alignment: Alignment.bottomRight,
              child: Text(title2,
                  style: GoogleFonts.amiri(color: Colors.black, fontSize: 18)),
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
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Text(
                      "اضافة درس جديد   ",
                      style:
                          GoogleFonts.amiri(color: Colors.black, fontSize: 15),
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
  MyScaffoldBody2({
    key,
    this.title,
    this.subject,
    this.calssName,
  }) : super(key: key);

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
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Text(
                      " اضافة تمرين جديد",
                      style:
                          GoogleFonts.amiri(color: Colors.black, fontSize: 15),
                    )
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
                              ),
                            ),
                          ); //code to execute when this button is pressed.
                        },
                        child: Row(children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.37,
                          ),
                          Text(
                            "  الصورة والحرف    ",
                            style: GoogleFonts.amiri(
                                fontSize: 13, fontWeight: FontWeight.bold),
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
                                  calssName: widget.calssName),
                            ),
                          ); //code to execute when this button is pressed.
                        },
                        child: Row(children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          Text(
                            "   كتابة الحرف الناقص    ",
                            style: GoogleFonts.amiri(
                                fontSize: 13, fontWeight: FontWeight.bold),
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
                              ),
                            ),
                          ); //code to execute when this button is pressed.
                        },
                        child: Row(children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          Text(
                            "   رسم الحرف المنقط    ",
                            style: GoogleFonts.amiri(
                                fontSize: 13, fontWeight: FontWeight.bold),
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