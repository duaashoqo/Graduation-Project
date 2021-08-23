//
import 'dart:convert';
import 'dart:io';
import 'package:admin_kg1/preview1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'ip_address.dart';
// import 'package:dio/dio.dart';

class type1 extends StatefulWidget {
  String title;
  String sub;
  String calssName;
  String exc_title;
  String answer;

  String choice1;
  String choice2;
  String choice3;
  String name_of_image;
  String word;
  bool flag = false;

  type1({key, this.title, this.sub, this.calssName, this.flag})
      : super(key: key);
  type1.fromType1(
      {key,
      this.title,
      this.sub,
      this.calssName,
      this.exc_title,
      this.answer,
      this.choice1,
      this.choice2,
      this.choice3,
      this.name_of_image,
      this.word,
      this.flag})
      : super(key: key);

  @override
  State<type1> createState() => _MyAppState();
}

class _MyAppState extends State<type1> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();
  final myController6 = TextEditingController();
  var isLoading = false;
  var isValid = false;
  var isValidImage = true;
  var picked = false;

  // var preview = true;
  int pressed_count = 0;
  var description = "-";
  var title = "-";
  var choice1 = "-";
  var choice2 = "-";
  var choice3 = "-";
  var answer = "-";

  Future<void> _save() async {
    print("FFFFFFFFff");
    print(description);
    print(title);

    if (description == "-" &&
        title == "-" &&
        choice1 == "-" &&
        choice2 == "-" &&
        choice3 == "-" &&
        answer == "-") {
      print(":::");
      setState(() {
        description = "";

        title = "";

        choice1 = "";

        choice2 = "";

        choice3 = "";

        answer = "";
      });
    }

    if (picked == false) {
      // setState(() {
      isValidImage = false;
      // });
    }
    isValid = isValidImage &&
        description != "" &&
        title != "" &&
        choice1 != "" &&
        choice2 != "" &&
        choice3 != "" &&
        answer != "";
    // setState(() {
    //   preview = true;
    // });
    if (!isValid) {
      return;
    } else {
      print("helllllo");
      print(myController1.text);
      print(myController2.text);
      print(myController3.text);
      print(myController4.text);
      print(myController5.text);
      print('${myController5.text}Type1');
      print(myController6.text);
      print(widget.sub);
      print("looooooooool");
      Map decoded = {};
      if (widget.flag == false) {
        final response = await http.post(Uri.parse('${IP}E_type1'), body: {
          'title': myController1.text,
          'word': myController6.text,
          '1stChoice': myController2.text,
          '2ndChoice': myController3.text,
          '3rdChoice': myController4.text,
          'Answer': myController5.text,
          'nameOfImage1': '${myController5.text}Type1',
          'symbol': myController5.text,
          'sub': widget.sub,
          'class_name': widget.calssName,
        });
        decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'] == 'Error1') {
          Fluttertoast.showToast(
              msg: "التمرين موجود بالفعل",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 12.0);
        } else {
          Fluttertoast.showToast(
              msg: "تمت إضافة التمرين بنجاح",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 12.0);
          sendNotification();
        }
      } else {
        final response = await http.post(Uri.parse('${IP}EditE_type1'), body: {
          'title': myController1.text,
          'word': myController6.text,
          '1stChoice': myController2.text,
          '2ndChoice': myController3.text,
          '3rdChoice': myController4.text,
          'Answer': widget.answer,
          'nameOfImage1': '${myController5.text}Type1',
          'symbol': widget.answer,
          'sub': widget.sub,
          'class_name': widget.calssName,
        });
        decoded = json.decode(response.body) as Map<String, dynamic>;
        print(widget.name_of_image);
        if (widget.exc_title == myController1.text &&
            widget.word == myController6.text &&
            widget.answer == myController5.text &&
            widget.choice1 == myController2.text &&
            widget.name_of_image == myController5.text + "Type1" &&
            widget.choice2 == myController3.text &&
            widget.choice3 == myController4.text) {
          Fluttertoast.showToast(
              msg: "يجب تعديل حقل واحد على الأقل",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 12.0);
        } else {
          Fluttertoast.showToast(
              msg: "تمت تعديل التمرين بنجاح",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 12.0);
        }

        Fluttertoast.showToast(
            msg: "تمت تعديل التمرين بنجاح",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0);
        // sendNotification();

      } //  parent_id

    }
    setState(() {
      if (!widget.flag) {
        myController1.text = '';
        myController2.text = '';
        myController3.text = '';
        myController4.text = '';
        myController5.text = '';
        myController6.text = '';
        isLoading = false;
        isValid = false;
        isValidImage = true;
        picked = false;
        // preview = true;
        description = "-";
        title = "-";
        choice1 = "-";
        choice2 = "-";
        choice3 = "-";
        answer = "-";
      }
    });
  }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    print("Ddddd");
    print(myController5.text);
    print(picked);
    print(widget.flag);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      // if (pickedFile != null) {
      picked = true;

      _image = File(pickedFile.path);
      _uploadImage();
      isValidImage = true;
      // }
    });
  }

  Future<String> _uploadImage() async {
    String uploadurl = 'http://10.0.2.2/flutter_test/uploadImage.php';
    List<int> imageBytes = _image.readAsBytesSync();
    print(_image.path);
    String baseimage = base64Encode(imageBytes);
    String uniqueImageID = '${myController5.text}Type1';
    var response = await http.post(Uri.parse(uploadurl), body: {
      'image': baseimage,
      'name': uniqueImageID,
    });
    return uniqueImageID;
  }

  sendNotification() {
    String msg = "تمت اضافه التمرين الاول لحرف ال${myController5.text}";
    print("::::::::::::::::::::::::::::::::::::");
    print("${widget.calssName}");

    /// Upload images to firebase and returns a URL

    if (msg.isNotEmpty) {
      print('thisiscalled $msg');
      var ref = Firestore.instance
          .collection('notification')
          .document("${widget.calssName}")
          .collection("${widget.calssName}")
          .document(DateTime.now().millisecondsSinceEpoch.toString());
      print(
          "ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg");
      print("الةقت والتاريييييييييييييييييخ${DateTime.now()}");

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(ref, {
          "subjectName": "${widget.sub}",
          "timestamp": DateTime.now().toString(),
          'content': msg,
          "type": 'text',
        });
      });
    } else {
      print('Please enter some text to send');
    }
  }

  @override
  void dispose() {
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    myController5.dispose();
    myController6.dispose();

    super.dispose();
  }

  @override
  void initState() {
    print("Sssss");
    print(widget.flag);
    if (widget.flag == true) {
      myController1.text = widget.exc_title;
      myController2.text = widget.choice1;
      myController3.text = widget.choice2;
      myController4.text = widget.choice3;
      myController5.text = widget.answer;
      myController6.text = widget.word;
      picked = true;
      description = widget.word;
      title = widget.exc_title;
      choice1 = widget.choice1;
      choice2 = widget.choice2;
      choice3 = widget.choice3;
      answer = widget.answer;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    queryData.size.width;
    double a = queryData.size.height * 0.5;
    print("dodododoododo");
    print(
        "http://10.0.2.2/flutter_test/uploads/${'${myController5.text}Type1'}.jpg");
    return MaterialApp(
        title: 'Flutter Code Sample for Scaffold.of.',
        theme: ThemeData(primarySwatch: Colors.grey),
        home: Scaffold(
          body: new Stack(children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/sky.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              // 80cce6
              color: Color.fromRGBO(80, 0xcc, 0xe6, 0.6),
              // alignment: Alignment.bottomCenter,
              // padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(left: 10, right: 10),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 1,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                        child: widget.flag == true && picked == false
                            ? Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: queryData.size.width * 0.5,
                                      height: queryData.size.height * 0.2,
                                      // child: Image.asset(
                                      //   "assets/images/teaccher2.png",
                                      //   fit: BoxFit.contain,
                                      //   width: 200,
                                      // ),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "http://10.0.2.2/flutter_test/uploads/${'${widget.name_of_image}'}.jpg"),
                                              fit: BoxFit.cover)),
                                    ),
                                  ],
                                ),
                              )
                            : picked == false
                                ? Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          width: queryData.size.width * 0.8,
                                          height: queryData.size.height * 0.08,
                                          child: IconButton(
                                            onPressed: () {
                                              // You enter here what you want the button to do once the user interacts with it
                                            },
                                            icon: Icon(
                                              Icons
                                                  .image_not_supported_outlined,
                                              color: Colors.grey,
                                            ),
                                            iconSize: 60.0,
                                          ),
                                          // decoration: new BoxDecoration(
                                          //   image: new DecorationImage(
                                          //     image: new AssetImage(
                                          //         "assets/images/no_image.png"),
                                          //     fit: BoxFit.fitWidth,
                                          //   ),
                                          // ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: queryData.size.width * 0.5,
                                          height: queryData.size.height * 0.2,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "http://10.0.2.2/flutter_test/uploads/${'${myController5.text}Type1'}.jpg"),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ],
                                    ),
                                  )),
                    title != ''
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, right: 20, left: 20),
                            child: Container(
                                child: Theme(
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.transparent),
                              child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    controller: myController1,
                                    autofocus: false,
                                    // initialValue: widget.exc_title,
                                    onChanged: (value) {
                                      setState(() {
                                        title = value;
                                      });
                                    },
                                    style: GoogleFonts.amiri(fontSize: 15),
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: ' عنوان التمرين  ',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 8.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                    ),
                                    onFieldSubmitted: (value) {
                                      //Validator
                                    },
                                  )),
                            )))
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, right: 20, left: 20),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25.7),
                                    border: Border.all(
                                        color: Colors.red, // set border color
                                        width: 1.5)), // set border width
                                // set rounded corner radius

                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      splashColor: Colors.transparent),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      controller: myController1,
                                      autofocus: false,
                                      onChanged: (value) {
                                        setState(() {
                                          title = value;
                                        });
                                      },
                                      style: GoogleFonts.amiri(fontSize: 15),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: ' عنوان التمرين  ',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            left: 14.0, bottom: 8.0, top: 8.0),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                      ),
                                      onFieldSubmitted: (value) {
                                        //Validator
                                      },
                                    ),
                                  ),
                                ))),
                    title != ""
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "يجب كتابة عنوان التمرين ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    choice1 != ''
                        ? Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Container(
                                child: Theme(
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.transparent),
                              child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    controller: myController2,
                                    autofocus: false,
                                    // initialValue: widget.choice1,
                                    onChanged: (value) {
                                      print("heooooo");

                                      if (value.length == 1) {
                                        setState(() {
                                          choice1 = value;
                                        });
                                      } else {
                                        setState(() {
                                          choice1 = '';
                                        });
                                      }
                                    },
                                    style: GoogleFonts.amiri(fontSize: 15),
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: ' الاختيار الأول ',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 8.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                    ),
                                  )),
                            )))
                        : Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25.7),
                                    border: Border.all(
                                        color: Colors.red, // set border color
                                        width: 1.5)),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      splashColor: Colors.transparent),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      controller: myController2,
                                      autofocus: false,
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          print("yes");
                                          setState(() {
                                            choice1 = value;
                                          });
                                        } else {
                                          setState(() {
                                            choice1 = '';
                                          });
                                        }
                                      },
                                      style: GoogleFonts.amiri(fontSize: 15),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: ' الاختيار الأول ',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            left: 14.0, bottom: 8.0, top: 8.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))),
                    choice1 != ""
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "   يجب كتابة الاختيار الأول وأن يتكون من حرف واحد فقط  ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    choice2 != ''
                        ? Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Container(
                                child: Theme(
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.transparent),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  controller: myController3,
                                  autofocus: false,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      setState(() {
                                        choice2 = value;
                                      });
                                    } else {
                                      setState(() {
                                        choice2 = '';
                                      });
                                    }
                                  },
                                  style: GoogleFonts.amiri(fontSize: 15),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: ' الاختيار الثاني  ',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                  ),
                                ),
                              ),
                            )))
                        : Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25.7),
                                    border: Border.all(
                                        color: Colors.red, // set border color
                                        width: 1.5)),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      splashColor: Colors.transparent),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      controller: myController3,
                                      autofocus: false,
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          setState(() {
                                            choice2 = value;
                                          });
                                        } else {
                                          setState(() {
                                            choice2 = '';
                                          });
                                        }
                                      },
                                      style: GoogleFonts.amiri(fontSize: 15),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: ' الاختيار الثاني  ',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            left: 14.0, bottom: 8.0, top: 8.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))),
                    choice2 != ""
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "   يجب كتابة الاختيار الثاني وأن يتكون من حرف واحد فقط  ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    choice3 != ''
                        ? Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Container(
                                child: Theme(
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.transparent),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  controller: myController4,
                                  autofocus: false,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      setState(() {
                                        choice3 = value;
                                      });
                                    } else {
                                      setState(() {
                                        choice3 = '';
                                      });
                                    }
                                  },
                                  style: GoogleFonts.amiri(fontSize: 15),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: ' الاختيار الثالت  ',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                  ),
                                ),
                              ),
                            )))
                        : Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25.7),
                                    border: Border.all(
                                        color: Colors.red, // set border color
                                        width: 1.5)),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      splashColor: Colors.transparent),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      controller: myController4,
                                      autofocus: false,
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          setState(() {
                                            choice3 = value;
                                          });
                                        } else {
                                          setState(() {
                                            choice3 = '';
                                          });
                                        }
                                      },
                                      style: GoogleFonts.amiri(fontSize: 15),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: ' الاختيار الثالت  ',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            left: 14.0, bottom: 8.0, top: 8.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))),
                    choice3 != ""
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "   يجب كتابة الاختيار الثالث وأن يتكون من حرف واحد فقط  ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    answer != ""
                        ? Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Container(
                                child: Theme(
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.transparent),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  controller: myController5,
                                  autofocus: false,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      setState(() {
                                        answer = value;
                                      });
                                    } else {
                                      setState(() {
                                        answer = '';
                                      });
                                    }
                                  },
                                  style: GoogleFonts.amiri(fontSize: 15),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: '  الحرف الصحيح ',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                  ),
                                ),
                              ),
                            )))
                        : Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25.7),
                                    border: Border.all(
                                        color: Colors.red, // set border color
                                        width: 1.5)),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      splashColor: Colors.transparent),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      controller: myController5,
                                      autofocus: false,
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          setState(() {
                                            answer = value;
                                          });
                                        } else {
                                          setState(() {
                                            answer = '';
                                          });
                                        }
                                      },
                                      style: GoogleFonts.amiri(fontSize: 15),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: '  الحرف الصحيح ',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            left: 14.0, bottom: 8.0, top: 8.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))),
                    answer != ""
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "   يجب كتابة الحرف الصحيح وأن يتكون من حرف واحد فقط  ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    isValidImage
                        ? Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .white, //background color of button
                                    side: BorderSide(
                                        width: 3,
                                        color: Colors
                                            .white), //border width and color
                                    elevation: 1, //elevation of button
                                    shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: EdgeInsets.all(
                                        0) //content padding inside button
                                    ),
                                onPressed: () {
                                  setState(() {
                                    picked = false;
                                  });
                                  getImage();
                                },
                                child: !widget.flag
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Center(child: MyHomePage()),
                                          Text(
                                              "   أرفق ملف الصورة الخاصة بالسؤال ",
                                              style: GoogleFonts.amiri(
                                                  fontSize: 15,
                                                  color: Colors.grey[600])),
                                          Icon(Icons.photo_album,
                                              color: Colors.grey[600]),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Center(child: MyHomePage()),
                                          Text(myController5.text,
                                              style: GoogleFonts.amiri(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        ],
                                      )))
                        : Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      Colors.white, //background color of button
                                  side: BorderSide(
                                      width: 1.5,
                                      color:
                                          Colors.red), //border width and color
                                  elevation: 1, //elevation of button
                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.all(
                                      0) //content padding inside button
                                  ),
                              onPressed: getImage,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Center(child: MyHomePage()),
                                  Text(
                                    "   أرفق ملف الصورة الخاصة بالسؤال ",
                                    style: GoogleFonts.amiri(
                                        fontSize: 15, color: Colors.grey[600]),
                                  ),
                                  Icon(
                                    Icons.photo_album,
                                    color: Colors.grey[600],
                                  ),
                                ],
                              ),
                            )),
                    isValidImage
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "يجب اختيار صورة  ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    description != ""
                        ? Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Container(
                                child: Theme(
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.transparent),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  controller: myController6,
                                  autofocus: false,
                                  style: GoogleFonts.amiri(fontSize: 15),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'الكلمة الخاصة بالصورة   ',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                  ),
                                  onFieldSubmitted: (value) {
                                    //Validator
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      description = value;
                                    });
                                  },
                                ),
                              ),
                            )))
                        : Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25.7),
                                  border: Border.all(
                                      color: Colors.red, // set border color
                                      width: 1.5), // set border width
                                  // set rounded corner radius
                                ),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      splashColor: Colors.transparent),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      controller: myController6,
                                      autofocus: false,
                                      style: GoogleFonts.amiri(fontSize: 15),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'الكلمة الخاصة بالصورة   ',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            left: 14.0, bottom: 8.0, top: 8.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(25.7),
                                        ),
                                      ),
                                      onFieldSubmitted: (value) {
                                        //Validator
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          description = value;
                                        });
                                      },
                                      // validator: (value) {
                                      //   if (value.isEmpty) {
                                      //     return ' أدخل وصف الصورة ';
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                  ),
                                ))),
                    description != ""
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "يجب كتابة وصف الصورة ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:
                                  Colors.blueGrey, //background color of button
                              side: BorderSide(
                                  width: 3,
                                  color:
                                      Colors.blueGrey), //border width and color
                              elevation: 3, //elevation of button
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius: BorderRadius.circular(30)),
                              // padding: EdgeInsets.all(10) //content padding inside button
                            ),
                            onPressed: () {
                              // if (!isValid || !isValidImage) {
                              //   setState(() {
                              //     preview = false;
                              //   });
                              // } else {
                              if (myController1.text != '' &&
                                  myController2.text != '' &&
                                  myController3.text != '' &&
                                  myController4.text != '' &&
                                  myController6.text != '') {
                                if (widget.flag) {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          Preview1(
                                        title: myController1.text,
                                        word: myController6.text,
                                        imageName: '${myController5.text}Type1',
                                        choice1: myController2.text,
                                        choice2: myController3.text,
                                        choice3: myController4.text,
                                        answer: widget.answer,
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          Preview1(
                                        title: myController1.text,
                                        word: myController6.text,
                                        imageName: '${myController5.text}Type1',
                                        choice1: myController2.text,
                                        choice2: myController3.text,
                                        choice3: myController4.text,
                                        answer: myController5.text,
                                      ),
                                    ),
                                  );
                                }
                              }

                              //code to execute when this button is pressed.
                            },
                            child: Text(
                              "   معاينة التمرين قبل النشر",
                              style: GoogleFonts.amiri(
                                  fontSize: 18, color: Colors.white),
                            ))),

                    // ? SizedBox.shrink()
                    // : Column(
                    //     children: [
                    //       SizedBox(
                    //         height: 5,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(right: 0),
                    //         child: Container(
                    //           width: double.infinity,
                    //           child: Text(
                    //             "لا يمكن معاينة التمرين قبل تعبئة كافة الحقول ",
                    //             style: TextStyle(
                    //               color: Colors.red,
                    //               fontSize: 13,
                    //             ),
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:
                                  Colors.green, //background color of button
                              side: BorderSide(
                                  width: 3,
                                  color: Colors.green), //border width and color
                              elevation: 3, //elevation of button
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius: BorderRadius.circular(30)),
                              // padding: EdgeInsets.all(10) //content padding inside button
                            ),
                            onPressed: () => {_save()},
                            child: Text(
                              "    حفظ بيانات التمرين      ",
                              style: GoogleFonts.amiri(
                                  fontSize: 18, color: Colors.white),
                            ))),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ]),
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
        ));
  }
}
