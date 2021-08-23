import 'dart:math';

import 'package:admin_kg1/second.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ip_address.dart';

class first_exc extends StatefulWidget {
  String title;
  String word;
  String imageName;
  String choice1;
  String choice2;
  String choice3;
  String answer;
  bool isFirst;
  String code;
  String sub;

  first_exc(
      {key,
      this.title,
      this.word,
      this.imageName,
      this.choice1,
      this.choice2,
      this.choice3,
      this.answer,
      this.isFirst,
      this.code,
      this.sub})
      : super(key: key);

  @override
  State<first_exc> createState() => _first_excState();
}

class _first_excState extends State<first_exc> {
  String title2;
  String word2;
  String imageName2;
  String answer2;
  bool draged = false;
  bool finished = false;
  int count = 0;
  bool exist = false;
  String teacherName;
  String className;
  String flag1;
  String flag2;

  String flag3;

  Future getType2Info(String num, String className) async {
    print(num);
    print(
        ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;gggggggggggggggggggggggggggggggggggg");
    final String apiUrl = '${IP}getType2Info';
    final response = await http
        .post(Uri.parse(apiUrl), body: {"letter": num, "className": className});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        print("la ;a ;a زابططططططططططططططط");
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        title2 = (decoded['response'][0]['title2']);
        word2 = (decoded['response'][0]['word2']);
        imageName2 = (decoded['response'][0]['imageName2']);

        answer2 = (decoded['response'][0]['answer2']);
        print(
            ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;gggggggggggggggggggggggggggggggggggg");
        print(title2);
        print(word2);
        print(imageName2);

        print(answer2);
      }
    }
  }

