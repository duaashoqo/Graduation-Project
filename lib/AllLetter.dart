import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'LessonAndExersize.dart';
import 'LetterExcersize.dart';

import 'ip_address.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'TeacherChildProgress.dart';

class AllLetter extends StatefulWidget {
  var count_veiwer_letters;
  String id;
  String title;
  List<dynamic> letters;
  String sub_name;
  String class_name;
  List<dynamic> excersize_type;
  List<dynamic> excersizesName;
  List<dynamic> excersizesAnswer;

  List<dynamic> choice1;
  List<dynamic> choice2;
  List<dynamic> choice3;
  List<dynamic> name_of_image;
  List<dynamic> word;
  List<dynamic> videos;

  AllLetter(
      {key,
      this.count_veiwer_letters,
      this.id,
      this.title,
      this.letters,
      this.sub_name,
      this.class_name,
      this.excersize_type,
      this.excersizesName,
      this.excersizesAnswer,
      this.choice1,
      this.choice2,
      this.choice3,
      this.name_of_image,
      this.word,
      this.videos})
      : super(key: key);

  @override
  _AllLetterState createState() => _AllLetterState();
}

class _AllLetterState extends State<AllLetter> {
  List<dynamic> letters = [];
  List<int> excersize_type = [];
  List<dynamic> excersizesName = [];
  List<dynamic> excersizesAnswer = [];
  List<dynamic> choice1 = [];
  List<dynamic> choice2 = [];

  List<dynamic> choice3 = [];
  List<dynamic> word = [];
  List<dynamic> name_of_image1 = [];
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
  List<dynamic> new_letter = [];

  List<dynamic> images = [];
  List<dynamic> childsCode = [];
  List<dynamic> childsFlag1 = [];
  List<dynamic> childsFlag2 = [];
  List<dynamic> childsFlag3 = [];
  List<dynamic> childsName = [];
  List<dynamic> AllchildsName = [];
  List<int> num_veiwer = [];

