import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'E_type1.dart';
import 'E_type2.dart';
import 'E_type3.dart';

class letterExcersize extends StatelessWidget {
  String title;
  String letter;
  List<int> excersize_type;
  List<dynamic> excersizesName;
  List<dynamic> excersizesAnswer;
  List<dynamic> choice1;
  List<dynamic> choice2;
  List<dynamic> choice3;
  List<dynamic> name_of_image;
  List<dynamic> word;
  String sub_name;

  String class_name;

  letterExcersize(
      {key,
      this.title,
      this.letter,
      this.excersize_type,
      this.excersizesName,
      this.excersizesAnswer,
      this.choice1,
      this.choice2,
      this.choice3,
      this.name_of_image,
      this.word,
      this.sub_name,
      this.class_name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(title);
    // print(excersize_type);
    List<Color> color = [Colors.blueGrey, Colors.pink, Colors.lime[700]];
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                title,
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
                                  " التـمــاريــن الـمضـــافـــة ",
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
                              onTap: () {
                                print("dododoodo");
                                // print(excersize_type.length);
                                print(excersize_type[index]);
                                if (excersize_type[index] == 1) {
                                  print(excersizesName[index]);
                                  print(excersizesAnswer[index]);
                                  print(choice1[index]);
                                  print(choice2[index]);
                                  print(choice3[index]);
                                  print(name_of_image[index]);
                                  print(word[index]);

                                  var route = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new type1.fromType1(
                                      title: title,
                                      sub: sub_name,
                                      calssName: class_name,
                                      exc_title: excersizesName[index],
                                      answer: excersizesAnswer[index],
                                      choice1: choice1[index],
                                      choice2: choice2[index],
                                      choice3: choice3[index],
                                      name_of_image: name_of_image[index],
                                      word: word[index],
                                      flag: true,
                                    ),
                                  );
                                  Navigator.of(context).push(route);
                                } else if (excersize_type[index] == 2) {
                                  var route = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new type2.fromType2(
                                      title: title,
                                      sub: sub_name,
                                      calssName: class_name,
                                      exc_title: excersizesName[index],
                                      answer: excersizesAnswer[index],
                                      name_of_image: name_of_image[index],
                                      word: word[index],
                                      flag: true,
                                    ),
                                  );
                                  Navigator.of(context).push(route);
                                } else if (excersize_type[index] == 3) {
                                  var route = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new type3.fromType3(
                                      title: title,
                                      sub: sub_name,
                                      calssName: class_name,
                                      exc_title: excersizesName[index],
                                      answer: excersizesAnswer[index],
                                      name_of_image: name_of_image[index],
                                      word: word[index],
                                      flag: true,
                                    ),
                                  );
                                  Navigator.of(context).push(route);
                                }
                              },
                              child: Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: Text(excersizesName[index],
                                            textDirection: TextDirection.rtl,
                                            style: GoogleFonts.markaziText(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 23))),
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
                                                  fontSize: 50),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        decoration: BoxDecoration(
                                          color: color[index],
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
                          onTap: () {
                            print("dodoءdoodo");
                            print(excersize_type[index]);
                            if (excersize_type[index] == 1) {
                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new type1.fromType1(
                                  title: title,
                                  sub: sub_name,
                                  calssName: class_name,
                                  exc_title: excersizesName[index],
                                  answer: excersizesAnswer[index],
                                  choice1: choice1[index],
                                  choice2: choice2[index],
                                  choice3: choice3[index],
                                  name_of_image: name_of_image[index],
                                  word: word[index],
                                  flag: true,
                                ),
                              );
                              Navigator.of(context).push(route);
                            } else if (excersize_type[index] == 2) {
                              print(excersizesName[index]);
                              print(excersizesAnswer[index]);
                              print(choice1[index]);
                              print(choice2[index]);
                              print(choice3[index]);
                              print(name_of_image[index]);
                              print(word[index]);
                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new type2.fromType2(
                                  title: title,
                                  sub: sub_name,
                                  calssName: class_name,
                                  exc_title: excersizesName[index],
                                  answer: excersizesAnswer[index],
                                  name_of_image: name_of_image[index],
                                  word: word[index],
                                  flag: true,
                                ),
                              );
                              Navigator.of(context).push(route);
                            } else if (excersize_type[index] == 3) {
                              print(excersizesName[index]);
                              print(excersizesAnswer[index]);
                              print(choice1[index]);
                              print(choice2[index]);
                              print(choice3[index]);
                              print(name_of_image[index]);
                              print(word[index]);
                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new type3.fromType3(
                                  title: title,
                                  sub: sub_name,
                                  calssName: class_name,
                                  exc_title: excersizesName[index],
                                  answer: excersizesAnswer[index],
                                  name_of_image: name_of_image[index],
                                  word: word[index],
                                  flag: true,
                                ),
                              );
                              Navigator.of(context).push(route);
                            }
                          },
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(excersizesName[index],
                                        textDirection: TextDirection.rtl,
                                        style: GoogleFonts.markaziText(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 23))),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 0, left: 10),
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
                                              fontSize: 50),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    decoration: BoxDecoration(
                                      color: color[index],
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
                            elevation: 5,
                          ),
                        ),
                      ),
                    );
                  }
                },
                childCount: excersizesName.length,
              ),
            )
          ]),
        ],
      ),
    );
  }
}
