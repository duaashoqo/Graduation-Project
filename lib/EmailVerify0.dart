import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'EmailVerify.dart';
import 'ip_address.dart';

class EmailVerify0 extends StatefulWidget {
  String id;
  String type;
  EmailVerify0({key, this.id, this.type}) : super(key: key);

  @override
  _EmailVerifyState createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify0> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  String strError = '';
  bool checkValidity = true;
  bool checkEmpty = false;
  bool is_user = false;

  TextEditingController id_controller = TextEditingController();
  String my_id;
  Future VerifyUser(String id) async {
    final String apiUrl = '${IP}VerifyID';
    final response = await http
        .post(Uri.parse(apiUrl), body: {"id": id, "type": widget.type});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(responseString);
      Map decoded = json.decode(response.body) as Map<String, dynamic>;
      print(decoded['response'][0]);
      print(decoded['response']);

      if (decoded['response'][0] == "Yes") {
        is_user = true;
      } else if (decoded['response'][0] == "No") {
        is_user = false;
      }
    }
  }

  _submit() async {
    if (my_id == '') {
      checkEmpty = true;
      strError = 'يجب كتابة رقم المستخدم..';
      return;
    }
    setState(() {
      my_id = id_controller.text;
    });
    await VerifyUser(my_id);

    if (is_user == true) {
      var route = new MaterialPageRoute(
        builder: (BuildContext context) =>
            new EmailVerify(id: my_id, type: widget.type),
      );
      Navigator.of(context).push(route);
    } else if (is_user == false) {
      checkValidity = false;
      strError = 'الرقم غير صحيح, حاول مرة أخرى ';
      print("iiiii");
    }
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
                      "أدخل رقم المستخدم الخاص بك:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: id_controller,
                      onFieldSubmitted: (value) {},
                      decoration: InputDecoration(
                        hintText: '*******',
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
