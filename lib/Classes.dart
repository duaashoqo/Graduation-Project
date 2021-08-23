import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Subjects.dart';
import 'dart:convert';

import 'ip_address.dart';

class Classes extends StatelessWidget {
  String id;
  List<dynamic> classes;
  List<dynamic> subjects;
  bool isSet;

  Classes({key, this.id, this.classes, this.subjects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String state2 = '1';

    Future getSubject(String id, String class_name) async {
      final String apiUrl = '${IP}getSubjects';
      final response = await http
          .post(Uri.parse(apiUrl), body: {"id": id, "class_name": class_name});
      if (response.statusCode == 200) {
        final String responseString = response.body;
        if (responseString == "NO") {
          // state2 = "1";
        } else {
          Map decoded = json.decode(response.body) as Map<String, dynamic>;
          subjects = [];

          for (int i = 0; i < decoded['response'].length; i++) {
            subjects.add(decoded['response'][i]['subjects']);
          }
          print(subjects);
          state2 = decoded['response'][0]['state'];
        }
      }
    }

    print(classes);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "صفوفي",
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
                      image: new AssetImage("assets/images/sky2.png"),
                      fit: BoxFit.fill)),
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 150.0),
            ),
            ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: GestureDetector(
                            onTap: () async {
                              await getSubject(this.id, classes[index]);
                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) => new Subjects(
                                    id: id,
                                    subjects: subjects,
                                    thisclass: classes[index]),
                              );
                              Navigator.of(context).push(route);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    color: Colors.black,
                                    onPressed: () async {
                                      await getSubject(this.id, classes[index]);
                                      var route = new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new Subjects(
                                                id: id,
                                                subjects: subjects,
                                                thisclass: classes[index]),
                                      );
                                      Navigator.of(context).push(route);
                                    },
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 20, 5),
                                          child: Text('${classes[index]}',
                                              style: GoogleFonts.amiri(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight:
                                                      FontWeight.bold)))),
                                ],
                              ),
                              elevation: 5,
                              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            ),
                          ),
                        )
                      ],
                    );
                  } else
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: GestureDetector(
                        onTap: () async {
                          await getSubject(this.id, classes[index]);
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new Subjects(
                                id: id,
                                subjects: subjects,
                                thisclass: classes[index]),
                          );
                          Navigator.of(context).push(route);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                color: Colors.black,
                                onPressed: () async {
                                  await getSubject(this.id, classes[index]);
                                  var route = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new Subjects(
                                            id: id,
                                            subjects: subjects,
                                            thisclass: classes[index]),
                                  );
                                  Navigator.of(context).push(route);
                                },
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 5, 20, 5),
                                      child: Text('${classes[index]}',
                                          style: GoogleFonts.amiri(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)))),
                            ],
                          ),
                          elevation: 5,
                          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        ),
                      ),
                    );
                }),
          ],
        ));
  }
}
