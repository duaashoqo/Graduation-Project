import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'EmailVerify2.dart';
import 'crediantial.dart';

class EmailVerify extends StatefulWidget {
  String id;
  String type;
  EmailVerify({key, this.id, this.type}) : super(key: key);

  @override
  _EmailVerifyState createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  String my_email = '';
  TextEditingController email_controller = TextEditingController();
  String reset_password_code = '';

  sendMail(my_email) async {
    String username = EMAIL;
    String password = PASS;
    final random = Random();
    reset_password_code = random.nextInt(10000).toString();

    final smtpServer = gmail(username, password);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add('${my_email}') //recipent email
      // ..recipients.add('moghaiarafeef@gmail.com')
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
      //..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
      ..subject = 'Change password' //subject of the email
      //..text =
      //'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h3>You'r reset password code is :${reset_password_code} </h3>\n<p></p>"; //body of the email

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
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      my_email = email_controller.text;
    });
    await sendMail(my_email);

    _formKey.currentState.save();
    var route = new MaterialPageRoute(
      builder: (BuildContext context) => new EmailVerify2(
          code: reset_password_code,
          email: my_email,
          id: widget.id,
          type: widget.type),
    );
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.4,
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
                      "أدخل حساب الجيميل الخاص بك لإرسال رمز إعادة تعيين كلمة السر إليه:",
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
                      controller: email_controller,

                      // decoration: InputDecoration(labelText: 'E-Mail'),
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {
                        //Validator
                      },
                      validator: (value) {
                        if (value.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Enter a valid gmail!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'example@gmail.com',
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
