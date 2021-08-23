import 'dart:async';
import 'dart:convert';
import 'package:admin_kg1/Subjects.dart';
import 'package:admin_kg1/subjectChat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_text_field/pin_code_text_field.dart';

import 'chatpage2.dart';
import 'ip_address.dart';

//import 'Child.dart';

class parentGroupChats extends StatefulWidget {
  List<dynamic> subjects;
  String classname;
  String id;
  String parentName;

  parentGroupChats(
      {key, this.classname, this.subjects, this.id, this.parentName})
      : super(key: key);

  @override
  _MyKidsState createState() => _MyKidsState();
}

class _MyKidsState extends State<parentGroupChats> {
  @override
  List newSubjects = [];
  @override
  void initState() {
    for (int i = 0; i < widget.subjects.length; i++) {
      if (widget.subjects[i] == 'عربي') {
        newSubjects.add('اللغة العربية');
      } else if (widget.subjects[i] == 'رياضيات') {
        newSubjects.add('الرياضيات ');
      } else if (widget.subjects[i] == 'انجليزي') {
        newSubjects.add('اللغة الانجليزية ');
      }
    }
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) => getStudentSubject());
  }

  @override
  Widget build(BuildContext context) {
    String Pname;
    return Scaffold(
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
                  "المحادثات الجماعية",
                  style: GoogleFonts.amiri(color: Colors.black, fontSize: 20),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage("assets/images/sky4.png"),
                      fit: BoxFit.fill)),
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 150.0),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
                itemCount: widget.subjects.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        GestureDetector(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              elevation: 4.5,
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: ListTile(
                                title: Text(
                                    'المحادثة الجماعية الخاصة بمادة ${newSubjects[index]}',
                                    textDirection: TextDirection.rtl,
                                    style: GoogleFonts.amiri(
                                        color: Colors.black, fontSize: 20)),
                              ),
                            ),
                            onTap: () async {
                              final String apiUrl1 = '${IP}getParentNamee';
                              final response1 = await http.post(
                                  Uri.parse(apiUrl1),
                                  body: {"id": widget.id});
                              if (response1.statusCode == 200) {
                                final String responseString = response1.body;
                                if (responseString == "NO") {
                                  // state2 = "1";
                                } else {
                                  Map decoded1 = json.decode(response1.body)
                                      as Map<String, dynamic>;
                                  Pname = decoded1['response'][0]['name'];
                                  print(Pname);
                                }
                              }

                              print("beforeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new subjectChat(
                                  classname: widget.classname,
                                  subjectname: widget.subjects[index],
                                  id: widget.id,
                                  userName: Pname,
                                ),
                              );
                              Navigator.of(context).push(route);
                              print("afterrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
                            })
                      ],
                    );
                  } else
                    return GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          elevation: 4.5,
                          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: ListTile(
                            title: Text(
                                'المحادثة الجماعية الخاصة بمادة ${newSubjects[index]}',
                                textDirection: TextDirection.rtl,
                                style: GoogleFonts.amiri(
                                    color: Colors.black, fontSize: 20)),
                          ),
                        ),
                        onTap: () async {
                          final String apiUrl1 = '${IP}getParentNamee';
                          final response1 = await http.post(Uri.parse(apiUrl1),
                              body: {"id": widget.id});
                          if (response1.statusCode == 200) {
                            final String responseString = response1.body;
                            if (responseString == "NO") {
                              // state2 = "1";
                            } else {
                              Map decoded1 = json.decode(response1.body)
                                  as Map<String, dynamic>;
                              Pname = decoded1['response'][0]['name'];
                              print(Pname);
                            }
                          }

                          print("beforeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new subjectChat(
                              classname: widget.classname,
                              subjectname: widget.subjects[index],
                              id: widget.id,
                              userName: Pname,
                            ),
                          );
                          Navigator.of(context).push(route);
                          print("afterrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
                        });
                })
          ],
        ));
  }
}
