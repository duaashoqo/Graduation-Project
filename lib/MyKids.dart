// import 'dart:async';
// import 'dart:convert';
// import 'package:admin_kg1/Subjects.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:pin_code_text_field/pin_code_text_field.dart';

// import 'chatpage2.dart';
// import 'ip_address.dart';

// //import 'Child.dart';

// class MyKids extends StatefulWidget {
//   List<dynamic> kids;
//   List<dynamic> gender;
//   String id;
//   MyKids({key, this.id, this.kids, this.gender}) : super(key: key);
//   bool clicked = false;
//   int selected;
//   List<dynamic> subjects = [];

//   @override
//   _MyKidsState createState() => _MyKidsState();
// }

// class _MyKidsState extends State<MyKids> {
//   @override
//   // void initState() {
//   //   super.initState();
//   //   WidgetsBinding.instance.addPostFrameCallback((_) => getStudentSubject());
//   // }

//   @override
//   Widget build(BuildContext context) {
//     String i = "1.jpg";
//     List<int> number = [1, 2, 3, 4, 5];

//     return Scaffold(
//         body: Stack(
//       fit: StackFit.expand,
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//               image: new DecorationImage(
//                   image: new AssetImage("assets/images/sky.jpg"),
//                   fit: BoxFit.cover)),
//           alignment: Alignment.bottomCenter,
//           padding: EdgeInsets.only(bottom: 150.0),
//         ),
//         CustomScrollView(slivers: [
//           SliverAppBar(
//             backgroundColor: Colors.white,
//             pinned: true,
//             title: Align(
//               alignment: Alignment.bottomRight,
//               child: Text("أبنائي",
//                   style: GoogleFonts.amiri(color: Colors.black, fontSize: 20)),
//             ),
//             expandedHeight: MediaQuery.of(context).size.height * 0.06,
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 if (widget.gender[index] == 'ذكر') {
//                   i = "boy.png";
//                 } else
//                   i = "girl.png";
//                 if (index == 0) {
//                   return SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 50,
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.1,
//                           child: GestureDetector(
//                             onTap: () async {
//                               await getStudentSubject();
//                               setState(() {
//                                 widget.selected = index;
//                                 widget.clicked = !widget.clicked;
//                               });
//                             },
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                 side:
//                                     BorderSide(color: Colors.white70, width: 1),
//                                 borderRadius: BorderRadius.circular(0),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.more_vert),
//                                     color: Colors.grey,
//                                     onPressed: () {},
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                           child: Text('${widget.kids[index]}',
//                                               textDirection: TextDirection.rtl,
//                                               style: GoogleFonts.amiri(
//                                                   color: Colors.black,
//                                                   fontSize: 14))),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             right: 10, left: 10),
//                                         child: Container(
//                                           width: 35,
//                                           height: 35,
//                                           decoration: BoxDecoration(
//                                             image: DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/images/$i'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                             shape: BoxShape.circle,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               elevation: 5,
//                               margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
//                             ),
//                           ),
//                         ),
//                         widget.selected == index && widget.clicked
//                             ? Column(
//                                 children: [
//                                   for (int i = 0;
//                                       i < widget.subjects.length;
//                                       i++)
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.12,
//                                       child: GestureDetector(
//                                         onTap: () {},
//                                         child: Card(
//                                           shape: RoundedRectangleBorder(
//                                             side: BorderSide(
//                                                 color: Colors.white70,
//                                                 width: 1),
//                                             borderRadius:
//                                                 BorderRadius.circular(0),
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   IconButton(
//                                                     icon: const Icon(
//                                                         Icons.chat_bubble),
//                                                     color: Colors.grey,
//                                                     tooltip:
//                                                         'Chat with teacher',
//                                                     onPressed: () {
//                                                       print(
//                                                           "chatttttttttttttttttt");
//                                                       print(widget.id);
//                                                       Navigator.push(
//                                                           context,
//                                                           MaterialPageRoute(
//                                                               builder: (context) => ChatPage2(
//                                                                   id: widget.id,
//                                                                   stu_name: widget
//                                                                           .kids[
//                                                                       index],
//                                                                   sub_name:
//                                                                       widget.subjects[
//                                                                           i])));
//                                                     },
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 15),
//                                                     child: Text("مراسلة المعلم",
//                                                         style:
//                                                             GoogleFonts.amiri(
//                                                                 color: Colors
//                                                                     .black,
//                                                                 fontSize: 10)),
//                                                   )
//                                                 ],
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 children: [
//                                                   Container(
//                                                       child: Text(
//                                                           '${widget.subjects[i]}',
//                                                           textDirection:
//                                                               TextDirection.rtl,
//                                                           style:
//                                                               GoogleFonts.amiri(
//                                                                   color: Colors
//                                                                       .black,
//                                                                   fontSize:
//                                                                       14))),
//                                                   SizedBox(
//                                                     width: 30,
//                                                   )
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           elevation: 10,
//                                           margin:
//                                               EdgeInsets.fromLTRB(15, 0, 15, 0),
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               )
//                             : SizedBox(
//                                 height: 1,
//                               ),
//                       ],
//                     ),
//                   );
//                 } else
//                   return SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.1,
//                           child: GestureDetector(
//                             onTap: () async {
//                               await getStudentSubject();
//                               setState(() {
//                                 widget.selected = index;
//                                 widget.clicked = !widget.clicked;
//                               });
//                             },
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                 side:
//                                     BorderSide(color: Colors.white70, width: 1),
//                                 borderRadius: BorderRadius.circular(0),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.more_vert),
//                                     color: Colors.grey,
//                                     onPressed: () {},
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                           child: Text('${widget.kids[index]}',
//                                               textDirection: TextDirection.rtl,
//                                               style: GoogleFonts.amiri(
//                                                   color: Colors.black,
//                                                   fontSize: 14))),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             right: 10, left: 10),
//                                         child: Container(
//                                           width: 35,
//                                           height: 35,
//                                           decoration: BoxDecoration(
//                                             image: DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/images/$i'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                             shape: BoxShape.circle,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               elevation: 5,
//                               margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
//                             ),
//                           ),
//                         ),
//                         widget.selected == index && widget.clicked
//                             ? Column(
//                                 children: [
//                                   for (int i = 0;
//                                       i < widget.subjects.length;
//                                       i++)
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.12,
//                                       child: GestureDetector(
//                                         onTap: () {},
//                                         child: Card(
//                                           shape: RoundedRectangleBorder(
//                                             side: BorderSide(
//                                                 color: Colors.white70,
//                                                 width: 1),
//                                             borderRadius:
//                                                 BorderRadius.circular(0),
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   IconButton(
//                                                     icon: const Icon(
//                                                         Icons.chat_bubble),
//                                                     color: Colors.grey,
//                                                     tooltip:
//                                                         'Chat with teacher',
//                                                     onPressed: () {
//                                                       print(
//                                                           "chatttttttttttttttttt");
//                                                       Navigator.push(
//                                                           context,
//                                                           MaterialPageRoute(
//                                                               builder: (context) => ChatPage2(
//                                                                   stu_name: widget
//                                                                           .kids[
//                                                                       index],
//                                                                   sub_name:
//                                                                       widget.subjects[
//                                                                           i])));
//                                                     },
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 15),
//                                                     child: Text("مراسلة المعلم",
//                                                         style:
//                                                             GoogleFonts.amiri(
//                                                                 color: Colors
//                                                                     .black,
//                                                                 fontSize: 10)),
//                                                   )
//                                                 ],
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 children: [
//                                                   Container(
//                                                       child: Text(
//                                                           '${widget.subjects[i]}',
//                                                           textDirection:
//                                                               TextDirection.rtl,
//                                                           style:
//                                                               GoogleFonts.amiri(
//                                                                   color: Colors
//                                                                       .black,
//                                                                   fontSize:
//                                                                       14))),
//                                                   SizedBox(
//                                                     width: 30,
//                                                   )
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           elevation: 10,
//                                           margin:
//                                               EdgeInsets.fromLTRB(15, 0, 15, 0),
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               )
//                             : SizedBox(
//                                 height: 1,
//                               ),
//                       ],
//                     ),
//                   );
//               },
//               childCount: widget.kids.length,
//             ),
//           )
//         ]),
//       ],
//     ));
//   }

//   Future getStudentSubject() async {
//     widget.subjects = [];
//     final String apiUrl = '${IP}getStudentSubject';
//     final response = await http.get(Uri.parse(apiUrl));
//     if (response.statusCode == 200) {
//       final String responseString = response.body;
//       if (responseString == "NO") {
//         // state2 = "1";
//       } else {
//         Map decoded = json.decode(response.body) as Map<String, dynamic>;
//         for (int i = 0; i < decoded['response'].length; i++) {
//           widget.subjects.add(decoded['response'][i]['subject']);
//         }
//       }
//     }
//     print(widget.subjects);

//     print(widget.subjects[0]);
//     print(widget.subjects[0].runtimeType);
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'package:admin_kg1/Subjects.dart';
import 'package:admin_kg1/parentChildProgress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_text_field/pin_code_text_field.dart';

import 'chatpage2.dart';
import 'ip_address.dart';

//import 'Child.dart';

class MyKids extends StatefulWidget {
  List<dynamic> kids;
  List<dynamic> gender;
  String id;
  MyKids({key, this.id, this.kids, this.gender}) : super(key: key);
  bool clicked = false;
  int selected;
  List<dynamic> subjects = [];

  @override
  _MyKidsState createState() => _MyKidsState();
}

class _MyKidsState extends State<MyKids> {
  String code;
  List<String> symbol;
  List<String> flag1;
  List<String> flag2;
  List<String> flag3;
  List<String> AllSymbol;
  String className;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => getStudentSubject());
  // }

  @override
  Widget build(BuildContext context) {
    String i = "1.jpg";
    List<int> number = [1, 2, 3, 4, 5];
    Color c = Colors.pink;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "أبنائـي",
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
            ListView.builder(
              itemCount: widget.kids.length,
              itemBuilder: (context, index) {
                if (widget.gender[index] == 'ذكر') {
                  i = "boy.png";
                  c = Colors.blue[200];
                } else {
                  c = Colors.pink[200];
                  i = "girl.png";
                }
                if (index == 0) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: GestureDetector(
                            onTap: () async {
                              await getStudentSubject();
                              setState(() {
                                widget.selected = index;
                                widget.clicked = !widget.clicked;
                              });
                            },
                            child: Card(
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text('${widget.kids[index]}',
                                              textDirection: TextDirection.rtl,
                                              style: GoogleFonts.amiri(
                                                  color: Colors.black,
                                                  fontSize: 15))),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/$i'),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              elevation: 5,
                            ),
                          ),
                        ),
                        widget.selected == index && widget.clicked
                            ? Column(
                                children: [
                                  for (int i = 0;
                                      i < widget.subjects.length;
                                      i++)
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.white70,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.chat_bubble),
                                                        color: Colors.grey[700],
                                                        tooltip:
                                                            'Chat with teacher',
                                                        onPressed: () {
                                                          print(
                                                              "chatttttttttttttttttt");
                                                          print(widget.id);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => ChatPage2(
                                                                      id: widget
                                                                          .id,
                                                                      stu_name:
                                                                          widget.kids[
                                                                              index],
                                                                      sub_name:
                                                                          widget
                                                                              .subjects[i])));
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: Text(
                                                            "مراسلة المعلم",
                                                            style: GoogleFonts
                                                                .amiri(
                                                                    color: Colors
                                                                            .grey[
                                                                        900],
                                                                    fontSize:
                                                                        10)),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.child_care),
                                                        color: c,
                                                        tooltip: 'مستوى طفلي',
                                                        onPressed: () async {
                                                          await getMyKidsCode(
                                                              widget.id);
                                                          print(
                                                              "DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
                                                          await classOfChild(
                                                              code);
                                                          print(className);
                                                          print(
                                                              "peforeeeeeeeeee progresssssssssssss");
                                                          print(className);
                                                          print(widget
                                                              .subjects[i]);
                                                          await getSubjectExersizes(
                                                              widget
                                                                  .subjects[i],
                                                              className);
                                                          await getMyKidsCode(
                                                              widget.id);

                                                          await getInfoToMyKidsProgress(
                                                              code,
                                                              widget
                                                                  .subjects[i]);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          MyChildPregress(
                                                                            title:
                                                                                "مستوى اطفالي",
                                                                            symbol:
                                                                                symbol,
                                                                            flag1:
                                                                                flag1,
                                                                            flag2:
                                                                                flag2,
                                                                            flag3:
                                                                                flag3,
                                                                          )));
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                        child: Text(
                                                            " مستوى طفلي",
                                                            style: GoogleFonts
                                                                .amiri(
                                                                    color: Colors
                                                                            .grey[
                                                                        900],
                                                                    fontSize:
                                                                        10)),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      child: Text(
                                                          '${widget.subjects[i]}',
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          style:
                                                              GoogleFonts.amiri(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      15))),
                                                  SizedBox(
                                                    width: 30,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          elevation: 10,
                                          margin:
                                              EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        ),
                                      ),
                                    ),
                                ],
                              )
                            : SizedBox(
                                height: 1,
                              ),
                      ],
                    ),
                  );
                } else
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: GestureDetector(
                            onTap: () async {
                              await getStudentSubject();
                              setState(() {
                                widget.selected = index;
                                widget.clicked = !widget.clicked;
                              });
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
                                    icon: const Icon(Icons.more_vert),
                                    color: Colors.grey,
                                    onPressed: () {},
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text('${widget.kids[index]}',
                                              textDirection: TextDirection.rtl,
                                              style: GoogleFonts.amiri(
                                                  color: Colors.black,
                                                  fontSize: 15))),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/$i'),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              elevation: 5,
                              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            ),
                          ),
                        ),
                        widget.selected == index && widget.clicked
                            ? Column(
                                children: [
                                  for (int i = 0;
                                      i < widget.subjects.length;
                                      i++)
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.white70,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.chat_bubble),
                                                    color: Colors.grey,
                                                    tooltip:
                                                        'Chat with teacher',
                                                    onPressed: () {
                                                      print(
                                                          "chatttttttttttttttttt");
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => ChatPage2(
                                                                  stu_name: widget
                                                                          .kids[
                                                                      index],
                                                                  sub_name:
                                                                      widget.subjects[
                                                                          i])));
                                                    },
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Text("مراسلة المعلم",
                                                        style:
                                                            GoogleFonts.amiri(
                                                                color: Colors
                                                                    .grey[900],
                                                                fontSize: 10)),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      child: Text(
                                                          '${widget.subjects[i]}',
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          style:
                                                              GoogleFonts.amiri(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      15))),
                                                  SizedBox(
                                                    width: 30,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          elevation: 10,
                                          margin:
                                              EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        ),
                                      ),
                                    ),
                                ],
                              )
                            : SizedBox(
                                height: 1,
                              ),
                      ],
                    ),
                  );
              },
            ),
          ],
        ));
  }

  getMyKidsCode(String id) async {
    print("ازبطططططططططططططططططططططططططططططططططططططط");
    final String apiUrl = '${IP}getMyKidsCode';
    final response = await http.post(Uri.parse(apiUrl), body: {"id": id});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        code = decoded['response'][0]['code'];
        print(code);
      }
    }
  }

  Future getStudentSubject() async {
    widget.subjects = [];
    final String apiUrl = '${IP}getStudentSubject';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        for (int i = 0; i < decoded['response'].length; i++) {
          widget.subjects.add(decoded['response'][i]['subject']);
        }
      }
    }
    print(widget.subjects);

    print(widget.subjects[0]);
    print(widget.subjects[0].runtimeType);
  }

  getInfoToMyKidsProgress(code, sub) async {
    symbol = [];
    flag1 = [];
    flag2 = [];
    flag3 = [];
    bool flag = false;
    print("inside getInfoToMyKidsProgresssssssssssssssssssssssssssssss");
    print(code);

    final String apiUrl = '${IP}getInfoToMyKidsProgress';
    final response =
        await http.post(Uri.parse(apiUrl), body: {"code": code, "sub": sub});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'][0]['symbol'] != null) {
          for (int i = 0; i < decoded['response'].length; i++) {
            symbol.add(decoded['response'][i]['symbol']);
            flag1.add(decoded['response'][i]['flag1']);
            flag2.add(decoded['response'][i]['flag2']);
            flag3.add(decoded['response'][i]['flag3']);
          }
        } else {
          print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        }
        for (int i = 0; i < AllSymbol.length; i++) {
          print(
              "'''''''''''''''''''''''''''''''object'''''''''''''''''''''''''''''''");
          for (int j = 0; j < symbol.length; j++) {
            if (AllSymbol[i] == symbol[j]) {
              flag = true;
              print(":::::::::::::::::::::::::");
            }
          }
          if (!flag) {
            symbol.add(AllSymbol[i]);
            flag1.add("false");
            flag2.add("false");
            flag3.add("false");
          }
          flag = false;
        }
        print("rrrrrRRRRRRRRRRRRRRRRRRRRRRRRR");
        print(symbol);
      }
      print("symbol");
      print(symbol);
      print("flag1");

      print(flag1);
      print("flag2");

      print(flag2);
      print("flag3");

      print(flag3);
    }
  }

  Future getSubjectExersizes(String subject, String class_name) async {
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    print(class_name);
    print(subject);

    AllSymbol = [];
    String apiUrl = '${IP}getSubjectExersizes1';
    var response = await http.post(Uri.parse(apiUrl),
        body: {"subject_name": subject, "class_name": class_name});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'][0]['type'] == 1) {
          for (int i = 0; i < decoded['response'].length; i++) {
            AllSymbol.add(decoded['response'][i]['answer']);
            print("kkkkkkkkkkkkkkkkkkkkkkkkk");
            print(AllSymbol[i]);
          }
        }
        print("allllllllllllllll symbollllllllll");
        print(AllSymbol);
      }
    }
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
