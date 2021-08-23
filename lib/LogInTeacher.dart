import 'dart:convert';
import 'package:admin_kg1/teacherHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'Classes.dart';
import 'EmailVerify0.dart';
import 'ip_address.dart';

class LogInTeacher extends StatefulWidget {
  @override
  LogInTeacherState createState() => LogInTeacherState();
}

class LogInTeacherState extends State<LogInTeacher> {
  final myController = TextEditingController();
  List<dynamic> subjects;
  List<dynamic> classes;
  List<dynamic> user;

  @override
  void dispose() {
    myController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode myFocusNode;
  String id = '';
  String pass = '';
  String strError = '';
  String state = '1';
  String state2 = '1';

  String type = '0';
  bool checkValidity = true;
  bool checkEmpty = false;
  bool offPass = true;
  bool editPass = false;
  bool isSet = false;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      editPass = !editPass;
    });
  }

  Future checkUser(String id, String pass) async {
    final String apiUrl = '${IP}SignInTeacher';
    final response =
        await http.post(Uri.parse(apiUrl), body: {"id": id, "pass": pass});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        state = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        user = decoded['response'];
        state = decoded['response'][0]['state'];
        type = decoded['response'][0]['type'];
      }
    }
  }

  Future getClass(String id) async {
    final String apiUrl = '${IP}getClass';
    final response = await http.post(Uri.parse(apiUrl), body: {"id": id});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        classes = [];
        for (int i = 0; i < decoded['response'].length;) {
          print("Dddd");
          print(decoded['response']);
          if (decoded['response'].length > 1) {
            if ((decoded['response'][i]['classes'] ==
                decoded['response'][i + 1]['classes'])) {
              classes.add(decoded['response'][i]['classes']);
              i = i + 2;
              break;
            } else
              classes.add(decoded['response'][i]['classes']);
            classes.add(decoded['response'][i + 1]['classes']);
          } else
            classes.add(decoded['response'][0]['classes']);

          i = i + 2;
        }
        print(classes);
        state2 = decoded['response'][0]['state'];
      }
    }
  }

  void loginBtnPressed() async {
    setState(() {
      id = userName.text;
      pass = password.text;
    });
    if (id == "" || pass == "") {
      checkEmpty = true;
      strError = 'يجب ملىء جميع الحقول ..';
      return;
    } else {
      checkEmpty = false;
      strError = '';
    }
    if (!checkEmpty) {
      await checkUser(id, pass);
      if (type == "1") {
        await getClass(id);
        // await getSubject(id);
      }

      setState(() {
        if (user.length > 0 && state == "0") {
          if (type == "1") {
            var route = new MaterialPageRoute(
              builder: (BuildContext context) =>
                  new teacherHome(id: id, classes: classes, subjects: subjects),
            );
            Navigator.of(context).push(route);
            strError = '';
          } else if (type == "0") {
            checkValidity = false;
            strError = 'كلمة السر أو اسم المستخدم غير صحيح ';
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFe57373),
        body: new Stack(children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * .001,
              ),
              Text(
                'KG Academy',
                style: GoogleFonts.ptSans(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: TextField(
                  controller: userName,
                  style: GoogleFonts.katibeh(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'رقم المستخدم',
                    hintStyle: GoogleFonts.amiri(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    prefixIcon: Icon(Icons.remove, color: Colors.white),

                    // hintStyle: TextStyle(
                    //   fontSize: 14,
                    //   color: Colors.grey,
                    //   // fontWeight: FontWeight.bold,
                    // ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: TextField(
                  controller: password,
                  focusNode: myFocusNode,
                  obscureText: offPass,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.katibeh(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: 'كلمة السر',
                    hintStyle: GoogleFonts.amiri(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    prefixIcon: editPass
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                offPass = !offPass;
                              }); // setState
                            },
                            icon: offPass
                                ? Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  ),
                          )
                        : Icon(Icons.remove,
                            color: Color(0xffec9797).withOpacity(0.0)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  ),
                ),
              ),
              checkEmpty
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                      child: Text(
                        strError,
                        style: TextStyle(
                          // height: 2,
                          fontSize: 16,
                          color: Colors.red,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    )
                  : checkValidity
                      ? SizedBox(
                          height: 10,
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                          child: Text(
                            strError,
                            style: TextStyle(
                              // height: 2,
                              fontSize: 16,
                              color: Colors.red,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          // height: 2,
                          fontSize: 16,
                          color: Colors.red,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'هل نسيت كلمة السر؟',
                              style: GoogleFonts.amiri(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  var route = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new EmailVerify0(type: "teacher"),
                                  );
                                  Navigator.of(context).push(route);
                                  // Navigator.pushNamed(context, '/EmailVerify');
                                }),
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF1C1C1C).withOpacity(0.2),
                      spreadRadius: 7,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  child: Text(
                    "تسجيل الدخول",
                    style: GoogleFonts.amiri(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),

                    // style: GoogleFonts.katibeh(
                    //   fontSize: 16,
                    //   fontWeight: FontWeight.bold,
                    //   color: Colors.black,
                    // ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.green[600]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(
                                color: Colors.green.shade600, width: 2.0))),
                  ),
                  onPressed: loginBtnPressed,
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ]));
  }
}
