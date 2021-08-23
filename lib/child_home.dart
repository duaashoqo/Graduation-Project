import 'package:admin_kg1/Subjects.dart';
import 'package:admin_kg1/subjectChat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ip_address.dart';
import 'lessonOrExc.dart';

class child_home extends StatelessWidget {
  String code = '';
  String name = '';
  child_home({key, this.code, this.name}) : super(key: key);
  String subject = '';
  List<dynamic> Numbers = [];
  List<dynamic> Videos = [];
  String className;

  Future getNumbers(String arabic, String className) async {
    Numbers = [];
    print(arabic);
    print(className);
    print(":::::::::::::::::::::::::::::::::::::::::::::::::");
    final String apiUrl = '${IP}getNumbers';
    final response = await http.post(Uri.parse(apiUrl),
        body: {"subjectName": arabic, "className": className});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        for (int i = 0; i < decoded['response'].length; i++) {
          Numbers.add(decoded['response'][i]['num']);
        }
        print(Numbers);
      }
    }
  }

  Future getClassNameCode(String code) async {
    print(code);
    final String apiUrl = '${IP}getClassNameCode';
    final response = await http.post(Uri.parse(apiUrl), body: {"code": code});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        className = (decoded['response'][0]['className']);

        print(".......................................");
        print(className);
      }
    }
  }

  Future getVideos(String arabic) async {
    Videos = [];
    final String apiUrl = '${IP}getVideos';
    final response =
        await http.post(Uri.parse(apiUrl), body: {"subjectName": arabic});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        for (int i = 0; i < decoded['response'].length; i++) {
          Videos.add(decoded['response'][i]['vid']);
        }
        print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
        print(Videos);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height * 0.07;
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/sky2.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.97,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Card(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                          InkWell(
                            onTap: () async {
                              subject = "عربي";
                              await getClassNameCode(code);
                              await getNumbers(subject, className);
                              //  getVideos()
                              await getVideos(subject);

                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new lessonOrExc(
                                  code: code,
                                  sub: subject,
                                  num: Numbers,
                                  vid: Videos,
                                ),
                              );
                              Navigator.of(context).push(route);
                            }, // Handle your callback.
                            splashColor: Colors.greenAccent.withOpacity(0.5),

                            child: Container(
                              // color: Colors.green,
                              height: MediaQuery.of(context).size.height * 0.22,
                              width: MediaQuery.of(context).size.width * 0.65,

                              child: Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Image.asset(
                                  "assets/images/ar2.png",
                                  fit: BoxFit.fill,
                                  width: 50,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                          ),
                          InkWell(
                            onTap: () async {
                              subject = 'رياضيات';
                              await getClassNameCode(code);

                              await getNumbers(subject, className);
                              await getVideos(subject);

                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new lessonOrExc(
                                  code: code,
                                  sub: subject,
                                  num: Numbers,
                                  vid: Videos,
                                ),
                              );
                              Navigator.of(context).push(route);
                            }, // Handle your callback.
                            splashColor: Colors.greenAccent.withOpacity(0.5),

                            child: Container(
                              // color: Colors.green,
                              height: MediaQuery.of(context).size.height * 0.20,
                              width: MediaQuery.of(context).size.width * 0.65,

                              child: Image.asset(
                                "assets/images/ma.png",
                                fit: BoxFit.contain,
                                width: 100,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              subject = 'انجليزي';
                              await getClassNameCode(code);
                              await getNumbers(subject, className);
                              await getVideos(subject);

                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new lessonOrExc(
                                  code: code,
                                  sub: subject,
                                  num: Numbers,
                                  vid: Videos,
                                ),
                              );
                              Navigator.of(context).push(route);
                            }, // Handle your callback.
                            splashColor: Colors.greenAccent.withOpacity(0.5),

                            child: Container(
                              // color: Colors.green,
                              height: MediaQuery.of(context).size.height * 0.20,
                              width: MediaQuery.of(context).size.width * 0.65,

                              child: Image.asset(
                                "assets/images/ens.png",
                                fit: BoxFit.contain,
                                width: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 0),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 80,
            child: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "أهلاً بك يا ${name}  ",
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
          ),
        ],
      ),
    ]));
  }
}
