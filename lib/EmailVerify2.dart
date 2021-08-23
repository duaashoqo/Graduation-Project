import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'ChangePassword.dart';
import 'crediantial.dart';

class EmailVerify2 extends StatefulWidget {
  String code;
  String email;
  String id;
  String type;

  EmailVerify2({key, this.code, this.email, this.id, this.type})
      : super(key: key);

  @override
  _EmailVerifyState createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify2> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  String user_code1 = '';
  TextEditingController code_controller = TextEditingController();
  String user_code2 = '';
  String strError = '';
  bool checkValidity = true;
  bool checkEmpty = false;

  sendMail(my_email) async {
    String username = EMAIL;
    String password = PASS;
    final random = Random();
    user_code2 = random.nextInt(10000).toString();

    final smtpServer = gmail(username, password);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add('${my_email}') //recipent email
      ..subject = 'Change password' //subject of the email
      ..html =
          "<h3>You'r reset password code is :${user_code2} </h3>\n<p></p>"; //body of the email

    try {
      Fluttertoast.showToast(
          msg: "سوف يصلك الكود الخاص بحسابك خلال دقائق",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 12.0);
      final sendReport = await send(message, smtpServer);

      print('Message sent: ' +
          sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n' +
          e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }

  Future<void> _submit() async {
    setState(() {
      user_code1 = code_controller.text;
    });
    if (user_code1 == '' || user_code2 == '') {
      checkEmpty = true;
      strError = 'يجب كتابة الكود..';
    }
    if (user_code2 != '') {
      var route = new MaterialPageRoute(
        builder: (BuildContext context) =>
            new ChangePassword(id: widget.id, type: widget.type),
      );
      Navigator.of(context).push(route);
    } else if (user_code2 == '') {
      print(widget.code);
      print(user_code1);
      if (user_code1 == widget.code) {
        var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
              new ChangePassword(id: widget.id, type: widget.type),
        );
        Navigator.of(context).push(route);
      } else {
        checkValidity = false;
        strError = 'الكود غير صحيح, حاول مرة أخرى ';
      }
    }

    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Text(
                      "أدخل الكود الخاص بحسابك:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  //styling

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: code_controller,
                      onFieldSubmitted: (value) {
                        //Validator
                      },
                      decoration: InputDecoration(
                        hintText: '****',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 3.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                        ),
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
                              fontSize: 12,
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
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            // height: 2,
                            fontSize: 12,
                            color: Colors.red,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'ألم تتلق رمزاً',
                                style: TextStyle(
                                  // height: 2,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    await sendMail(widget.email);

                                    // Navigator.pushNamed(context, '/EmailVerify');
                                  }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //box styling

                  ElevatedButton(
                    onPressed: () {
                      _submit();
                    },
                    child: Text("متابعة"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        minimumSize: Size(100, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.green))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
