import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class teacher extends StatelessWidget {
  String id;

  teacher({key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
      child: Text("In teacher PPage"),
      onPressed: () {
        Navigator.pop(context);
      },
    ));
  }
}
