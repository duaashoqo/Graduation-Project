import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

import 'chatpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ip_address.dart';

class Students extends StatelessWidget {
  String id;
  String thistitle;
  List<dynamic> students;
  List<dynamic> gender;
  String Pid = '';
  String Pname = '';

  Students({
    key,
    this.id,
    this.thistitle,
    this.students,
    this.gender,
  }) : super(key: key);

  Future getParentNamee(String student_name) async {
    Pid = '';
    Pname = '';
    print("fffffffffffffffffffff");
    final String apiUrl = '${IP}getParentIdd';
    final response =
        await http.post(Uri.parse(apiUrl), body: {"name": student_name});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        Pid = decoded['response'][0]['id'];
        print("iiiiiiiiiiiiiidddddddddddddddddddddddddddddddddddd");
        print(Pid);
      }
    }
    final String apiUrl1 = '${IP}getParentNamee';
    final response1 = await http.post(Uri.parse(apiUrl1), body: {"id": Pid});
    if (response1.statusCode == 200) {
      final String responseString = response1.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded1 = json.decode(response1.body) as Map<String, dynamic>;
        Pname = decoded1['response'][0]['name'];
        print(Pname);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = '${thistitle}-استعراض الطلبة';
    String i = "1.jpg";

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  title,
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
            Container(
              // 80cce6
              color: Color.fromRGBO(80, 0xcc, 0xe6, 0.6),
              // alignment: Alignment.bottomCenter,
              // padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(left: 5, right: 5),
            ),
            ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                if (gender[index] == 'ذكر') {
                  i = "boy.png";
                } else
                  i = "girl.png";

                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.101,
                  width: MediaQuery.of(context).size.width * 1,
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chat_bubble),
                                color: Colors.grey,
                                tooltip: 'Chat with parent',
                                onPressed: () async {
                                  await getParentNamee(students[index]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatPage(
                                              id: id,
                                              stu_name: students[index],
                                              Pname: Pname)));
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text("مراسلة ولي الأمر",
                                    style: GoogleFonts.amiri(
                                        color: Colors.grey[900], fontSize: 10)),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text('${students[index]}',
                                      textDirection: TextDirection.rtl,
                                      style: GoogleFonts.amiri(
                                          color: Colors.black, fontSize: 15))),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/$i'),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      elevation: 5,
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    ),
                  ),
                );
              },
            )
          ],
        ));
  }
}
