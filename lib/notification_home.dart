import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class NotificationHome extends StatelessWidget {
  String myKidsClass;

  NotificationHome({key, this.myKidsClass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String i = "1.jpg";
    DateTime now = DateTime.now();

    String time = now.hour.toString() + ":" + now.minute.toString();

    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('notification')
            .document("${myKidsClass}")
            .collection("${myKidsClass}")
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            // print(snapshot.data);
            // print(myKidsClass);
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            image: new DecorationImage(
                                image: new AssetImage("assets/images/sky.jpg"),
                                fit: BoxFit.cover)),
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(bottom: 150.0),
                      ),
                      CustomScrollView(slivers: [
                        SliverAppBar(
                          backgroundColor: Colors.blueGrey[400],
                          pinned: true,
                          title: Align(
                            alignment: Alignment.bottomRight,
                            child: Text("إشعاراتي",
                                style: GoogleFonts.amiri(
                                    color: Colors.white, fontSize: 17)),
                          ),
                          expandedHeight:
                              MediaQuery.of(context).size.height * 0.06,
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (snapshot.data.documents[index]
                                      ["subjectName"] ==
                                  'عربي') {
                                i = "arabic_l.png";
                                //  print("عربيييييييييييييييييييييييييييييي");
                              } else if (snapshot.data.documents[index]
                                      ["subjectName"] ==
                                  'رياضيات') {
                                // print("رياضيااااااااااااااااااااات");
                                i = "english_l.png";
                              } else if (snapshot.data.documents[index]
                                      ["subjectName"] ==
                                  'انجليزي') {
                                print("englishhhhhhhhhhhhhhhhhhhhh");
                                i = "number.png";
                              }
                              if (index == 0) {
                                return Column(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 15,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.91,
                                            child: DefaultTextStyle(
                                              style:
                                                  // fontSize: 20.0,
                                                  // color: Colors.black,
                                                  // fontWeight: FontWeight.bold,
                                                  GoogleFonts.amiri(
                                                color: Colors.red,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              child: AnimatedTextKit(
                                                repeatForever: true,
                                                animatedTexts: [
                                                  FadeAnimatedText(
                                                      '.. أحدث الإشعارات',
                                                      textAlign:
                                                          TextAlign.right),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // SizedBox(width: 15),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      // margin: const EdgeInsets.all(15.0),
                                                      width: 80,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10,
                                                              top: 8,
                                                              bottom: 8),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.blueGrey,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20.0) //                 <--- border radius here
                                                                  ),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .blueGrey)),
                                                      child: Text(
                                                          '${snapshot.data.documents[index]["timestamp"]}',
                                                          style:
                                                              GoogleFonts.amiri(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 8)),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        width:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.5,
                                                        child: Text(
                                                            '${snapshot.data.documents[index]["content"]}',
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            style: GoogleFonts
                                                                .amiri(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontSize:
                                                                        18))),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5,
                                                              left: 5),
                                                      child: Container(
                                                        width: 90,
                                                        height: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                'assets/images/$i'),
                                                            fit: BoxFit.fill,
                                                          ),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            elevation: 5,
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              } else
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.white70, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: 80,

                                                  // margin: const EdgeInsets.all(15.0),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 8,
                                                          bottom: 8),
                                                  decoration: BoxDecoration(
                                                      color: Colors.blueGrey,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0) //                 <--- border radius here
                                                              ),
                                                      border: Border.all(
                                                          color:
                                                              Colors.blueGrey)),
                                                  child: Text(
                                                      '${snapshot.data.documents[index]["timestamp"]}',
                                                      style: GoogleFonts.amiri(
                                                          color: Colors.white,
                                                          fontSize: 8)),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    child: Text(
                                                        '${snapshot.data.documents[index]["content"]}',
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style:
                                                            GoogleFonts.amiri(
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 18))),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5, left: 5),
                                                  child: Container(
                                                    width: 90,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/$i'),
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
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                );
                            },
                            childCount: snapshot.data.documents.length,
                          ),
                        )
                      ]),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
                child: SizedBox(
              height: 36,
              width: 36,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ));
          }
        },
      ),
    );
  }
}
