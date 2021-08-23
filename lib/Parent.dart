import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class parent extends StatelessWidget {
  String id;

  parent({key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
      child: Text("In parent PPage"),
      onPressed: () {
        Navigator.pop(context);
      },
    ));
  }
}
