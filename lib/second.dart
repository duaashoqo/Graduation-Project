import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:admin_kg1/prediction.dart';
import 'package:admin_kg1/recognizer.dart';
import 'package:admin_kg1/third.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:assets_audio_player/playable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ip_address.dart';

class second extends StatefulWidget {
  String title;
  String word;
  String imageName;
  String answer;
  String subject;
  String code;
  String className;

  second(
      {key,
      this.title,
      this.word,
      this.imageName,
      this.answer,
      this.subject,
      this.code,
      this.className})
      : super(key: key);

  @override
  State<second> createState() => _Preview2State();
}

class _Preview2State extends State<second> {
  String title3;
  String word3;
  String imageName3;
  String answer3;
  String subject3;
  String code3;
  String className3;
  final _points = List<Offset>();
  bool binClick = false;
  bool initialize = false;
  Color selectedColor = Colors.black;
  Color pickerColor = Colors.black;
  double strokeWidth = 3.0;
  List<DrawingPoints> points = List();
  bool showBottomList = false;
  bool finished = false;
  bool flag = true;
  double opacity = 1.0;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  SelectedMode selectedMode = SelectedMode.StrokeWidth;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.black
  ];

  final _recognizer = Recognizer();
  List<Prediction> _prediction;

  @override
  void initState() {
    super.initState();
    _initModel();
  }

  Future getType3Info(String num, String className) async {
    print(num);
    print(className);
    print(
        ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;gggggggggggggggggggggggggggggggggggg");
    final String apiUrl = '${IP}getType3Info';
    final response = await http
        .post(Uri.parse(apiUrl), body: {"letter": num, "className": className});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        print("la ;a ;a زابططططططططططططططط");
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        title3 = (decoded['response'][0]['title2']);
        word3 = (decoded['response'][0]['word2']);
        imageName3 = (decoded['response'][0]['imageName2']);

        answer3 = (decoded['response'][0]['answer2']);
        print(
            ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;gggggggggggggggggggggggggggggggggggg");
        print(title3);
        print(word3);
        print(imageName3);

        print(answer3);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("codeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    print(widget.code);
    print("hhhheeeeeeelllllo");
    print(widget.answer);
    if (widget.answer != "") {
      return Scaffold(
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: binClick
                ? Container(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Color.fromRGBO(128, 204, 230, 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.album),
                                  onPressed: () {
                                    setState(() {
                                      if (selectedMode ==
                                          SelectedMode.StrokeWidth)
                                        showBottomList = !showBottomList;
                                      selectedMode = SelectedMode.StrokeWidth;
                                    });
                                  }),
                              IconButton(
                                  icon: Icon(Icons.opacity),
                                  onPressed: () {
                                    setState(() {
                                      if (selectedMode == SelectedMode.Opacity)
                                        showBottomList = !showBottomList;
                                      selectedMode = SelectedMode.Opacity;
                                    });
                                  }),
                              IconButton(
                                  icon: Icon(Icons.color_lens),
                                  onPressed: () {
                                    setState(() {
                                      if (selectedMode == SelectedMode.Color)
                                        showBottomList = !showBottomList;
                                      selectedMode = SelectedMode.Color;
                                    });
                                  }),
                              IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      print("hhhhhhhhhhhhhhhhhhhhhh");
                                      showBottomList = false;
                                      _points.clear();
                                    });
                                  }),
                            ],
                          ),
                          Visibility(
                            child: (selectedMode == SelectedMode.Color)
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: getColorList(),
                                  )
                                : Slider(
                                    value: (selectedMode ==
                                            SelectedMode.StrokeWidth)
                                        ? strokeWidth
                                        : opacity,
                                    max: (selectedMode ==
                                            SelectedMode.StrokeWidth)
                                        ? 50.0
                                        : 1.0,
                                    min: 0.0,
                                    onChanged: (val) {
                                      setState(() {
                                        if (selectedMode ==
                                            SelectedMode.StrokeWidth)
                                          strokeWidth = val;
                                        else
                                          opacity = val;
                                      });
                                    }),
                            visible: showBottomList,
                          ),
                        ],
                      ),
                    ))
                : SizedBox()),
        body: new Stack(children: <Widget>[
          Container(
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
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.07,
                    right: MediaQuery.of(context).size.width * 0.07),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.grey[50],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
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
                        // RichText(
                        //   text: new TextSpan(
                        //     // Note: Styles for TextSpans must be explicitly defined.
                        //     // Child text spans will inherit styles from parent
                        //     style: new TextStyle(
                        //       fontSize: 14.0,
                        //       color: Colors.black,
                        //     ),
                        //     children: <TextSpan>[
                        //       new TextSpan(
                        //           text: widget.answer,
                        //           style: GoogleFonts.markaziText(
                        //               color: Colors.grey,
                        //               fontSize: 23,
                        //               fontWeight: FontWeight.bold)),
                        //       new TextSpan(
                        //           text: widget.word,
                        //           style: GoogleFonts.markaziText(
                        //               color: Colors.black,
                        //               fontSize: 23,
                        //               fontWeight: FontWeight.bold)),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                    Container(
                        width: Constants.canvasSize + Constants.borderSize * 2,
                        height: Constants.canvasSize + Constants.borderSize * 2,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: Constants.borderSize,
                          ),
                        ),
                        child: Container(
                          width:
                              Constants.canvasSize + Constants.borderSize * 2,
                          height:
                              Constants.canvasSize + Constants.borderSize * 2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "http://10.0.2.2/flutter_test/uploads/${widget.imageName}.jpg"),
                                  fit: BoxFit.cover)),
                          child: GestureDetector(
                            onPanUpdate: (DragUpdateDetails details) {
                              Offset _localPosition = details.localPosition;
                              if (_localPosition.dx >= 0 &&
                                  _localPosition.dx <= Constants.canvasSize &&
                                  _localPosition.dy >= 0 &&
                                  _localPosition.dy <= Constants.canvasSize) {
                                setState(() {
                                  _points.add(_localPosition);
                                });
                              }
                            },
                            onPanEnd: (DragEndDetails details) {
                              _points.add(null);
                              _recognize();

                              // _recognize();
                            },
                            child: CustomPaint(
                              painter: DrawingPainter(
                                  _points,
                                  selectedColor,
                                  Paint()
                                    ..strokeCap = strokeCap
                                    ..isAntiAlias = true
                                    ..color = selectedColor.withOpacity(opacity)
                                    ..strokeWidth = strokeWidth),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Divider(
                      thickness: MediaQuery.of(context).size.height * 0.001,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          // binClick
                          onTap: () {
                            setState(() {
                              binClick = !binClick;
                            });
                          },
                          child: Container(
                            child: Image.asset(
                              "assets/images/pen-2.png",
                              fit: BoxFit.scaleDown,
                              width: 50,
                            ),
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
                          // onTap: () async => {
                          //   if (count != 0)
                          //     {
                          //       await checkIfExist(widget.code, widget.answer),
                          //       if (exist)
                          //         {print("موجوووووووووووووووووووووووووود")}
                          //       else
                          //         {
                          //           print(
                          //               "................................this code=........................"),
                          //           print(widget.code),
                          //           print(className),
                          //           print(teacherName),
                          //           print(widget.sub),
                          //           await getClassNameCode(widget.code),
                          //           await getTeacherNameCts(
                          //               className, widget.sub),
                          //           await insertStudentToCtsq_4Type1(
                          //             widget.code,
                          //             className,
                          //             teacherName,
                          //             widget.sub,
                          //             "true",
                          //             "false",
                          //             "false",
                          //           )
                          //         },
                          //       Navigator.push<void>(
                          //         context,
                          //         MaterialPageRoute<void>(
                          //           builder: (BuildContext context) =>
                          //               first_exc(
                          //             sub: widget.sub,
                          //             code: widget.code,
                          //             title: widget.title,
                          //             word: widget.word,
                          //             imageName: "",
                          //             choice1: widget.choice1,
                          //             choice2: widget.choice2,
                          //             choice3: widget.choice3,
                          //             answer: widget.answer,
                          //             isFirst: false,
                          //           ),
                          //         ),
                          //       )
                          //     }
                          //   else
                          //     {
                          //       await checkIfExist(widget.code, widget.answer),
                          //       if (exist)
                          //         {print("موجوووووووووووووووووووووووووود")}
                          //       else
                          //         {
                          //           print(
                          //               "................................this code=........................"),
                          //           print(exist),
                          //           print(widget.code),
                          //           print(className),
                          //           print(teacherName),
                          //           print(widget.sub),
                          //           await getClassNameCode(widget.code),
                          //           await getTeacherNameCts(
                          //               className, widget.sub),
                          //           await insertStudentToCtsq_4Type1(
                          //               widget.code,
                          //               className,
                          //               teacherName,
                          //               widget.sub,
                          //               "true",
                          //               "false",
                          //               "false")
                          //           //  await insertStudentToCtsq_4()
                          //         },
                          //       await getClassNameCode(widget.code),
                          //       await getType2Info(widget.answer, className),
                          //       Navigator.push<void>(
                          //         context,
                          //         MaterialPageRoute<void>(
                          //           builder: (BuildContext context) => second(
                          //             title: title2,
                          //             word: word2,
                          //             answer: answer2,
                          //             imageName: imageName2,
                          //             subject: widget.sub,
                          //           ),
                          //           //    DrawScreen()
                          //         ),
                          //       )
                          //     }
                          // },

                          child: InkWell(
                            onTap: () async {
                              print(
                                  "كككككككككككككككككككككككككككككككككككككككككككككككك");
                              print(title3);
                              print(word3);
                              print(imageName3);
                              print(widget.code);
                              print(widget.className);
                              await getType3Info(
                                  widget.answer, widget.className);
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => third(
                                    title: title3,
                                    word: word3,
                                    answer: widget.answer,
                                    imageName: imageName3,
                                    subject: widget.subject,
                                    code: widget.code,
                                  ),
                                  //    DrawScreen()
                                ),
                              );
                            },
                            child: Image.asset(
                              "assets/images/arrow.png",
                              width: MediaQuery.of(context).size.width * 0.35,
                              // height: MediaQuery.of(context).size.height * 0.2,
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          )
        ]),
      );
    } else
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Align(
            alignment: Alignment.bottomRight,
            child: Text("صفحة التمرين التالي ",
                style: GoogleFonts.amiri(color: Colors.black, fontSize: 20)),
          ),
        ),
        body: Stack(children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/sky.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              child: Text(
                "لم يتم اضافة  هذا السؤال بعد ",
                style: (GoogleFonts.amiri(fontSize: 20)),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          )
        ]),
      );
  }

  getColorList() {
    List<Widget> listWidget = List();
    for (Color color in colors) {
      listWidget.add(colorCircle(color));
    }
    Widget colorPicker = GestureDetector(
      onTap: () {
        showDialog(
          builder: (context) => AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
                // child: ColorPicker(
                //   pickerColor: pickerColor,
                //   onColorChanged: (color) {
                //     pickerColor = color;
                //   },
                //   enableLabel: true,
                //   pickerAreaHeightPercent: 0.8,
                // ),
                ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Save'),
                onPressed: () {
                  setState(() => selectedColor = pickerColor);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          context: context,
        );
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.red, Colors.green, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
      ),
    );
    listWidget.add(colorPicker);
    return listWidget;
  }

  Widget colorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: 36,
          width: 36,
          color: color,
        ),
      ),
    );
  }

  Widget _mnistPreviewImage() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.black,
      child: FutureBuilder(
        future: _previewImage(),
        builder: (BuildContext _, snapshot) {
          if (snapshot.hasData) {
            return Image.memory(
              snapshot.data,
              fit: BoxFit.fill,
            );
          } else {
            return Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }

  void _initModel() async {
    var res = await _recognizer.loadModel(widget.subject);
  }

  Future<Uint8List> _previewImage() async {
    return await _recognizer.previewImage(_points);
  }

  void _recognize() async {
    List<dynamic> pred = await _recognizer.recognize(_points);
    // if (widget.answer == pred[0]['label'] && !finished) {
    //   final assetsAudioPlayer = AssetsAudioPlayer();

    //   assetsAudioPlayer.open(
    //     Audio("assets/audios/music.mp3"),
    //   );
    // } else if (!finished) {
    //   final assetsAudioPlayer = AssetsAudioPlayer();

    //   assetsAudioPlayer.open(
    //     Audio("assets/audios/false.mp3"),
    //   );
    // }
    setState(() async {
      _prediction = pred.map((json) => Prediction.fromJson(json)).toList();
      print(pred[0]['label']);
      print(widget.answer);
      print(widget.answer == pred[0]['label']);

      if (widget.answer == pred[0]['label']) {
        print(widget.code);
        final assetsAudioPlayer = AssetsAudioPlayer();

        assetsAudioPlayer.open(
          Audio("assets/audios/music.mp3"),
        );
        await updateQuestionsInfo(widget.answer, widget.code);
        print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHhhhhhhh");
        flag = false;
        finished = true;
      } else {
        final assetsAudioPlayer = AssetsAudioPlayer();

        assetsAudioPlayer.open(
          Audio("assets/audios/false.mp3"),
        );
      }
    });
    // if (widget.answer == pred[0]['label']) {
    //   final assetsAudioPlayer = AssetsAudioPlayer();

    //   assetsAudioPlayer.open(
    //     Audio("assets/audios/music.mp3"),
    //   );

    // } else {
    //   final assetsAudioPlayer = AssetsAudioPlayer();

    //   assetsAudioPlayer.open(
    //     Audio("assets/audios/false.mp3"),
    //   );
    // }
  }

  updateQuestionsInfo(String answer, String code) async {
    print("hWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW");
    print(code);
    final String apiUrl = '${IP}updateQuestionsInfo';
    final response = await http
        .post(Uri.parse(apiUrl), body: {"answer": answer, "code": code});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        print("تمت عملية التعديييييييييييييل");
      }
    }
  }
}

class Constants {
  static double canvasSize = 300;
  static double borderSize = 2;

  static double imageSize = 300;
  static int mnistImageSize = 28;

  static double strokeWidth = 8;
}

class DrawingPoints {
  Paint paint;
  Offset points;
  DrawingPoints({this.points, this.paint});
}

class DrawingPainter extends CustomPainter {
  final List<Offset> points;
  final Color r;

  final Paint _paint;

  DrawingPainter(this.points, this.r, this._paint);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], _paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum SelectedMode { StrokeWidth, Opacity, Color }
