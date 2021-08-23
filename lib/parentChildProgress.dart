import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

//void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Stacked card carousel',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//       ),
//       home: MyHomePage(title: 'Stacked card carousel'),
//     );
//   }
// }

class MyChildPregress extends StatelessWidget {
  MyChildPregress(
      {Key key, this.title, this.symbol, this.flag1, this.flag2, this.flag3})
      : super(key: key);
  final String title;
  final List<String> symbol;
  final List<String> flag1;
  final List<String> flag2;
  final List<String> flag3;

  List<Widget> fancyCards = [];

  @override
  Widget build(BuildContext context) {
    print("lengthhhhhhhhhhhhhhhhhhhhhhhhh");
    print(symbol.length);
    if (symbol.length != 0) {
      print(symbol[0]);
      print(symbol[1]);
      for (int i = 0; i < symbol.length; i++) {
        fancyCards.add(
          FancyCard(
            image: Image.asset("assets/images/${symbol[i]}.jpg"),
            title: "",
            flag1: flag1[i],
            flag2: flag2[i],
            flag3: flag3[i],
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "مستوى ابنـي",
                  style: GoogleFonts.amiri(color: Colors.black, fontSize: 20),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ),
        body: Stack(children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/sky4.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            child: StackedCardCarousel(
              items: fancyCards,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          )
        ]),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Align(
            alignment: Alignment.bottomRight,
            child: Text("مستوى طفلي",
                style: GoogleFonts.amiri(color: Colors.black, fontSize: 20)),
          ),
        ),
        body: Stack(children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/sky.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              child: Text(
                "لم يقم ابنك بحل اي من التمارين المضافه بعد",
                style: (GoogleFonts.amiri(fontSize: 20)),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          )
        ]),
      );
    }
    ;
  }
}

class FancyCard extends StatefulWidget {
  const FancyCard(
      {Key key, this.image, this.title, this.flag1, this.flag2, this.flag3})
      : super(key: key);

  final Image image;
  final String title;
  final String flag1;
  final String flag2;
  final String flag3;

  @override
  _FancyCardState createState() => _FancyCardState();
}

class _FancyCardState extends State<FancyCard> {
  bool pressed = false;
  int percentage;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, right: 16, bottom: 0, top: 0),
        child: Column(
          children: <Widget>[
            Container(
              width: 250,
              height: 250,
              child: widget.image,
            ),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headline5,
            ),
            OutlineButton(
              child: Text(" اضغط هنا لمعرفة مستوى ابنك ",
                  style: GoogleFonts.amiri(fontSize: 15)),
              onPressed: () => {
                setState(() {
                  print(widget.flag1);
                  print(widget.flag2);
                  print(widget.flag3);

                  if (widget.flag1 == "false" &&
                      widget.flag2 == "false" &&
                      widget.flag3 == "false") {
                    percentage = 0;
                  } else if (widget.flag1 == "true" &&
                      widget.flag2 == "false" &&
                      widget.flag3 == "false") {
                    percentage = 1;
                  } else if (widget.flag1 == "true" &&
                      widget.flag2 == "true" &&
                      widget.flag3 == "false") {
                    percentage = 2;
                  } else if (widget.flag1 == "true" &&
                      widget.flag2 == "true" &&
                      widget.flag3 == "true") {
                    percentage = 3;
                  }
                  pressed = !pressed;
                })
              },
            ),
            pressed && percentage == 0
                ? Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.02,
                      bottom: MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: Column(
                      children: [
                        Text(
                          ".لم يقم ابنك بحل أي من التمارين الثلاثة المضافه لهذا الحرف ",
                          style: GoogleFonts.amiri(
                              color: Colors.black, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          ".الرجاء الاهتمام بدراسته",
                          style: GoogleFonts.amiri(
                              color: Colors.black, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ))
                : pressed && percentage == 1
                    ? Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.02,
                          bottom: MediaQuery.of(context).size.width * 0.02,
                        ),
                        child: Column(
                          children: [
                            Text(
                              ".قام ابنك بحل التمرين الأول فقط لهذا الحرف ",
                              style: GoogleFonts.amiri(
                                  color: Colors.black, fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "مستوى ابنك هو ضعيف",
                              style: GoogleFonts.amiri(
                                  color: Colors.black, fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : pressed && percentage == 2
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.02,
                              bottom: MediaQuery.of(context).size.width * 0.02,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  ".قام ابنك بحل التمرين الأول والثاني لهذا الحرف ",
                                  style: GoogleFonts.amiri(
                                      color: Colors.black, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "مستوى ابنك هو متوسط ",
                                  style: GoogleFonts.amiri(
                                      color: Colors.black, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : pressed && percentage == 3
                            ? Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width * 0.02,
                                  bottom:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      ".قام ابنك بحل جميع التمارين التابعة لهذا الحرف ",
                                      style: GoogleFonts.amiri(
                                          color: Colors.black, fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "مستوى ابنك هو ممتاز ",
                                      style: GoogleFonts.amiri(
                                          color: Colors.black, fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            : Text(""),
          ],
        ),
      ),
    );
  }
}
