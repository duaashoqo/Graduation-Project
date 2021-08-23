import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'E_type1.dart';
import 'E_type2.dart';
import 'E_type3.dart';
import 'LessonAndExersize.dart';
import 'ip_address.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

class AllVideo extends StatefulWidget {
  String title;
  List<dynamic> videos;
  String sub_name;
  String class_name;
  String id;
  var count_veiwer_letters;
  List<dynamic> exersizesLetters;
  List<int> exersizesType;

  AllVideo(
      {key,
      this.title,
      this.videos,
      this.sub_name,
      this.class_name,
      this.id,
      this.count_veiwer_letters,
      this.exersizesLetters,
      this.exersizesType})
      : super(key: key);

  @override
  _AllVideoState createState() => _AllVideoState();
}

class _AllVideoState extends State<AllVideo> {
  List<dynamic> videos = [];
  @override
  Widget build(BuildContext context) {
    print("duaa");
    print(widget.videos);
    // print(excersize_type);
    List<Color> color = [
      Colors.pink[400],
      Colors.lime,
    ];
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
              size: 18,
            ),
            onPressed: () {
              var route = new MaterialPageRoute(
                  builder: (BuildContext context) => new LessonAndExersize(
                        count_veiwer_letters: widget.count_veiwer_letters,
                        className: widget.class_name,
                        id: widget.id,
                        title: widget.title,
                        sub_name: widget.sub_name,
                        videos: widget.videos,
                        exersizesLetters: widget.exersizesLetters,
                        exersizesType: widget.exersizesType,
                      ));
              Navigator.of(context).push(route);
            }),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                widget.title,
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("assets/images/sky.jpg"),
                    fit: BoxFit.fill)),
            // alignment: Alignment.bottomCenter,
            // padding: EdgeInsets.only(bottom: 150.0),
          ),
          Container(
            // 80cce6
            color: Color.fromRGBO(80, 0xcc, 0xe6, 0.6),
            // alignment: Alignment.bottomCenter,
            // padding: EdgeInsets.only(left: 10, right: 10),
            margin: EdgeInsets.only(left: 10, right: 10),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          CustomScrollView(slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SizedBox(
                                //     width: MediaQuery.of(context).size.width *
                                //         0.07),
                                Text(
                                  " الفيــديـوهـات الـمضـــافـــة ",
                                  style: GoogleFonts.amiri(
                                    // decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                ),
                                // SizedBox(
                                //     width: MediaQuery.of(context).size.width *
                                //         0.22),
                              ],
                            ),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Divider(
                                      height: 5,
                                      thickness: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13, right: 13),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.11,
                            width: MediaQuery.of(context).size.width * 1,
                            child: InkWell(
                              onTap: () {},
                              child: Card(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        PopupMenuButton(
                                            icon: const Icon(Icons.more_horiz,
                                                color: Colors.black87),
                                            enabled: true,
                                            onSelected: (value) {},
                                            tooltip: 'المزيد',
                                            itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    child: InkWell(
                                                      onTap: () {
                                                        // var route =
                                                        //     new MaterialPageRoute(
                                                        //   builder: (BuildContext
                                                        //           context) =>
                                                        //       new newLesson
                                                        //           .fromnewLesson(
                                                        //     title: widget.title,
                                                        //     sub: widget.sub_name,
                                                        //     calssName:
                                                        //         widget.className,
                                                        //     videoName: widget.videos[
                                                        //         widget.videos.length -
                                                        //             1],
                                                        //     flag: true,
                                                        //   ),
                                                        // );
                                                        // Navigator.of(context)
                                                        //     .push(route);
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(Icons
                                                                  .mode_edit)),
                                                          Text(
                                                            "تعديل الدرس",
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    value: 1,
                                                  ),
                                                  PopupMenuItem(
                                                    child: InkWell(
                                                      onTap: () {
                                                        // widget.videos.length - 1
                                                        deleteSubjectVideo(
                                                            widget
                                                                .videos[index],
                                                            widget.sub_name,
                                                            widget.class_name);
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(Icons
                                                                  .delete)),
                                                          Text(
                                                            "حذف الدرس",
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    value: 2,
                                                  ),
                                                ]),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            child: Text(widget.videos[index],
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: GoogleFonts.markaziText(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 24))),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 0, left: 10),
                                          child: Container(
                                              width: 70,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    (index + 1).toString(),
                                                    style:
                                                        GoogleFonts.markaziText(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 45),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              decoration: index % 2 == 0
                                                  ? BoxDecoration(
                                                      color: color[0],
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2),
                                                    )
                                                  : BoxDecoration(
                                                      color: color[1],
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2),
                                                    )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                elevation: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width * 1,
                        child: InkWell(
                          onTap: () {},
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    PopupMenuButton(
                                        icon: const Icon(Icons.more_horiz,
                                            color: Colors.black87),
                                        enabled: true,
                                        onSelected: (value) {},
                                        tooltip: 'المزيد',
                                        itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: InkWell(
                                                  onTap: () {
                                                    // var route =
                                                    //     new MaterialPageRoute(
                                                    //   builder: (BuildContext
                                                    //           context) =>
                                                    //       new newLesson
                                                    //           .fromnewLesson(
                                                    //     title: widget.title,
                                                    //     sub: widget.sub_name,
                                                    //     calssName:
                                                    //         widget.className,
                                                    //     videoName: widget.videos[
                                                    //         widget.videos.length -
                                                    //             1],
                                                    //     flag: true,
                                                    //   ),
                                                    // );
                                                    // Navigator.of(context)
                                                    //     .push(route);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                              Icons.mode_edit)),
                                                      Text(
                                                        "تعديل الدرس",
                                                        textDirection:
                                                            TextDirection.rtl,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                value: 1,
                                              ),
                                              PopupMenuItem(
                                                child: InkWell(
                                                  onTap: () {
                                                    // widget.videos.length - 1
                                                    deleteSubjectVideo(
                                                        widget.videos[index],
                                                        widget.sub_name,
                                                        widget.class_name);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                              Icons.delete)),
                                                      Text(
                                                        "حذف الدرس",
                                                        textDirection:
                                                            TextDirection.rtl,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                value: 2,
                                              ),
                                            ]),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Text(widget.videos[index],
                                            textDirection: TextDirection.rtl,
                                            style: GoogleFonts.markaziText(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 24))),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, left: 10),
                                      child: Container(
                                          width: 70,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                (index + 1).toString(),
                                                style: GoogleFonts.markaziText(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 45),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          decoration: index % 2 == 0
                                              ? BoxDecoration(
                                                  color: color[0],
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                )
                                              : BoxDecoration(
                                                  color: color[1],
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            elevation: 5,
                          ),
                        ),
                      ),
                    );
                  }
                },
                childCount: widget.videos.length,
              ),
            )
          ]),
          widget.videos.length == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //     width: MediaQuery.of(context).size.width *
                        //         0.07),
                        Text(
                          " الفيــديـوهـات الـمضـــافـــة ",
                          style: GoogleFonts.amiri(
                            // decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                        // SizedBox(
                        //     width: MediaQuery.of(context).size.width *
                        //         0.22),
                      ],
                    ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Divider(
                              height: 5,
                              thickness: 2,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      child: Text(
                        "لا يـوجـد دروس مضــافـة",
                        style: GoogleFonts.amiri(
                          // decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              : SizedBox(height: 0)
        ],
      ),
    );
  }

  Future<void> deleteSubjectVideo(
      String title, String sub_name, String class_name) async {
    String apiUrl;

    var response;
    apiUrl = '${IP}deleteSubjectVideo';
    response = await http.post(Uri.parse(apiUrl),
        body: {"title": title, "class_name": class_name});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {}
    }

    await getSubjectVideos(sub_name, class_name);
  }

  Future getSubjectVideos(String subject, String class_name) async {
    videos = [];
    final String apiUrl = '${IP}getSubjectVideos';
    final response = await http.post(Uri.parse(apiUrl),
        body: {"subject_name": subject, "class_name": class_name});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'][0]['vid'] != '') {
          for (int i = 0; i < decoded['response'].length; i++) {
            videos.add(decoded['response'][i]['vid']);
          }
        }

        print(videos);
        setState(() {
          widget.videos = videos;
        });
      }
    }
  }
}
