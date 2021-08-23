import 'package:admin_kg1/system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'first_exc.dart';
import 'ip_address.dart';

class Excersises extends StatelessWidget {
  List<dynamic> num = [];
  int c;
  String sub;
  String code;
  String className;

  Excersises({key, this.num, this.c, this.sub, this.code, this.className})
      : super(key: key);
  int count = 0;
  String title;
  String word;
  String imageName;
  String choice1;
  String choice2;
  String choice3;
  String answer;
  String imageNameS1;
  String imageNameS2;
  String imageNameS3;
  String choiceS1;
  String choiceS2;
  String choiceS3;
  String answerS1;
  String answerS2;
  String answerS3;

// getType1Info
  Future getSystem1Info(String num1, String num2, String num3) async {
    print(num);
    String apiUrl;
    var response;

    apiUrl = '${IP}getType1Info';
    response = await http.post(Uri.parse(apiUrl),
        body: {"letter": num1, "className": className});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;

        imageNameS1 = (decoded['response'][0]['imageName']);

        answerS1 = (decoded['response'][0]['answer']);
        choiceS1 = (decoded['response'][0]['answer']);
      }
      print("Sytem image");
      print(imageNameS1);
      print("Sytem answer");
      print(answerS1);
      print("Sytem choice");
      print(choiceS1);
    }

    apiUrl = '${IP}getType1Info';
    response = await http.post(Uri.parse(apiUrl),
        body: {"letter": num2, "className": className});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;

        imageNameS2 = (decoded['response'][0]['imageName']);

        answerS2 = (decoded['response'][0]['answer']);
        choiceS2 = (decoded['response'][0]['answer']);
      }
      print("Sytem image2");
      print(imageNameS2);
      print("Sytem answer2");
      print(answerS2);
      print("Sytem choice2");
      print(choiceS2);
    }

    apiUrl = '${IP}getType1Info';
    response = await http.post(Uri.parse(apiUrl),
        body: {"letter": num3, "className": className});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;

        imageNameS3 = (decoded['response'][0]['imageName']);

        answerS3 = (decoded['response'][0]['answer']);
        choiceS3 = (decoded['response'][0]['answer']);
      }
      print("Sytem image3");
      print(imageNameS3);
      print("Sytem answer3");
      print(answerS3);
      print("Sytem choice3");
      print(choiceS3);
    }
  }

  Future getType1Info(String num) async {
    print(num);
    final String apiUrl = '${IP}getType1Info';
    final response = await http
        .post(Uri.parse(apiUrl), body: {"letter": num, "className": className});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        title = (decoded['response'][0]['title']);
        word = (decoded['response'][0]['word']);
        imageName = (decoded['response'][0]['imageName']);
        choice1 = (decoded['response'][0]['choice1']);
        choice2 = (decoded['response'][0]['choice2']);
        choice3 = (decoded['response'][0]['choice3']);
        answer = (decoded['response'][0]['answer']);

        print(title);
        print(word);
        print(imageName);
        print(choice1);
        print(choice2);
        print(choice3);
        print(answer);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    count = 0;
    return Scaffold(
      body: Stack(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/sky2.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.99,
                      height: MediaQuery.of(context).size.height * 0.91,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              ),
                              itemCount: num.length + c,
                              itemBuilder: (BuildContext context, int index) {
                                if (((index + 1) % 4) != 0) {
                                  print("hello");
                                  count++;
                                  return GestureDetector(
                                    onTap: () async {
                                      print(num);
                                      print(
                                          "gggggggggggggggggggggggggggggggggggggggggggggggggg");
                                      print(index);
                                      print(num.length + c);
                                      print(num.length);
                                      if (index < 4) {
                                        await getType1Info(num[index]);
                                      } else if (index >= 4 && index <= 6) {
                                        await getType1Info(num[index - 1]);
                                      } else if (index >= 7 && index <= 9) {
                                        await getType1Info(num[index - 2]);
                                      } else if (index >= 10 && index <= 12) {
                                        await getType1Info(num[index - 2]);
                                      } else if (index >= 13 && index <= 15) {
                                        print("kkkkkkkkkkkkkkkkkkkkkkk");
                                        print(index - 3);
                                        await getType1Info(num[index - 3]);
                                      } else if (index >= 16 && index <= 18) {
                                        await getType1Info(num[index - 2]);
                                      } else if (index >= 19 && index <= 21) {
                                        await getType1Info(num[index - 2]);
                                      } else if (index >= 22 && index <= 24) {
                                        await getType1Info(num[index - 2]);
                                      } else if (index >= 25 && index <= 27) {
                                        await getType1Info(num[index - 2]);
                                      } else if (index >= 27 && index <= 29) {
                                        await getType1Info(num[index - 2]);
                                      }

                                      var route = new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new first_exc(
                                                title: title,
                                                word: word,
                                                imageName: imageName,
                                                choice1: choice1,
                                                choice2: choice2,
                                                choice3: choice3,
                                                answer: answer,
                                                isFirst: true,
                                                code: code,
                                                sub: sub),
                                      );
                                      Navigator.of(context).push(route);
                                    },
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shadowColor: Colors.black,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Stack(
                                            fit: StackFit.expand,
                                            children: <Widget>[
                                              Image(
                                                image: AssetImage(
                                                    'assets/images/${num[count - 1]}.jpg'),
                                              )
                                            ]),
                                      ),
                                    ),
                                  );
                                } else {
                                  print("kkkkkkkkkk");

                                  print(index - 1);
                                  print(index - 2);
                                  print(index - 3);

                                  return GestureDetector(
                                    onTap: () async {
                                      await getSystem1Info(num[index - 1],
                                          num[index - 2], num[index - 3]);
                                      String title;
                                      if (sub == 'عربي' || sub == 'انجليزي') {
                                        title =
                                            "اسحب الحرف الى الصورة المناسبة له";
                                      } else if (sub == 'رياضيات') {
                                        title =
                                            "اسحب العدد الى الصورة المناسبة له";
                                      }
                                      print(index);
                                      var route = new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new System_exc(
                                          title: title,
                                          imageName1: imageNameS1,
                                          imageName2: imageNameS2,
                                          imageName3: imageNameS3,
                                          choice1: choiceS3,
                                          choice2: choiceS1,
                                          choice3: choiceS2,
                                          answer1: answerS1,
                                          answer2: answerS2,
                                          answer3: answerS3,
                                        ),
                                      );
                                      Navigator.of(context).push(route);
                                    },
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shadowColor: Colors.black,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Stack(
                                            fit: StackFit.expand,
                                            children: <Widget>[
                                              Image(
                                                image: AssetImage(
                                                    'assets/images/star.gif'),
                                              )
                                            ]),
                                      ),
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
          Container(
            height: 80,
            child: AppBar(
              leading: new IconButton(
                icon: new Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.grey[800],
              title: Align(
                alignment: Alignment.bottomRight,
                child: Text("  التدريبات المضافه ",
                    style:
                        GoogleFonts.amiri(color: Colors.white, fontSize: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
