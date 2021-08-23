import 'package:admin_kg1/parentGroupChats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'MyKids.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'ip_address.dart';
import 'notification_home.dart';

class ParentHome extends StatelessWidget {
  String id;
  ParentHome({key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> kids = [];
    List<dynamic> gender = [];
    List<dynamic> subjects = [];
    String className = "";
    // String IP = "12";

    Future getKids(String id) async {
      kids = [];
      gender = [];
      final String apiUrl = '${IP}getKids';
      final response = await http.post(Uri.parse(apiUrl), body: {"id": id});
      if (response.statusCode == 200) {
        final String responseString = response.body;
        if (responseString == "NO") {
          // state2 = "1";
        } else {
          Map decoded = json.decode(response.body) as Map<String, dynamic>;
          for (int i = 0; i < decoded['response'].length; i++) {
            kids.add(decoded['response'][i]['kids']);
            gender.add(decoded['response'][i]['gender']);
          }
        }
      }
    }

    Future getKidsClass(String id) async {
      className;
      final String apiUrl = '${IP}getKidsClass';
      final response = await http.post(Uri.parse(apiUrl), body: {"id": id});
      if (response.statusCode == 200) {
        final String responseString = response.body;
        if (responseString == "NO") {
          // state2 = "1";
        } else {
          Map decoded = json.decode(response.body) as Map<String, dynamic>;
          className = decoded['response'][0]['classname'];
          print(className);
        }
      }
    }

    Future getSubjectsChat() async {
      subjects = [];
      final String apiUrl = '${IP}getSubjectsChat';
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final String responseString = response.body;
        if (responseString == "NO") {
          // state2 = "1";
        } else {
          print("object");
          Map decoded = json.decode(response.body) as Map<String, dynamic>;
          subjects = decoded['response'];
          // for (int i = 0; i < decoded['response'].length; i++) {
          //   subjects.add(decoded['response'][i]['subject']);
          // }
        }
      }
      print(subjects);

      print(subjects[0]);
      print(subjects[0].runtimeType);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.bottomRight,
          child: Text("الصفحة الرئيسية ",
              style: GoogleFonts.amiri(color: Colors.black, fontSize: 20)),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  print("ggggggggggggggggg");

                  await getSubjectsChat();
                  print("ggggggggggggggggg");
                  await getKidsClass(id);
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) => new parentGroupChats(
                        classname: className, subjects: subjects, id: id),
                  );
                  Navigator.of(context).push(route);
                }, // Handle your callback.
                splashColor: Colors.red.withOpacity(0.5),

                child: Container(
                  // color: Colors.green,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.37,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.greenAccent),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Image.asset(
                          "assets/images/p.png",
                          fit: BoxFit.scaleDown,
                          width: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          child: Text("مركز الرسائل",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.amiri(
                                  color: Colors.white, fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              InkWell(
                onTap: () async {
                  await getKids(id);
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new MyKids(id: id, kids: kids, gender: gender),
                  );
                  Navigator.of(context).push(route);
                }, // Handle your callback.
                splashColor: Colors.red.withOpacity(0.5),

                child: Container(
                  // color: Colors.green,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.37,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.orangeAccent),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/k.png",
                        fit: BoxFit.contain,
                        width: 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Text("ابنائي",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.amiri(
                                color: Colors.white, fontSize: 20)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // InkWell(
              //   onTap: () async {
              //     //   print("ggggggggggggggggg");

              //     // //  await getSubjectsChat();
              //     //   print("ggggggggggggggggg");
              //     //   await getKidsClass(id);
              //     //   var route = new MaterialPageRoute(
              //     //     builder: (BuildContext context) => new parentGroupChats(
              //     //         classname: className, subjects: subjects, id: id),
              //     //   );
              //     //   Navigator.of(context).push(route);
              //   }, // Handle your callback.
              //   splashColor: Colors.red.withOpacity(0.5),

              //   child: Container(
              //     // color: Colors.green,
              //     height: MediaQuery.of(context).size.height * 0.2,
              //     width: MediaQuery.of(context).size.width * 0.37,
              //     decoration: BoxDecoration(
              //         border: Border.all(
              //           color: Colors.white,
              //           width: 3,
              //         ),
              //         borderRadius: BorderRadius.circular(30.0),
              //         color: Colors.pink[200]),
              //     child: Column(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(top: 17),
              //           child: Image.asset(
              //             "assets/images/progress.png",
              //             fit: BoxFit.fitWidth,
              //             width: 160,
              //             height: 70,
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(top: 0),
              //           child: Container(
              //             width: MediaQuery.of(context).size.width * 1,
              //             child: Text("مستوى أبنائي ",
              //                 textAlign: TextAlign.center,
              //                 style: GoogleFonts.amiri(
              //                     color: Colors.white, fontSize: 20)),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              InkWell(
                onTap: () async {
                  await getKidsClass(id);
                  // get notification list
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new NotificationHome(myKidsClass: className),
                  );
                  Navigator.of(context).push(route);
                }, // Handle your callback.
                splashColor: Colors.red.withOpacity(0.5),

                child: Container(
                  // color: Colors.green,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.37,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blueGrey[300]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, top: 20, bottom: 10),
                        child: Image.asset(
                          "assets/images/notification.png",
                          fit: BoxFit.contain,
                          width: 55,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Text("مركز الاشعارات",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.amiri(
                                color: Colors.white, fontSize: 20)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
