import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

//import 'package:dio/dio.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:admin_kg1/ip_address.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

class newLesson extends StatefulWidget {
  String title;
  String sub;
  String calssName;
  String videoName;

  newLesson({key, this.title, this.sub, this.calssName}) : super(key: key);

  @override
  State<newLesson> createState() => _MyAppState();
}

class _MyAppState extends State<newLesson> {
  final myController1 = TextEditingController();

  File selectedfile;
  Response response;
  String progress;
  var picked = false;
  var isValidVideo = true;
  var title = "-";
  var isValid = false;
  Dio dio = new Dio();
  selectFile() async {
    selectedfile = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'WEBM'],
      //allowed extension to choose
    );

    setState(() {}); //update the UI so that file name is shown
  }

  // selectFile() async {
  //   selectedfile = await FilePicker.getFile(
  //     type: FileType.custom,
  //     allowedExtensions: ['mp4', 'WEBM'],
  //     //allowed extension to choose
  //   );

  //   setState(() {
  //     if (pickedFile != null) {
  //     picked = true;
  //     _image = File(pickedFile.path);
  //      _uploadImage();
  //     isValidVideo = true;
  //      }
  //   }); //update the UI so that file name is shown
  // }

  uploadFile() async {
    String uploadurl = "http://10.0.2.2/flutter_test/upload_video.php";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(selectedfile.path,
          filename: "${myController1.text}"
          //show only filename from path
          ),
    });

    response = await dio.post(
      uploadurl,
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent / total * 100).toStringAsFixed(2);
        setState(() {
          progress = "$sent" +
              " Bytes of " "$total Bytes - " +
              percentage +
              " % uploaded";
          //update the progress
        });
      },
    );

    if (response.statusCode == 200) {
      print(response.toString());
      //print response from server
    } else {
      print("Error during connection to server.");
    }
  }

  Future<void> _save() async {
    if (title == "-") {
      print(":::");
      setState(() {
        title = "";
      });
    }

    if (picked == false) {
      setState(() {
        isValidVideo = false;
      });
    }
    isValid = isValidVideo && title != "";

    if (!isValid) {
      return;
    } else {
      print(myController1.text);

      print(widget.sub);
      print("looooooooool");
      Map decoded = {};

      final response = await http.post(Uri.parse('${IP}save_lesson'), body: {
        'video_name': myController1.text,
        'subject_name': widget.sub,
        'class_name': widget.calssName,
      });

      decoded = json.decode(response.body) as Map<String, dynamic>;
      decoded = json.decode(response.body) as Map<String, dynamic>;
      if (decoded['response'] == 'Error1') {
        Fluttertoast.showToast(
            msg: "الفيديو موجود بالفعل",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0);
      } else {
        Fluttertoast.showToast(
            msg: "تمت إضافة الفيديو بنجاح",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0);
        sendNotification();
      }

      // else {
      //   if (widget.videoName == myController1.text) {
      //     Fluttertoast.showToast(
      //         msg: "يجب تعديل حقل واحد على الأقل",
      //         toastLength: Toast.LENGTH_LONG,
      //         gravity: ToastGravity.CENTER,
      //         timeInSecForIosWeb: 3,
      //         backgroundColor: Colors.grey,
      //         textColor: Colors.white,
      //         fontSize: 12.0);
      //   } else {
      //     Fluttertoast.showToast(
      //         msg: "تمت تعديل الفيديو بنجاح",
      //         toastLength: Toast.LENGTH_LONG,
      //         gravity: ToastGravity.CENTER,
      //         timeInSecForIosWeb: 3,
      //         backgroundColor: Colors.grey,
      //         textColor: Colors.white,
      //         fontSize: 12.0);
      //   }
      // }
      // } else {
      //   final response = await http.post(Uri.parse('${IP}Edit_lesson'), body: {
      //    'video_name': myController1.text, 'subject_name': widget.sub,
      //     'class_name': widget.calssName,
      //   });
      //   decoded = json.decode(response.body) as Map<String, dynamic>;
      //   if (widget.videoName == myController1.text ) {
      //     Fluttertoast.showToast(
      //         msg: "يجب تعديل حقل واحد على الأقل",
      //         toastLength: Toast.LENGTH_LONG,
      //         gravity: ToastGravity.CENTER,
      //         timeInSecForIosWeb: 3,
      //         backgroundColor: Colors.grey,
      //         textColor: Colors.white,
      //         fontSize: 12.0);
      //   } else {
      //     Fluttertoast.showToast(
      //         msg: "تمت تعديل التمرين بنجاح",
      //         toastLength: Toast.LENGTH_LONG,
      //         gravity: ToastGravity.CENTER,
      //         timeInSecForIosWeb: 3,
      //         backgroundColor: Colors.grey,
      //         textColor: Colors.white,
      //         fontSize: 12.0);
      //   }

      //   Fluttertoast.showToast(
      //       msg: "تمت تعديل التمرين بنجاح",
      //       toastLength: Toast.LENGTH_LONG,
      //       gravity: ToastGravity.CENTER,
      //       timeInSecForIosWeb: 3,
      //       backgroundColor: Colors.grey,
      //       textColor: Colors.white,
      //       fontSize: 12.0);
      //   // sendNotification();

      // }

    }

    setState(() {
      myController1.text = '';
      isValid = false;
      isValidVideo = true;
      picked = false;
      title = "-";
    });
  }

  sendNotification() {
    String msg = "تمت اضافة فيديو جديد";
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
  void initState() {
    myController1.text = widget.videoName;

    picked = true;
    title = widget.title;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(".............................................");
    print(widget.sub);
    print(widget.title);

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
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
                                          Icons.videocam_off,
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
                            : Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                        width: queryData.size.width * 0.8,
                                        height: queryData.size.height * 0.08,
                                        child: Text(
                                          //video name
                                          myController1.text + ".mp4",
                                          style: GoogleFonts.amiri(
                                            // decoration: TextDecoration.underline,
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        )),
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
                                    hintText: ' عنوان الدرس  ',
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
                                        hintText: ' عنوان الدرس  ',
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
                                    "يجب كتابة عنوان الدرس ",
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
                    isValidVideo
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
                                  selectFile();
                                  uploadFile();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Center(child: MyHomePage()),
                                    Text("   أرفق ملف الفيديو الخاص بالدرس    ",
                                        style: GoogleFonts.amiri(
                                            fontSize: 15,
                                            color: Colors.grey[600])),
                                    Icon(Icons.photo_album,
                                        color: Colors.grey[600]),
                                  ],
                                )
                                // : Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.center,
                                //     children: [
                                //       // Center(child: MyHomePage()),
                                //       Text(myController1.text + ".mp4",
                                //           style: GoogleFonts.amiri(
                                //               fontSize: 15,
                                //               color: Colors.black)),
                                //     ],
                                //   )
                                ))
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
                              onPressed: () {
                                selectFile();
                                uploadFile();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Center(child: MyHomePage()),
                                  Text(
                                    "   أرفق ملف الفيدو الخاص بالدرس   ",
                                    style: GoogleFonts.amiri(
                                        fontSize: 15, color: Colors.grey[600]),
                                  ),
                                  Icon(
                                    Icons.cloud_upload,
                                    color: Colors.grey[600],
                                  ),
                                ],
                              ),
                            )),
                    isValidVideo
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "يجب اختيار فيديو  ",
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
                            onPressed: () => {_save(), sendNotification()},
                            child: Text(
                              "    حفظ بيانات الدرس      ",
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
            backgroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(widget.title,
                    style:
                        GoogleFonts.amiri(color: Colors.black, fontSize: 18)),
              ),
            ),
          ),
        ));
  }
}
