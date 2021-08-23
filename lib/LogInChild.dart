import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_text_field/pin_code_text_field.dart';

import 'Child.dart';
import 'child_home.dart';

import 'ip_address.dart';

class LoginChild extends StatefulWidget {
  @override
  PinPutTestState createState() => PinPutTestState();
}

class PinPutTestState extends State<LoginChild> {
  TextEditingController controller = TextEditingController();
  String code = "";
  int pinLength = 4;
  String name;
  bool hasError = false;
  bool checkEmpty = true;
  bool checkValidity = true;
  bool hide = true;
  String state = '1';
  List<dynamic> user = [];
  String type = '0';
  String errorMessage = " ";

  Future checkChildUser(String code) async {
    final String apiUrl = '${IP}CheckChildUser';
    final response = await http.post(Uri.parse(apiUrl), body: {"code": code});
    print("hhhhhhhhhhhhh");
    if (response.statusCode == 200) {
      Map decoded = json.decode(response.body) as Map<String, dynamic>;

      if (decoded['response'][0] == "NO") {
        state = "1";
      } else {
        user = decoded['response'];
        state = decoded['response'][0]['state'];
        type = decoded['response'][0]['type'];
      }
    }
  }

  Future nameOfChild(String code) async {
    final String apiUrl = '${IP}nameOfChild';
    final response = await http.post(Uri.parse(apiUrl), body: {"code": code});
    print(response);
    if (response.statusCode == 200) {
      Map decoded = json.decode(response.body) as Map<String, dynamic>;

      if (decoded['response'][0] == "NO") {
        state = "1";
      } else {
        name = decoded['response'][0]['name'];
        print(name);
        print("5555555555555555555555555555");
      }
    }
  }

  void loginBtnPressed() async {
    setState(() {
      this.code = controller.text;
    });
    if (code == "") {
      checkEmpty = true;
      errorMessage = 'يجب كتابة الكود الخاص بك ...';
      hasError = checkEmpty;

      return;
    } else {
      checkEmpty = false;
      errorMessage = '';
    }
    if (!checkEmpty) {
      await checkChildUser(code);
      await nameOfChild(code);
      setState(() {
        if (user.length > 0 && state == "0") {
          if (type == "1") {
            // Fluttertoast.showToast(
            // msg: "أهلاً بك",
            // toastLength: Toast.LENGTH_SHORT,
            // gravity: ToastGravity.CENTER,

            // timeInSecForIosWeb: 3,
            // backgroundColor: Colors.grey,
            // webBgColor: 'linear-gradient(to right, #00b09b, #96c93d)',
            // textColor: Colors.white,
            // fontSize: 12.0);
            var route = new MaterialPageRoute(
              builder: (BuildContext context) =>
                  new child_home(code: code, name: name),
            );
            Navigator.of(context).push(route);
            errorMessage = '';
          } else if (type == "0") {
            checkValidity = false;
            errorMessage = 'الكود غير صحيح,حاول مرة أخرى';
            hasError = !checkValidity;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 250.0),
              ),
              Text("أدخل الكود الخاص بك",
                  style: GoogleFonts.amiri(color: Colors.black, fontSize: 25)),
              SizedBox(
                height: 10,
              ),
              PinCodeTextField(
                autofocus: true,
                controller: controller,
                hideCharacter: hide,
                highlight: true,
                highlightColor: Colors.black,
                defaultBorderColor: Colors.black,
                hasTextBorderColor: Colors.green,
                maxLength: 4,
                hasError: hasError,
                maskCharacter: "⭐️",
                pinBoxRadius: 20,
                onTextChanged: (text) {
                  setState(() {
                    hasError = false;
                  });
                },
                onDone: (text) {},
                wrapAlignment: WrapAlignment.start,
                pinBoxDecoration:
                    ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                pinTextStyle: TextStyle(fontSize: 30.0),
                pinTextAnimatedSwitcherTransition:
                    ProvidedPinBoxTextAnimation.scalingTransition,
                pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
              ),
              !hasError
                  ? SizedBox(
                      height: 10,
                    )
                  : checkEmpty
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                          child: Text(
                            errorMessage,
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
                              height: 35,
                            )
                          : Padding(
                              padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                              child: Text(
                                errorMessage,
                                style: TextStyle(
                                  // height: 2,
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      elevation: 18.0,
                      color: Colors.green,
                      clipBehavior: Clip.antiAlias,
                      child: MaterialButton(
                        minWidth: 200.0,
                        height: 35,
                        textColor: Colors.white,
                        child: Text("تأكيد",
                            style: GoogleFonts.amiri(
                                color: Colors.white, fontSize: 18)),
                        onPressed: () {
                          loginBtnPressed();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
