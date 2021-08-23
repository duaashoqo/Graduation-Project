import 'package:admin_kg1/teacherGroupChat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Classes.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'ip_address.dart';

class teacherHome extends StatelessWidget {
  String id;
  List<dynamic> classes;
  List<dynamic> subjects;
  teacherHome({key, this.id, this.classes, this.subjects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> sub = [];

    String teacherName = '';
    String className = "";
    Future getTeacherclass(String id) async {
      teacherName = "";
      className = "";
      sub = [];
      final String apiUrl = '${IP}getTeacherNamee';
      final response1 = await http.post(Uri.parse(apiUrl), body: {"id": id});
      if (response1.statusCode == 200) {
        final String responseString = response1.body;
        if (responseString == "NO") {
        } else {
          Map decoded1 = json.decode(response1.body) as Map<String, dynamic>;
          teacherName = decoded1['response'][0]['name'];
        }
      }
      final String apiUrl1 = '${IP}getTeacherClass';
      final response2 =
          await http.post(Uri.parse(apiUrl1), body: {"name": teacherName});
      if (response2.statusCode == 200) {
        final String responseString = response2.body;
        if (responseString == "NO") {
        } else {
          Map decoded2 = json.decode(response2.body) as Map<String, dynamic>;
          className = decoded2['response'][0]['classname'];
        }
      }
      final String apiUrl2 = '${IP}getSub';
      final response3 =
          await http.post(Uri.parse(apiUrl2), body: {"name": teacherName});
      if (response2.statusCode == 200) {
        final String responseString = response3.body;
        if (responseString == "NO") {
        } else {
          Map decoded3 = json.decode(response3.body) as Map<String, dynamic>;
          for (int i = 0; i < decoded3['response'].length; i++) {
            sub.add(decoded3['response'][i]['subjects']);
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "الصفحة الرئيسية",
                style: GoogleFonts.amiri(color: Colors.black, fontSize: 20),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
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
                  await getTeacherclass(id);

                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) => new teacherGroupChats(
                        classname: className, subjects: sub, id: id),
                  );
                  Navigator.of(context).push(route);
                }, // Handle your callback.
                splashColor: Colors.red.withOpacity(0.5),

                child: Container(
                  // color: Colors.green,
                  height: MediaQuery.of(context).size.height * 0.17,
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
                        child: Text("مركز الرسائل",
                            style: GoogleFonts.amiri(
                                color: Colors.white, fontSize: 20)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.11,
              ),
              InkWell(
                onTap: () async {
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) => new Classes(
                        id: id, classes: classes, subjects: subjects),
                  );
                  Navigator.of(context).push(route);
                }, // Handle your callback.
                splashColor: Colors.red.withOpacity(0.5),

                child: Container(
                  // color: Colors.green,
                  height: MediaQuery.of(context).size.height * 0.17,
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
                      Text("صفوفي",
                          style: GoogleFonts.amiri(
                              color: Colors.white, fontSize: 20))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
