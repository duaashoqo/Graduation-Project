import 'package:admin_kg1/videos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Excersises.dart';
import 'ip_address.dart';

class lessonOrExc extends StatelessWidget {
  String code;
  String sub;
  List<dynamic> num = [];
  List<dynamic> vid = [];
  String className;

  lessonOrExc({key, this.code, this.sub, this.num, this.vid}) : super(key: key);

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
          children: <Widget>[
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
                                var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new VideoDemo(
                                          video_list: vid, code: code),
                                );
                                Navigator.of(context).push(route);
                              }, // Handle your callback.
                              splashColor: Colors.greenAccent.withOpacity(0.5),

                              child: Container(
                                // color: Colors.green,
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                width: MediaQuery.of(context).size.width * 0.65,

                                child: Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: Image.asset(
                                    "assets/images/23424.png",
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
                                //await getKids(id);
                                await classOfChild(code);
                                var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new Excersises(
                                    num: num,
                                    c: ((num.length / 3).floor()),
                                    sub: sub,
                                    code: code,
                                    className: className,
                                  ),
                                );
                                Navigator.of(context).push(route);
                              }, // Handle your callback.
                              splashColor: Colors.greenAccent.withOpacity(0.5),

                              child: Container(
                                // color: Colors.green,
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                width: MediaQuery.of(context).size.width * 0.65,

                                child: Image.asset(
                                  "assets/images/34234.png",
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
                leading: new IconButton(
                  icon: new Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.grey[800],
                    size: 18,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                backgroundColor: Colors.grey[800],
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        " هيا لنتعلم ال${sub} ",
                        style: GoogleFonts.amiri(
                          color: Colors.white,
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
      ]),
    );
  }

  Future classOfChild(String code) async {
    print(code);
    print("ggggggggggggggggggggggggggggggggggggggggggggggggg");
    final String apiUrl = '${IP}classOfChild';
    final response = await http.post(Uri.parse(apiUrl), body: {"code": code});
    print(response);
    if (response.statusCode == 200) {
      Map decoded = json.decode(response.body) as Map<String, dynamic>;

      if (decoded['response'][0] == "NO") {
        print("object");
      } else {
        className = decoded['response'][0]['className'];
        print(className);
        print("5555555555555555555555555555");
      }
    }
  }
}