  @override
  Widget build(BuildContext context) {
    print(widget.letters);
    print("aaaaaaa");
    new_letter = [];
    images = [];
    List<Color> color = [
      Colors.blueGrey,
      Colors.pink,
    ];
    int count = 0;
    if (widget.sub_name == 'عربي' && widget.letters.length != 0) {
      count = 28;
    } else if (widget.sub_name == 'انجليزي' && widget.letters.length != 0) {
      count = 26;
    } else if (widget.sub_name == 'رياضيات' && widget.letters.length != 0) {
      count = 9;
    }

    for (int i = 0; i < widget.letters.length; i++) {
      for (int j = 0; j < count; j++) {
        if (widget.sub_name == 'عربي') {
          if (Letter_arabic[j] == widget.letters[i]) {
            new_letter.add(Letter_arabic_word[j]);
            images.add(widget.letters[i]);
            print("yess");
          }
        } else if (widget.sub_name == 'انجليزي') {
          if (Letter_english[j] == widget.letters[i]) {
            new_letter.add(Letter_english_word[j]);
            print("LastLetter");

            images.add(widget.letters[i]);
          }
        }
      }
    }
    for (int i = 0; i < widget.letters.length; i++) {
      if (widget.sub_name == 'رياضيات') {
        print("YESS2222");
        new_letter.add("العدد" + widget.letters[i]);
        images.add((i + 1).toString());
      }
    }
    print(widget.count_veiwer_letters[widget.letters[0]]);
    print(widget.count_veiwer_letters[widget.letters[1]]);
    print(widget.letters.length);

    for (int i = 0; i < widget.letters.length; i++) {
      if (widget.count_veiwer_letters[widget.letters[i]] != null) {
        print("FFFFF");
        print(widget.count_veiwer_letters[widget.letters[i]]);
        num_veiwer.add(widget.count_veiwer_letters[widget.letters[i]]);
      } else {
        num_veiwer.add(0);
      }
    }
    print("num_veiwer");
    print(num_veiwer);
    print("From allll");
    print(widget.videos);

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
                        exersizesLetters: widget.letters,
                        exersizesType: widget.excersize_type,
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
                                  " التمــاريـن الـمضـــافـــة ",
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
                                                      onTap: () async {
                                                        await getLetterExersize(
                                                            widget
                                                                .letters[index],
                                                            widget.class_name);

                                                        var route =
                                                            new MaterialPageRoute(
                                                          builder: (BuildContext context) => new letterExcersize(
                                                              title: widget
                                                                      .title +
                                                                  '-' +
                                                                  widget.letters[
                                                                      index],
                                                              letter:
                                                                  widget.letters[
                                                                      index],
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
                                                              sub_name: widget
                                                                  .sub_name,
                                                              class_name: widget
                                                                  .class_name),
                                                        );
                                                        Navigator.of(context)
                                                            .push(route);
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
                                                            "تعديل الحرف",
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
                                                        deleteSubjectLetter(
                                                            widget.sub_name,
                                                            widget
                                                                .letters[index],
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
                                                            "حذف الحرف",
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
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 10),
                                            SizedBox(
                                              height: 20,
                                              child: IconButton(
                                                onPressed: () async {
                                                  await getChildProgress(
                                                      widget.id,
                                                      widget.letters[index],
                                                      widget.class_name);
                                                  var route =
                                                      new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        new TeacherChildProgress(
                                                            title: widget
                                                                    .title +
                                                                '-' +
                                                                'مستوى الطلاب',
                                                            childsName:
                                                                childsName,
                                                            childsFlag1:
                                                                childsFlag1,
                                                            childsFlag2:
                                                                childsFlag2,
                                                            childsFlag3:
                                                                childsFlag3),
                                                  );
                                                  Navigator.of(context)
                                                      .push(route);
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
                                                child: Text(num_veiwer[index]
                                                    .toString()))
                                          ],
                                        ),
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
                                            child: Text(new_letter[index],
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: GoogleFonts.markaziText(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 24))),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 2, left: 10),
                                          child: Container(
                                            width: 65,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,

                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),

                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/${images[index]}.jpg'),
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
                                                  onTap: () async {
                                                    await getLetterExersize(
                                                        widget.letters[index],
                                                        widget.class_name);
                                                    print("Letter e");
                                                    print(excersizesName);
                                                    print(excersize_type);
                                                    print(excersizesAnswer);

                                                    var route =
                                                        new MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          new letterExcersize(
                                                              title:
                                                                  widget.title +
                                                                      '-' +
                                                                      widget.letters[
                                                                          index],
                                                              letter: widget
                                                                      .letters[
                                                                  index],
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
                                                              sub_name: widget
                                                                  .sub_name,
                                                              class_name: widget
                                                                  .class_name),
                                                    );
                                                    Navigator.of(context)
                                                        .push(route);
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
                                                        "تعديل الحرف",
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
                                                    deleteSubjectLetter(
                                                        widget.sub_name,
                                                        widget.letters[index],
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
                                                        "حذف الحرف",
                                                        textDirection:
                                                            TextDirection.rtl,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                value: 2,
                                              ),
                                            ]),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 10),
                                        SizedBox(
                                          height: 20,
                                          child: IconButton(
                                            onPressed: () async {
                                              await getChildProgress(
                                                  widget.id,
                                                  widget.letters[index],
                                                  widget.class_name);
                                              var route = new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    new TeacherChildProgress(
                                                        title:
                                                            widget
                                                                    .title +
                                                                '-' +
                                                                'مستوى الطلاب',
                                                        childsName: childsName,
                                                        childsFlag1:
                                                            childsFlag1,
                                                        childsFlag2:
                                                            childsFlag2,
                                                        childsFlag3:
                                                            childsFlag3),
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
                                            child: Text(
                                                num_veiwer[index].toString()))
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Text(new_letter[index],
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
                                                'assets/images/${images[index]}.jpg'),
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
                      ),
                    );
                  }
                },
                childCount: widget.letters.length,
              ),
            )
          ]),
          widget.letters.length == 0
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
                          " التمــاريـن الـمضـــافـــة ",
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
                        "لا يـوجـد تمــارين مضــافـة",
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

  Future<void> deleteSubjectLetter(
      String sub_name, String answer, String class_name) async {
    String apiUrl;

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
          widget.letters = excersizesAnswer;
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
          setState(() {
            widget.letters = excersizesAnswer;
            widget.excersizesName = excersizesName;
            widget.excersizesAnswer = excersizesAnswer;
            widget.choice1 = choice1;
            widget.choice2 = choice2;
            widget.choice3 = choice3;
            widget.name_of_image = name_of_image1;
            widget.word = word;
          });
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
