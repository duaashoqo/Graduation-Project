import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'AllLetter.dart';
import 'AllVideo.dart';
import 'LetterExcersize.dart';
import 'NewLesson.dart';
import 'TeacherChildProgress.dart';
import 'custom_fab_page.dart';
import 'ip_address.dart';
import 'newLissonOrExc.dart';

class LessonAndExersize extends StatefulWidget {
  var count_veiwer_letters;
  String className;
  String id;
  String title;
  String sub_name;
  List<dynamic> videos;

  // List<dynamic> exersizes;
  List<dynamic> exersizesLetters;
  List<int> exersizesType;

  LessonAndExersize(
      {key,
      this.count_veiwer_letters,
      this.className,
      this.id,
      this.title,
      this.sub_name,
      this.videos,
      // this.exersizes,
      this.exersizesLetters,
      this.exersizesType})
      : super(key: key);

  @override
  LessonAndExersizeState createState() => LessonAndExersizeState();
}

class LessonAndExersizeState extends State<LessonAndExersize> {
  int _value;
  List Letter_arabic = [
    'أ',
    'ب',
    'ت',
    'ث',
    'ج',
    'ح',
    'خ',
    'د',
    'ذ',
    'ر',
    'ز',
    'س',
    'ش',
    'ص',
    'ض',
    'ط',
    'ظ',
    'ع',
    'غ',
    'ف',
    'ق',
    'ك',
    'ل',
    'م',
    'ن',
    'ه',
    'و',
    'ي'
  ];
  List Letter_arabic_word = [
    'حرف الألف',
    'حرف الباء',
    'حرف التاء',
    'حرف الثاء',
    'حرف الجيم',
    'حرف الحاء',
    'حرف الخاء',
    'حرف الدال',
    'حرف الذال',
    'حرف الراء',
    'حرف الزاي',
    'حرف السين',
    'حرف الشين',
    'حرف الصاد',
    'حرف الضاد',
    'حرف الطاء',
    'حرف الظاء',
    'حرف العين',
    'حرف الغين',
    'حرف الفاء',
    'حرف القاف',
    'حرف الكاف',
    'حرف اللام',
    'حرف الميم',
    'حرف النون',
    'حرف الهاء',
    'حرف الواو',
    'حرف الياء'
  ];
  List Letter_english = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'G',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];
  List Letter_english_word = [
    ' حرف A ',
    ' حرف B  ',
    ' حرف C  ',
    ' حرف D  ',
    ' حرف E  ',
    ' حرف F  ',
    ' حرف G  ',
    ' حرف H  ',
    ' حرف I  ',
    ' حرف J  ',
    ' حرف K  ',
    ' حرف L  ',
    ' حرف M  ',
    ' حرف N  ',
    ' حرف O  ',
    ' حرف P  ',
    ' حرف Q  ',
    ' حرف R  ',
    ' حرف S  ',
    ' حرف T  ',
    ' حرف U  ',
    ' حرف V  ',
    ' حرف W  ',
    ' حرف X  ',
    ' حرف Y  ',
    ' حرف Z  ',
  ];

  List number = [
    '۱',
    '۲',
    '۳',
    '٤',
    '٥',
    '٦',
    '٧',
    '۸',
    '۹',
  ];
  List number_name = [
    'العدد ۱',
    '۲ العدد',
    '۳ العدد',
    'العدد ٤',
    'العدد ٥',
    'العدد ٦',
    'العدد ٧',
    'العدد ۸',
    'العدد ۹',
  ];
  List<dynamic> excersizesName = [];
  List<dynamic> excersizesAnswer = [];
  List<dynamic> childsCode = [];
  List<dynamic> childsFlag1 = [];
  List<dynamic> childsFlag2 = [];
  List<dynamic> childsFlag3 = [];
  List<dynamic> childsName = [];
  List<dynamic> AllchildsName = [];
  List<dynamic> videos = [];
  List<int> excersize_type = [];
  List<dynamic> choice1 = [];
  List<dynamic> choice2 = [];

  List<dynamic> choice3 = [];
  List<dynamic> word = [];
  List<dynamic> name_of_image1 = [];
  List<String> numbers = [];

  @override
  Widget build(BuildContext context) {
    String LastLesson = '${widget.videos.length}';
    String LastLesson2 = '${widget.videos.length - 1}';
    String LastLetter;
    String LastLetter2;
    String LastImage;
    String LastImage2;
    String Last_element;
    String Last_element2;
    int num_veiwer;
    int num_veiwer2;
    int count = 0;
    if (widget.sub_name == 'عربي' && widget.exersizesLetters.length != 0) {
      count = 28;
    } else if (widget.sub_name == 'انجليزي' &&
        widget.exersizesLetters.length != 0) {
      count = 26;
    } else if (widget.sub_name == 'رياضيات' &&
        widget.exersizesLetters.length != 0) {
      count = 9;
    }
    bool flag = false;

    for (int i = 0; i < count; i++) {
      if (widget.sub_name == 'عربي') {
        if (widget.exersizesLetters.length > 0 && !flag) {
          if (Letter_arabic[i] ==
              widget.exersizesLetters[widget.exersizesLetters.length - 1]) {
            LastLetter = Letter_arabic_word[i];
            LastImage =
                widget.exersizesLetters[widget.exersizesLetters.length - 1];

            i = 0;
            flag = true;
          }
        }

        if (flag) {
          if (Letter_arabic[i] ==
              widget.exersizesLetters[widget.exersizesLetters.length - 2]) {
            LastLetter2 = Letter_arabic_word[i];
            LastImage2 =
                widget.exersizesLetters[widget.exersizesLetters.length - 2];

            break;
          }
        }
      } else if (widget.sub_name == 'انجليزي') {
        if (widget.exersizesLetters.length > 0 && !flag) {
          if (Letter_english[i] ==
              widget.exersizesLetters[widget.exersizesLetters.length - 1]) {
            LastLetter = Letter_english_word[i];
            LastImage =
                widget.exersizesLetters[widget.exersizesLetters.length - 1];
            i = 0;

            flag = true;
          }
        }

        if (flag) {
          if (Letter_english[i] ==
              widget.exersizesLetters[widget.exersizesLetters.length - 2]) {
            LastLetter2 = Letter_english_word[i];
            LastImage2 =
                widget.exersizesLetters[widget.exersizesLetters.length - 2];
            break;
          }
        }
      } else if (widget.sub_name == 'رياضيات') {
        LastImage = widget.exersizesLetters[widget.exersizesLetters.length - 1];
        LastImage2 =
            widget.exersizesLetters[widget.exersizesLetters.length - 2];
        break;
      }
    }
    if (widget.exersizesLetters.length > 0) {
      Last_element =
          widget.exersizesLetters[widget.exersizesLetters.length - 1];
    }
    if (widget.exersizesLetters.length > 1) {
      Last_element2 =
          widget.exersizesLetters[widget.exersizesLetters.length - 2];
    }

    if (widget.count_veiwer_letters[Last_element] != null) {
      num_veiwer = widget.count_veiwer_letters[Last_element];
    } else {
      // print("allllaaaa");
      num_veiwer = 0;
    }
    if (widget.count_veiwer_letters[Last_element2] != null) {
      num_veiwer2 = widget.count_veiwer_letters[Last_element2];
    } else {
      num_veiwer2 = 0;
    }
    print("videooosss");
    print(widget.videos);
    return Scaffold(
      appBar: AppBar(
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
          ),
          Container(
            // 80cce6
            color: Color.fromRGBO(80, 0xcc, 0xe6, 0.6),

            margin: EdgeInsets.only(left: 10, right: 10),
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        iconSize: 18,
                        tooltip: 'جميع الدروس',
                        onPressed: () async {
                          //go to all lesson page

                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new AllVideo(
                                title: widget.title,
                                videos: widget.videos,
                                sub_name: widget.sub_name,
                                class_name: widget.className,
                                id: widget.id,
                                count_veiwer_letters:
                                    widget.count_veiwer_letters,
                                exersizesLetters: widget.exersizesLetters,
                                exersizesType: widget.exersizesType),
                          );
                          Navigator.of(context).push(route);
                        },
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                      Text(
                        " آخـــر الــــدروس الـمضـــافـــة",
                        style: GoogleFonts.amiri(
                          // decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.22),
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
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              widget.videos.length - 1 >= 0
                  ? Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.11,
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
                                      onSelected: (value) {
                                        setState(() {
                                          _value = value;
                                        });
                                        // print(_value);
                                      },
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
                                                      MainAxisAlignment.center,
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
                                                      widget.videos[
                                                          widget.videos.length -
                                                              1],
                                                      widget.sub_name,
                                                      widget.className);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon:
                                                            Icon(Icons.delete)),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                          widget
                                              .videos[widget.videos.length - 1],
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
                                            LastLesson,
                                            style: GoogleFonts.markaziText(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 45),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      decoration: BoxDecoration(
                                        color: Colors.pink[400],
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          elevation: 5,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              widget.videos.length - 2 >= 0
                  ? Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.11,
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
                                      onSelected: (value) {
                                        setState(() {
                                          _value = value;
                                        });
                                        // print(_value);
                                      },
                                      tooltip: 'المزيد',
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: InkWell(
                                                onTap: () {
                                                  // var route =
                                                  //     new MaterialPageRoute(
                                                  //   builder: (BuildContext
                                                  //           context) =>
                                                  //       new newLesson.fromnewLesson(
                                                  //           title: widget.title,
                                                  //           sub:
                                                  //               widget.sub_name,
                                                  //           calssName: widget
                                                  //               .className,
                                                  //           videoName: widget
                                                  //               .videos[widget
                                                  //                   .videos
                                                  //                   .length -
                                                  //               2],
                                                  //           flag: true),
                                                  // );
                                                  // Navigator.of(context)
                                                  //     .push(route);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                  deleteSubjectVideo(
                                                      widget.videos[
                                                          widget.videos.length -
                                                              2],
                                                      widget.sub_name,
                                                      widget.className);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon:
                                                            Icon(Icons.delete)),
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
                                  // Column(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     SizedBox(height: 10),
                                  //     SizedBox(
                                  //       height: 20,
                                  //       child: IconButton(
                                  //         icon: const Icon(
                                  //           Icons.remove_red_eye,
                                  //           color: Colors.black87,
                                  //         ),
                                  //         color: Colors.black,
                                  //         tooltip: 'المشاهدون',
                                  //       ),
                                  //     ),
                                  //     SizedBox(height: 10),
                                  //     SizedBox(height: 20, child: Text("1"))
                                  //   ],
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                          widget
                                              .videos[widget.videos.length - 2],
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
                                            LastLesson2,
                                            style: GoogleFonts.markaziText(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 45),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      decoration: BoxDecoration(
                                        color: Colors.lime,
                                        border: Border.all(
                                            color: Colors.white, width: 2),

                                        // image: DecorationImage(
                                        //   image: AssetImage(
                                        //       'assets/images/apple.jpg'),
                                        //   fit: BoxFit.fill,
                                        // ),
                                        // shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          elevation: 5,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              widget.videos.length == 0
                  ? SizedBox(
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
                  : SizedBox(
                      height: 0,
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        iconSize: 18,
                        tooltip: 'جميع التمارين',
                        onPressed: () async {
                          print("From on press");
                          print(widget.videos);
                          // AllLetter
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new AllLetter(
                              count_veiwer_letters: widget.count_veiwer_letters,
                              id: widget.id,
                              title: widget.title,
                              letters: widget.exersizesLetters,
                              sub_name: widget.sub_name,
                              class_name: widget.className,
                              excersize_type: excersize_type,
                              excersizesName: excersizesName,
                              excersizesAnswer: excersizesAnswer,
                              choice1: choice1,
                              choice2: choice2,
                              choice3: choice3,
                              name_of_image: name_of_image1,
                              word: word,
                              videos: widget.videos,
                            ),
                          );
                          Navigator.of(context).push(route);
                        },
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                      Text(
                        "آخـــر التـمــاريــن الـمضـــافـــة ",
                        style: GoogleFonts.amiri(
                          // decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.22),
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
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              widget.exersizesLetters.length - 1 >= 0
                  ? Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.11,
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
                                      onSelected: (value) {
                                        setState(() {
                                          _value = value;
                                        });
                                        // print(_value);
                                      },
                                      tooltip: 'المزيد',
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: InkWell(
                                                onTap: () async {
                                                  await getLetterExersize(
                                                      widget.exersizesLetters[
                                                          widget.exersizesLetters
                                                                  .length -
                                                              1],
                                                      widget.className);
                                                  // print("Letter e");
                                                  // print(excersizesName);
                                                  // print(excersize_type);
                                                  // print(excersizesAnswer);
                                                  if (widget.sub_name ==
                                                      'رياضيات') {
                                                    LastLetter = "العدد" +
                                                        widget.exersizesLetters[
                                                            widget.exersizesLetters
                                                                    .length -
                                                                1];
                                                  }

                                                  var route =
                                                      new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        new letterExcersize(
                                                            title: widget.title +
                                                                '-' +
                                                                LastLetter,
                                                            letter: widget
                                                                    .exersizesLetters[
                                                                widget.exersizesLetters
                                                                        .length -
                                                                    1],
                                                            excersize_type:
                                                                excersize_type,
                                                            excersizesName:
                                                                excersizesName,
                                                            excersizesAnswer:
                                                                excersizesAnswer,
                                                            choice1: choice1,
                                                            choice2: choice2,
                                                            choice3: choice3,
                                                            name_of_image:
                                                                name_of_image1,
                                                            word: word,
                                                            sub_name:
                                                                widget.sub_name,
                                                            class_name: widget
                                                                .className),
                                                  );
                                                  Navigator.of(context)
                                                      .push(route);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                            Icons.mode_edit)),
                                                    Text(
                                                      "تعديل الحرف",
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              value: widget.exersizesType[
                                                  widget.exersizesType.length -
                                                      1],
                                            ),
                                            PopupMenuItem(
                                              child: InkWell(
                                                onTap: () {
                                                  deleteSubjectLetter(
                                                      widget.sub_name,
                                                      widget.exersizesLetters[
                                                          widget.exersizesLetters
                                                                  .length -
                                                              1],
                                                      widget.className,
                                                      widget.id);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon:
                                                            Icon(Icons.delete)),
                                                    Text(
                                                      "حذف الحرف",
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              value: widget.exersizesType[
                                                  widget.exersizesType.length -
                                                      1],
                                            ),
                                          ]),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10),
                                      SizedBox(
                                        height: 20,
                                        child: IconButton(
                                          onPressed: () async {
                                            await getChildProgress(
                                                widget.id,
                                                widget.exersizesLetters[widget
                                                        .exersizesLetters
                                                        .length -
                                                    1],
                                                widget.className);
                                            var route = new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new TeacherChildProgress(
                                                      title: widget.title +
                                                          '-' +
                                                          'مستوى الطلاب',
                                                      childsName: childsName,
                                                      childsFlag1: childsFlag1,
                                                      childsFlag2: childsFlag2,
                                                      childsFlag3: childsFlag3),
                                            );
                                            Navigator.of(context).push(route);
                                          },
                                          icon: const Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.black87,
                                          ),
                                          color: Colors.black,
                                          tooltip: 'المشاهدون',
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                          height: 20,
                                          child: Text(num_veiwer.toString()))
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: widget.sub_name == 'رياضيات'
                                          ? Text(
                                              "العدد " +
                                                  widget.exersizesLetters[widget
                                                          .exersizesLetters
                                                          .length -
                                                      1],
                                              textDirection: TextDirection.rtl,
                                              style: GoogleFonts.markaziText(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 24))
                                          : Text(LastLetter,
                                              textDirection: TextDirection.rtl,
                                              style: GoogleFonts.markaziText(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 24))),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 2, left: 10),
                                    child: Container(
                                      width: 65,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                              width: 2.0, color: Colors.white),
                                        ),

                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/${LastImage}.jpg'),
                                          fit: BoxFit.fill,
                                        ),
                                        // shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          elevation: 5,
                        ),
                      ),
                    )
                  : SizedBox(height: 0),
              widget.exersizesLetters.length - 2 >= 0
                  ? Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.11,
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
                                      onSelected: (value) {
                                        setState(() {
                                          _value = value;
                                        });
                                        // print(_value);
                                      },
                                      tooltip: 'المزيد',
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: InkWell(
                                                onTap: () async {
                                                  if (widget.sub_name ==
                                                      'رياضيات') {
                                                    LastLetter2 = "العدد" +
                                                        widget.exersizesLetters[
                                                            widget.exersizesLetters
                                                                    .length -
                                                                2];
                                                  }
                                                  await getLetterExersize(
                                                      widget.exersizesLetters[
                                                          widget.exersizesLetters
                                                                  .length -
                                                              2],
                                                      widget.className);
                                                  var route =
                                                      new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        new letterExcersize(
                                                            title: widget.title +
                                                                '-' +
                                                                LastLetter2,
                                                            letter: widget
                                                                    .exersizesLetters[
                                                                widget.exersizesLetters
                                                                        .length -
                                                                    1],
                                                            excersize_type:
                                                                excersize_type,
                                                            excersizesName:
                                                                excersizesName,
                                                            excersizesAnswer:
                                                                excersizesAnswer,
                                                            choice1: choice1,
                                                            choice2: choice2,
                                                            choice3: choice3,
                                                            name_of_image:
                                                                name_of_image1,
                                                            word: word,
                                                            sub_name:
                                                                widget.sub_name,
                                                            class_name: widget
                                                                .className),
                                                  );
                                                  Navigator.of(context)
                                                      .push(route);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                            Icons.mode_edit)),
                                                    Text(
                                                      "تعديل الحرف",
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              value: widget.exersizesType[
                                                  widget.exersizesType.length -
                                                      1],
                                            ),
                                            PopupMenuItem(
                                              child: InkWell(
                                                onTap: () {
                                                  // deleteSubjectExersize(
                                                  //     widget.exersizesType[
                                                  //         widget.exersizesType
                                                  //                 .length -
                                                  //             2],
                                                  //     widget.sub_name,
                                                  //     widget.exersizes[widget
                                                  //             .exersizes
                                                  //             .length -
                                                  //         2]);
                                                  deleteSubjectLetter(
                                                      widget.sub_name,
                                                      widget.exersizesLetters[
                                                          widget.exersizesLetters
                                                                  .length -
                                                              1],
                                                      widget.className,
                                                      widget.id);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon:
                                                            Icon(Icons.delete)),
                                                    Text(
                                                      "حذف الحرف",
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              value: widget.exersizesType[
                                                  widget.exersizesType.length -
                                                      2],
                                            ),
                                          ]),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10),
                                      SizedBox(
                                        height: 20,
                                        child: IconButton(
                                          onPressed: () async {
                                            await getChildProgress(
                                                widget.id,
                                                widget.exersizesLetters[widget
                                                        .exersizesLetters
                                                        .length -
                                                    1],
                                                widget.className);
                                            var route = new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new TeacherChildProgress(
                                                      title: widget.title +
                                                          '-' +
                                                          'مستوى الطلاب',
                                                      childsName: childsName,
                                                      childsFlag1: childsFlag1,
                                                      childsFlag2: childsFlag2,
                                                      childsFlag3: childsFlag3),
                                            );
                                            Navigator.of(context).push(route);
                                          },
                                          icon: const Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.black87,
                                          ),
                                          color: Colors.black,
                                          tooltip: 'المشاهدون',
                                          // onPressed: () async {
                                          //   await getParentNamee(students[index]);
                                          //   Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(
                                          //           builder: (context) => ChatPage(
                                          //               id: id,
                                          //               stu_name: students[index],
                                          //               Pname: Pname)));
                                          // },
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                          height: 20,
                                          child: Text(num_veiwer2.toString()))
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: widget.sub_name == 'رياضيات'
                                          ? Text(
                                              "العدد" +
                                                  widget.exersizesLetters[widget
                                                          .exersizesLetters
                                                          .length -
                                                      2],
                                              textDirection: TextDirection.rtl,
                                              style: GoogleFonts.markaziText(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 24))
                                          : Text(LastLetter2,
                                              textDirection: TextDirection.rtl,
                                              style: GoogleFonts.markaziText(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 24))),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 2, left: 10),
                                    child: Container(
                                      width: 65,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,

                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),

                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/${LastImage2}.jpg'),
                                          fit: BoxFit.fill,
                                        ),
                                        // shape: BoxShape.circle,
                                      ),
                                      // decoration: BoxDecoration(
                                      //     color: color,
                                      //     borderRadius: BorderRadius.all(
                                      //         Radius.circular(70))),

                                      // child: Expanded(
                                      //   child: FittedBox(
                                      //     fit: BoxFit.fill,
                                      //     child: IconButton(
                                      //       icon: const Icon(Icons.account_circle),
                                      //       color: Colors.white,
                                      //       iconSize: 2000,
                                      //       tooltip: 'Profile',
                                      //       onPressed: () {},
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          elevation: 5,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              widget.exersizesLetters.length == 0
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      child: Text(
                        "لا يـوجـد تمارين مضــافـة",
                        style: GoogleFonts.amiri(
                          // decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              Padding(
                padding: const EdgeInsets.only(right: 50, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "إضــافة جــديـدة",
                      style: GoogleFonts.markaziText(
                        // decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 25,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomFABWidget(
                        transitionType: ContainerTransitionType.fade,
                        title: widget.title,
                        class_name: widget.sub_name,
                        calssName: widget.className,
                        flag: false),
                    // FloatingActionButton(
                    //   child: Icon(Icons.add),
                    //   backgroundColor: Colors.green,
                    //   onPressed: () {
                    //     var route = new MaterialPageRoute(
                    //       builder: (BuildContext context) =>
                    //           new NewLessonOrExersize(
                    //         title: widget.title,
                    //         class_name: widget.sub_name,
                    //         calssName: widget.className,
                    //         flag: false,
                    //       ),
                    //     );
                    //     Navigator.of(context).push(route);
                    //   },
                    // ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> deleteSubjectLetter(String sub_name, String answer,
      String class_name, String teacher_id) async {
    String apiUrl;
    String teacher_name;

    var response;
    apiUrl = '${IP}deleteSubjectExersize1';
    response = await http.post(Uri.parse(apiUrl), body: {
      "subject_name": sub_name,
      "answer": answer,
      "class_name": class_name
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        print("deleted 1");
        print("after delet1e");
      }
    }

    apiUrl = '${IP}deleteSubjectExersize2';
    response = await http.post(Uri.parse(apiUrl), body: {
      "subject_name": sub_name,
      "answer": answer,
      "class_name": class_name
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        print("after delet2e");
      }
    }

    apiUrl = '${IP}deleteSubjectExersize3';
    response = await http.post(Uri.parse(apiUrl), body: {
      "subject_name": sub_name,
      "answer": answer,
      "class_name": class_name
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        print("deleted 3");
        print("after delete3");
      }
    }
    apiUrl = '${IP}getTeacherNamee';
    response = await http.post(Uri.parse(apiUrl), body: {"id": teacher_id});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'][0]['name'] != []) {
          teacher_name = decoded['response'][0]['name'];
        }
      }
    }
    print("Teacher name");
    print(teacher_name);

    apiUrl = '${IP}deleteLetterProgress';
    print("ddddddddddddddd");
    response = await http.post(Uri.parse(apiUrl), body: {
      "teacher_name": teacher_name,
      "answer": answer,
    });
    print("ssssssssssssss");

    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        print("deleted 4");
        print("after delete4");
      }
    }

    await getSubjectExersizes(sub_name, class_name);
  }

  Future getSubjectExersizes(String subject, String class_name) async {
    excersizesName = [];
    excersizesAnswer = [];
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
            excersizesName.add(decoded['response'][i]['title']);
            excersizesAnswer.add(decoded['response'][i]['answer']);
          }
        }
        setState(() {
          widget.exersizesLetters = excersizesAnswer;
        });
      }
    }
    // apiUrl = '${IP}getSubjectExersizes2';
    // response =
    //     await http.post(Uri.parse(apiUrl), body: {"subject_name": subject});
    // if (response.statusCode == 200) {
    //   final String responseString = response.body;
    //   if (responseString == "NO") {
    //     // state2 = "1";
    //   } else {
    //     Map decoded = json.decode(response.body) as Map<String, dynamic>;
    //     print(decoded['response']);
    //     if (decoded['response'][0]['type'] == 2) {
    //       for (int i = 0; i < decoded['response'].length; i++) {
    //         subjectExersizes.add(decoded['response'][i]['title']);
    //         subjectExersizeLetters.add(decoded['response'][i]['answer']);
    //         excersizesType.add(decoded['response'][i]['type']);
    //       }
    //     }
    //   }
    // }
    // apiUrl = '${IP}getSubjectExersizes3';
    // response =
    //     await http.post(Uri.parse(apiUrl), body: {"subject_name": subject});
    // if (response.statusCode == 200) {
    //   final String responseString = response.body;
    //   if (responseString == "NO") {
    //     // state2 = "1";
    //   } else {
    //     Map decoded = json.decode(response.body) as Map<String, dynamic>;
    //     print(decoded['response']);
    //     if (decoded['response'][0]['type'] == 3) {
    //       for (int i = 0; i < decoded['response'].length; i++) {
    //         subjectExersizes.add(decoded['response'][i]['title']);
    //         subjectExersizeLetters.add(decoded['response'][i]['answer']);
    //         excersizesType.add(decoded['response'][i]['type']);
    //       }
    //     }
    //   }
    // }
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

  Future<void> getLetterExersize(String answer, String class_name) async {
    excersizesName = [];
    excersizesAnswer = [];
    excersize_type = [];

    String apiUrl = '${IP}getLetterExersize1';
    Response response = await http.post(Uri.parse(apiUrl),
        body: {"answer": answer, "class_name": class_name});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'][0]['answer'] != '') {
          for (int i = 0; i < decoded['response'].length; i++) {
            excersizesAnswer.add(decoded['response'][i]['answer']);
            excersizesName.add(decoded['response'][i]['title']);
            choice1.add(decoded['response'][i]['choice1']);
            choice2.add(decoded['response'][i]['choice2']);
            choice3.add(decoded['response'][i]['choice3']);
            name_of_image1.add(decoded['response'][i]['name_of_image1']);
            word.add(decoded['response'][i]['word']);
          }
          excersize_type.add(1);
        }
      }
    }

    apiUrl = '${IP}getLetterExersize2';
    response = await http.post(Uri.parse(apiUrl),
        body: {"answer": answer, "class_name": class_name});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'][0]['answer'] != '') {
          for (int i = 0; i < decoded['response'].length; i++) {
            excersizesAnswer.add(decoded['response'][i]['answer']);
            excersizesName.add(decoded['response'][i]['title']);
            choice1.add('');
            choice2.add('');
            choice3.add('');
            name_of_image1.add(decoded['response'][i]['name_of_image1']);
            word.add(decoded['response'][i]['word']);
          }
          excersize_type.add(2);
        }
      }
    }

    apiUrl = '${IP}getLetterExersize3';
    response = await http.post(Uri.parse(apiUrl),
        body: {"answer": answer, "class_name": class_name});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'][0]['answer'] != '') {
          for (int i = 0; i < decoded['response'].length; i++) {
            excersizesAnswer.add(decoded['response'][i]['answer']);
            excersizesName.add(decoded['response'][i]['title']);
            choice1.add('');
            choice2.add('');
            choice3.add('');
            name_of_image1.add(decoded['response'][i]['name_of_image1']);
            word.add(decoded['response'][i]['word']);
          }
          excersize_type.add(3);
        }
      }
    }
  }

  getChildProgress(String teacher_id, String symbol, String class_name) async {
    String apiUrl;
    String teacher_name;
    childsCode = [];
    childsFlag1 = [];
    childsFlag2 = [];
    childsFlag3 = [];
    childsName = [];
    AllchildsName = [];

    var response;
    apiUrl = '${IP}getTeacherNamee';
    response = await http.post(Uri.parse(apiUrl), body: {"id": teacher_id});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'][0]['name'] != []) {
          teacher_name = decoded['response'][0]['name'];
        }
      }
    }
    print("Teacher name");
    print(teacher_name);

    apiUrl = '${IP}getChildProgress';
    response = await http.post(Uri.parse(apiUrl),
        body: {"teacher_name": teacher_name, "symbol": symbol});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'][0]['symbol'] != '') {
          for (int i = 0; i < decoded['response'].length; i++) {
            childsCode.add(decoded['response'][i]['code']);
            childsFlag1.add(decoded['response'][i]['flag1']);
            childsFlag2.add(decoded['response'][i]['flag2']);
            childsFlag3.add(decoded['response'][i]['flag3']);
          }
        }
      }
    }

    print("child code");
    print(childsCode);
    print("childsFlag1");
    print(childsFlag1);
    print("childsFlag2");
    print(childsFlag2);
    print("childsFlag3");
    print(childsFlag3);

    apiUrl = '${IP}nameOfChild';
    for (int i = 0; i < childsCode.length; i++) {
      response =
          await http.post(Uri.parse(apiUrl), body: {"code": childsCode[i]});
      if (response.statusCode == 200) {
        final String responseString = response.body;
        if (responseString == "NO") {
          // state2 = "1";
        } else {
          Map decoded = json.decode(response.body) as Map<String, dynamic>;
          if (decoded['response'][0]['name'] != '') {
            childsName.add(decoded['response'][0]['name']);
          }
        }
      }

      apiUrl = '${IP}getStudent';
      response =
          await http.post(Uri.parse(apiUrl), body: {"class_name": class_name});
      if (response.statusCode == 200) {
        final String responseString = response.body;
        if (responseString == "NO") {
          // state2 = "1";
        } else {
          Map decoded = json.decode(response.body) as Map<String, dynamic>;
          if (decoded['response'][0]['students'] != '') {
            for (int i = 0; i < decoded['response'].length; i++) {
              AllchildsName.add(decoded['response'][i]['students']);
            }
          }
        }
      }
      bool flag = false;
      for (int i = 0; i < AllchildsName.length; i++) {
        for (int j = 0; j < childsName.length; j++) {
          if (AllchildsName[i] == childsName[j]) {
            flag = true;
          }
        }
        if (!flag) {
          childsName.add(AllchildsName[i]);
          childsFlag1.add('false');
          childsFlag2.add('false');
          childsFlag3.add('false');
        }
        flag = false;
      }
      print("ALLLLL");
      print(AllchildsName);
      print("child name");
      print(childsName);
    }
  }
}