  Future checkIfExist(String code, String answer) async {
    print(code);
    final String apiUrl = '${IP}checkIfExist';
    final response = await http
        .post(Uri.parse(apiUrl), body: {"code": code, "symbol": answer});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        exist = (decoded['response'][0]['exist']);

        print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
        print(exist);
      }
    }
  }

  // getClassNameCode
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

  // getTeacherNameCts
  Future getTeacherNameCts(String className, String sub) async {
    print("llllllllllllllllllllllllllllllllllllttttttttttttttttttttttt");
    print(className);
    print(sub);
    print(className);
    final String apiUrl = '${IP}getTeacherNameCts';
    final response = await http.post(Uri.parse(apiUrl),
        body: {"className": className, "subName": sub});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        teacherName = (decoded['response'][0]['teacherName']);

        print(".......................................");
        print(className);
      }
    }
  }

  // insertStudentToCtsq_4Type1
  Future insertStudentToCtsq_4Type1(
      code, className, teacherName, sub, flag1, flag2, flag3) async {
    print("before insertttttttttttttttttttttttttttttttt");
    print(code);
    print(className);
    print(teacherName);
    print(sub);
    print(flag1);
    print(flag2);
    print(flag3);

    final String apiUrl = '${IP}insertStudentToCtsq_4Type1';
    final response = await http.post(Uri.parse(apiUrl), body: {
      "code": code,
      "className": className,
      "teacherName": teacherName,
      "sub": sub,
      "flag1": "true",
      "flag2": "false",
      "flag3": "false",
      "symbol": widget.answer
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        print("تمت الاضافه بنجاح");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("codeeeeeeeeeeeeeeeeeee");
    print(widget.code);
    var rng = new Random();

    int z = rng.nextInt(3) + 1;
    print(z);
    if (z == 4) {
      z = z - 1;
    }
    print("shshshshshhhhhhhhhhhhhhhhhhhhhhhh");

    return Scaffold(
        backgroundColor: Colors.white,
        body: new Stack(children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/sky.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.07,
                    right: MediaQuery.of(context).size.width * 0.07),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.title,
                            style: GoogleFonts.markaziText(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (widget.isFirst)
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            //  "http://10.0.2.2/flutter_test/uploads/'${imageName}'"

                                            "http://10.0.2.2/flutter_test/uploads/${widget.imageName}.jpg"),
                                        fit: BoxFit.contain)),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/${z}${widget.answer}.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Text(widget.word,
                            style: GoogleFonts.markaziText(
                              color: Colors.black,
                              fontSize: 23,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      (draged != true)
                          ? DragTarget<String>(
                              builder: (context, List<String> candidateData,
                                  rejectedData) {
                                return Container(
                                  child: Center(
                                      child: Text(widget.answer,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.grey,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                );
                              },
                              // onWillAccept: (data){

                              // },
                              onAccept: (data) {
                                if (data == widget.answer) {
                                  final assetsAudioPlayer = AssetsAudioPlayer();

                                  assetsAudioPlayer.open(
                                    Audio("assets/audios/music.mp3"),
                                  );
                                  setState(() {
                                    draged = true;
                                    finished = true;
                                  });
                                  print(data);
                                  print(
                                      '..................................................');
                                  return;
                                }
                                count = count + 1;
                                print("hellllo");
                                final assetsAudioPlayer = AssetsAudioPlayer();
                                assetsAudioPlayer.open(
                                  Audio("assets/audios/false.mp3"),
                                );
                              },
                            )
                          : DragTarget<String>(
                              builder: (context, List<String> candidateData,
                                  rejectedData) {
                                return Container(
                                  child: Center(
                                      child: Text(widget.answer,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.orangeAccent,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                );
                              },
                              // onWillAccept: (data){

                              // },
                              onAccept: (data) {
                                if (data == widget.answer) {
                                  final assetsAudioPlayer = AssetsAudioPlayer();

                                  assetsAudioPlayer.open(
                                    Audio("assets/audios/music.mp3"),
                                  );
                                  setState(() {
                                    draged = true;
                                    finished = true;
                                  });
                                  return;
                                }
                                print("2hellllo");
                                count = count + 1;

                                final assetsAudioPlayer = AssetsAudioPlayer();
                                assetsAudioPlayer.open(
                                  Audio("assets/audios/false.mp3"),
                                );

                                print(data);
                                print(
                                    '..................................................');
                              },
                            )
                    ]),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Draggable<String>(
                          feedback: Container(
                            child: Center(
                                child: Text(widget.choice3,
                                    style: GoogleFonts.markaziText(
                                        color: Colors.black,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold))),
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                // Make rounded corners
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          childWhenDragging: Container(
                            child: Center(
                                child: Text(widget.choice3,
                                    style: GoogleFonts.markaziText(
                                        color: Colors.grey,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold))),
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                // Make rounded corners
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          data: widget.choice3,
                          child: Container(
                            child: Center(
                                child: Text(widget.choice3,
                                    style: GoogleFonts.markaziText(
                                        color: Colors.black,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold))),
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.orange,
                                ),
                                // Make rounded corners
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Draggable<String>(
                          feedback: Container(
                            child: Center(
                                child: Text(widget.choice2,
                                    style: GoogleFonts.markaziText(
                                        color: Colors.black,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold))),
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                // Make rounded corners
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          childWhenDragging: Container(
                            child: Center(
                                child: Text(widget.choice2,
                                    style: GoogleFonts.markaziText(
                                        color: Colors.grey,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold))),
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                // Make rounded corners
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          data: widget.choice2,
                          child: Container(
                            child: Center(
                                child: Text(widget.choice2,
                                    style: GoogleFonts.markaziText(
                                        color: Colors.black,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold))),
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.orange,
                                ),
                                // Make rounded corners
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Draggable<String>(
                          feedback: Container(
                            child: Center(
                                child: Text(widget.choice1,
                                    style: GoogleFonts.markaziText(
                                        color: Colors.black,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold))),
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                // Make rounded corners
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          childWhenDragging: Container(
                            child: Center(
                                child: Text(widget.choice1,
                                    style: GoogleFonts.markaziText(
                                        color: Colors.grey,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold))),
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                // Make rounded corners
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          data: widget.choice1,
                          child: Container(
                            child: Center(
                                child: Text(widget.choice1,
                                    style: GoogleFonts.markaziText(
                                        color: Colors.black,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold))),
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.orange,
                                ),
                                // Make rounded corners
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              (!finished)
                  ? SizedBox(
                      height: MediaQuery.of(context).size.width * 0.2,
                    )
                  : Row(
                      children: [
                        SizedBox(),
                        InkWell(
                          onTap: () async => {
                            if (count != 0)
                              {
                                await checkIfExist(widget.code, widget.answer),
                                if (exist)
                                  {print("موجوووووووووووووووووووووووووود")}
                                else
                                  {
                                    print(
                                        "................................this code=........................"),
                                    print(widget.code),
                                    print(className),
                                    print(teacherName),
                                    print(widget.sub),
                                    await getClassNameCode(widget.code),
                                    await getTeacherNameCts(
                                        className, widget.sub),
                                    await insertStudentToCtsq_4Type1(
                                      widget.code,
                                      className,
                                      teacherName,
                                      widget.sub,
                                      "true",
                                      "false",
                                      "false",
                                    )
                                  },
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        first_exc(
                                      sub: widget.sub,
                                      code: widget.code,
                                      title: widget.title,
                                      word: widget.word,
                                      imageName: "",
                                      choice1: widget.choice1,
                                      choice2: widget.choice2,
                                      choice3: widget.choice3,
                                      answer: widget.answer,
                                      isFirst: false,
                                    ),
                                  ),
                                )
                              }
                            else
                              {
                                await checkIfExist(widget.code, widget.answer),
                                if (exist)
                                  {print("موجوووووووووووووووووووووووووود")}
                                else
                                  {
                                    print(
                                        "................................this code=........................"),
                                    print(exist),
                                    print(widget.code),
                                    print(className),
                                    print(teacherName),
                                    print(widget.sub),
                                    await getClassNameCode(widget.code),
                                    await getTeacherNameCts(
                                        className, widget.sub),
                                    await insertStudentToCtsq_4Type1(
                                        widget.code,
                                        className,
                                        teacherName,
                                        widget.sub,
                                        "true",
                                        "false",
                                        "false")
                                    //  await insertStudentToCtsq_4()
                                  },
                                await getClassNameCode(widget.code),
                                await getType2Info(widget.answer, className),
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => second(
                                      title: title2,
                                      word: word2,
                                      answer: answer2,
                                      imageName: imageName2,
                                      subject: widget.sub,
                                      code: widget.code,
                                      className: className,
                                    ),
                                    //    DrawScreen()
                                  ),
                                )
                              }
                          },
                          child: Image.asset(
                            "assets/images/arrow.png",
                            width: MediaQuery.of(context).size.width * 0.35,
                            // height: MediaQuery.of(context).size.height * 0.2,
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ]));
  }
}
