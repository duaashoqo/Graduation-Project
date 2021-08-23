import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'newLissonOrExc.dart';

const double fabSize = 56;

class CustomFABWidget extends StatelessWidget {
  final ContainerTransitionType transitionType;
  String title;
  String class_name;
  String calssName;
  bool flag;

  CustomFABWidget(
      {Key key,
      @required this.transitionType,
      this.title,
      this.class_name,
      this.calssName,
      this.flag})
      : super(key: key);

  @override
  Widget build(BuildContext context) => OpenContainer(
        transitionDuration: Duration(seconds: 1),
        openBuilder: (context, _) => new NewLessonOrExersize(
          title: title,
          class_name: class_name,
          calssName: calssName,
          flag: false,
        ),
        closedShape: CircleBorder(),
        closedColor: Colors.green,
        closedBuilder: (context, openContainer) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          height: fabSize,
          width: fabSize,
          child: Icon(Icons.add, color: Colors.white),
        ),
      );
}
