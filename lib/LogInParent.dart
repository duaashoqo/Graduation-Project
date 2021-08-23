import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'EmailVerify0.dart';
import 'ParentHome.dart';
import 'ip_address.dart';

class LogInParent extends StatefulWidget {
  @override
  LogInParentState createState() => LogInParentState();
}

class LogInParentState extends State<LogInParent> {
  final myController = TextEditingController();
  List<dynamic> user = [];
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
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
  String type = '0';
  bool checkValidity = true;
  bool checkEmpty = false;
  bool offPass = true;
  bool editPass = false;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      editPass = !editPass;
    });
  }

  Future checkUser(String id, String pass) async {
    final String apiUrl = '${IP}SignInParent';
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
      setState(() {
        if (user.length > 0 && state == "0") {
          if (type == "1") {
            var route = new MaterialPageRoute(
              builder: (BuildContext context) => new ParentHome(
                id: id,
              ),
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
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
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
              style: TextStyle(
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
              style: TextStyle(
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
                                    new EmailVerify0(type: "parent"),
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
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green[600]),
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
