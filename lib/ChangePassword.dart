import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'LogInParent.dart';
import 'LogInTeacher.dart';
import 'ip_address.dart';

class ChangePassword extends StatefulWidget {
  String id;
  String type;
  ChangePassword({key, this.id, this.type}) : super(key: key);

  @override
  _EmailVerifyState createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<ChangePassword> {
  TextEditingController password = TextEditingController();
  TextEditingController repeated_password = TextEditingController();

  FocusNode myFocusNode1;
  FocusNode myFocusNode2;

  bool offPass1 = true;
  bool offPass2 = true;
  bool editPass1 = false;
  bool editPass2 = false;
  String Mypass = '';

  // bool editPass2 = false;

  void initState() {
    super.initState();

    myFocusNode1 = FocusNode();
    myFocusNode1.addListener(() {
      editPass1 = !editPass1;
      // editPass2 = false;
    });
    myFocusNode2 = FocusNode();
    myFocusNode2.addListener(() {
      // editPass1 = false;
      editPass2 = !editPass2;
    });
  }

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  Future UpdatePassword(String pass) async {
    final String apiUrl = '${IP}UpdatePassword';
    final response = await http.post(Uri.parse(apiUrl),
        body: {"pass": pass, "id": widget.id, "type": widget.type});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "Error") {
        print("Error");
      } else {
        print(responseString);
      }
    }
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    if (password.text == repeated_password.text) {
      setState(() {
        Mypass = password.text;
      });
    }
    await UpdatePassword(Mypass);
    var route;
    if (widget.type == 'teacher') {
      route = new MaterialPageRoute(
        builder: (BuildContext context) => new LogInTeacher(),
      );
    }
    if (widget.type == 'parent') {
      route = new MaterialPageRoute(
        builder: (BuildContext context) => new LogInParent(),
      );
    }

    Navigator.of(context).push(route);

    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
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
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      "كلمة السر الجديدة",
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
                      controller: password,
                      focusNode: myFocusNode1,
                      obscureText: offPass1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'اكتب كلمة السر هنا',
                        suffixIcon: editPass1
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    offPass1 = !offPass1;
                                  }); // setState
                                },
                                icon: offPass1
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
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'يجب كتابة كلمة السر';
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      "إعادة كلمة السر ",
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
                      controller: repeated_password,
                      focusNode: myFocusNode2,
                      obscureText: offPass2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'اكتب كلمة السر هنا',
                        suffixIcon: editPass2
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    offPass2 = !offPass2;
                                  }); // setState
                                },
                                icon: offPass2
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
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'يجب كتابة كلمة السر';
                        }
                        if (password.text != repeated_password.text) {
                          return "كلمتا السر غير متطابقتان";
                        }
                        return null;
                      },
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
