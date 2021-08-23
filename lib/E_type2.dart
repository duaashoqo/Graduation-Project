import 'dart:convert';
//import 'dart:html';
import 'dart:io';

import 'package:admin_kg1/main.dart';
import 'package:admin_kg1/preview2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'ip_address.dart';

//import 'package:image_picker_modern/image_picker_modern.dart';

//import "package:images_picker/images_picker.dart";

class type2 extends StatefulWidget {
  String title;
  String sub;
  String calssName;
  String exc_title;
  String answer;
  String name_of_image;
  String word;
  bool flag = false;
  type2({key, this.title, this.sub, this.calssName, this.flag})
      : super(key: key);
  type2.fromType2(
      {key,
      this.title,
      this.sub,
      this.calssName,
      this.exc_title,
      this.answer,
      this.name_of_image,
      this.word,
      this.flag})
      : super(key: key);
  @override
  State<type2> createState() => _MyAppState();
}

class _MyAppState extends State<type2> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  var picked = false;
  var isValidImage = true;
  var description = "-";
  var title = "-";
  var answer = "-";
  var isValid = false;

  Future<void> _save() async {
    if (description == "-" && title == "-" && answer == "-") {
      print(":::");
      setState(() {
        description = "";

        title = "";

        answer = "";
      });
    }

    if (picked == false) {
      // setState(() {
      isValidImage = false;
      // });
    }
    isValid = isValidImage && description != "" && title != "" && answer != '';

    if (!isValid) {
      return;
    } else {
      print("looooooooool");
      print(myController1.text);
      print(myController2.text);
      print(myController3.text);
      print(widget.sub);
      print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
      print('${myController3.text}Type2');
      Map decoded = {};
      if (widget.flag == false) {
        final response = await http.post(Uri.parse('${IP}E_type2'), body: {
          'title': myController1.text,
          "word": myController2.text,
          'hiddenChar': myController3.text,
          'Answer': myController3.text,
          'nameOfImage': '${myController3.text}Type2',
          'symbol': myController3.text,
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
        final response = await http.post(Uri.parse('${IP}EditE_type2'), body: {
          'title': myController1.text,
          "word": myController2.text,
          'hiddenChar': widget.answer,
          'Answer': widget.answer,
          'nameOfImage': '${myController3.text}Type2',
          'symbol': widget.answer,
          'sub': widget.sub,
          'class_name': widget.calssName,
        });
        decoded = json.decode(response.body) as Map<String, dynamic>;
        if (widget.exc_title == myController1.text &&
            widget.word == myController2.text &&
            widget.answer == myController3.text &&
            widget.name_of_image == myController3.text + "Type2") {
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

        // sendNotification();

      }
    }
    setState(() {
      if (!widget.flag) {
        myController1.text = '';
        myController2.text = '';
        myController3.text = '';
        isLoading = false;
        isValid = false;
        isValidImage = true;
        picked = false;
        description = "-";
        title = "-";
        answer = "-";
      }
    });
  }

  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        picked = true;
        _image = File(pickedFile.path);
        _uploadImage();
        isValidImage = true;
      }
    });
  }

  Future<String> _uploadImage() async {
    String uploadurl = 'http://10.0.2.2/flutter_test/uploadImage.php';
    List<int> imageBytes = _image.readAsBytesSync();
    // print(_image.path);
    String baseimage = base64Encode(imageBytes);
    String uniqueImageID = '${myController3.text}Type2';
    var response = await http.post(Uri.parse(uploadurl), body: {
      'image': baseimage,
      'name': uniqueImageID,
    });

    print(json.decode(response.body));
    //this.isImageChanged = true;
    return uniqueImageID;
  }

  sendNotification() {
    String msg = "تمت اضافه التمرين الثاني لحرف ال${myController3.text}";
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

    super.dispose();
  }

  @override
  void initState() {
    if (widget.flag == true) {
      print("Fromm init");
      print(widget.exc_title);
      print(widget.answer);
      print(widget.word);

      myController1.text = widget.exc_title;
      myController3.text = widget.answer;
      myController2.text = widget.word;
      picked = true;
      description = widget.word;
      title = widget.exc_title;
      answer = widget.answer;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * 0.5;

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    queryData.size.width;
    double a = queryData.size.height * 0.5;
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      SingleChildScrollView(
                          child: picked == false
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
                                            Icons.image_not_supported_outlined,
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
                              //photo selected by user
                              : widget.flag == true
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
                                                        "http://10.0.2.2/flutter_test/uploads/${'${myController3.text}Type2'}.jpg"),
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
                                  ),
                                ),
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
                                              left: 14.0,
                                              bottom: 8.0,
                                              top: 8.0),
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
                      // myController2
                      description != ""
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: Container(
                                  child: Theme(
                                data: Theme.of(context)
                                    .copyWith(splashColor: Colors.transparent),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    controller: myController2,
                                    autofocus: false,
                                    style: GoogleFonts.amiri(fontSize: 15),
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText:
                                          ' الكلمة الخاصة بالصورة بدون الحرف المراد كتابته ',
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
                                    onChanged: (value) {
                                      setState(() {
                                        description = value;
                                      });
                                    },
                                  ),
                                ),
                              )))
                          : Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
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
                                        controller: myController2,
                                        autofocus: false,
                                        style: GoogleFonts.amiri(fontSize: 15),
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText:
                                              ' الكلمة الخاصة بالصورة  بدون الحرف المراد كتابته  ',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.7),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0,
                                              bottom: 8.0,
                                              top: 8.0),
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
                      answer != ""
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
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
                                      hintText: '  الحرف المراد كتابته ',
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
                                  ),
                                ),
                              )))
                          : Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
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
                                          hintText: '  الحرف المراد كتابته ',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.7),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0,
                                              bottom: 8.0,
                                              top: 8.0),
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
                                  onPressed: getImage,
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
                                            Text(myController3.text + ".jpg",
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
                                    primary: Colors
                                        .white, //background color of button
                                    side: BorderSide(
                                        width: 1.5,
                                        color: Colors
                                            .red), //border width and color
                                    elevation: 1, //elevation of button
                                    shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius:
                                            BorderRadius.circular(30)),
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
                                          fontSize: 15,
                                          color: Colors.grey[600]),
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
                      Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors
                                    .blueGrey, //background color of button
                                side: BorderSide(
                                    width: 3,
                                    color: Colors
                                        .blueGrey), //border width and color
                                elevation: 3, //elevation of button
                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(30)),
                                // padding: EdgeInsets.all(10) //content padding inside button
                              ),
                              onPressed: () {
                                if (myController1.text != '' &&
                                    myController2.text != '' &&
                                    myController3.text != '') {
                                  if (widget.flag) {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            Preview2(
                                          title: myController1.text,
                                          word: myController2.text,
                                          imageName:
                                              '${myController3.text}Type2',
                                          answer: widget.answer,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            Preview2(
                                          title: myController1.text,
                                          word: myController2.text,
                                          imageName:
                                              '${myController3.text}Type2',
                                          answer: myController3.text,
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
                                    color:
                                        Colors.green), //border width and color
                                elevation: 3, //elevation of button
                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(30)),
                                // padding: EdgeInsets.all(10) //content padding inside button
                              ),
                              onPressed: () => {_save(), sendNotification()},
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
