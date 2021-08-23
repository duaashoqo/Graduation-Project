import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class child extends StatelessWidget {
  String code;
  child({this.code});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
      child: Text("In child PPage"),
      onPressed: () {
        Navigator.pop(context);
      },
    ));
  }
}
