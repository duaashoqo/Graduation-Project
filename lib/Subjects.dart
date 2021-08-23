import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'LessonAndExersize.dart';
import 'ip_address.dart';
// import 'NewLessonOrExersize.dart';
import 'NewLesson.dart';
import 'Students.dart';
import 'dart:convert';

class Subjects extends StatelessWidget {
  String id;
  List<dynamic> subjects;
  String thisclass;

  Subjects({key, this.id, this.subjects, this.thisclass}) : super(key: key);
  List<dynamic> students = [];
  List<dynamic> gender = [];
  List<dynamic> subjectVideos = [];
  List<dynamic> subjectExersizes = [];
  List<dynamic> subjectExersizeLetters = [];
  List<int> excersizesType = [];
  List<dynamic> solvedLetter = [];
  var count_veiwer_letters = Map();

  Future getStudent(String class_name) async {
    students = [];
    gender = [];
    final String apiUrl = '${IP}getStudent';
    final response =
        await http.post(Uri.parse(apiUrl), body: {"class_name": class_name});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;

        for (int i = 0; i < decoded['response'].length; i++) {
          students.add(decoded['response'][i]['students']);
          gender.add(decoded['response'][i]['gender']);
        }
        print(students);
      }
    }
  }

  Future getSubjectVideos(String subject, String class_name) async {
    subjectVideos = [];
    final String apiUrl = '${IP}getSubjectVideos';
    final response = await http.post(Uri.parse(apiUrl),
        body: {"subject_name": subject, "class_name": class_name});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'][0]['vid'] != '') {
          for (int i = 0; i < decoded['response'].length; i++) {
            subjectVideos.add(decoded['response'][i]['vid']);
          }
        }

        print(subjectVideos);
      }
    }
  }

  Future getSubjectExersizes(String subject, String class_name) async {
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    print(class_name);
    print(subject);

    subjectExersizes = [];
    subjectExersizeLetters = [];
    String apiUrl = '${IP}getSubjectExersizes1';
    var response = await http.post(Uri.parse(apiUrl),
        body: {"subject_name": subject, "class_name": class_name});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'][0]['type'] == 1) {
          for (int i = 0; i < decoded['response'].length; i++) {
            subjectExersizes.add(decoded['response'][i]['title']);
            subjectExersizeLetters.add(decoded['response'][i]['answer']);
            excersizesType.add(decoded['response'][i]['type']);
          }
        }
        print("raa");
        print(subjectExersizeLetters);
      }
    }

    print(subjectExersizes);
    print(subjectExersizeLetters);
  }

  Future getNumberOfVeiwer(String id, subject, String thisclass) async {
    solvedLetter = [];
    String teacher_name;
    String apiUrl = '${IP}getTeacherNamee';
    var response = await http.post(Uri.parse(apiUrl), body: {"id": id});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'][0]['name'] != []) {
          teacher_name = decoded['response'][0]['name'];
        }
        print("teacher_name");
        print(teacher_name);
      }
    }
    apiUrl = '${IP}getNumberOfVeiwer';
    response = await http.post(Uri.parse(apiUrl),
        body: {"subject_name": subject, "teacher_name": teacher_name});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        if (decoded['response'][0]['letter'] != []) {
          for (int i = 0; i < decoded['response'].length; i++) {
            solvedLetter.add(decoded['response'][i]['letter']);
          }
        }
        print("raaraaa");
        print(solvedLetter);
        count_veiwer_letters = Map();

        solvedLetter.forEach((element) {
          if (!count_veiwer_letters.containsKey(element)) {
            count_veiwer_letters[element] = 1;
          } else {
            count_veiwer_letters[element] += 1;
          }
        });

        print(count_veiwer_letters);
        // print(count_veiwer_letters['A']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = "صفوفي-${thisclass}";
    int length = subjects.length;
    bool flag = false;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  title,
                  style: GoogleFonts.amiri(color: Colors.black, fontSize: 20),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage("assets/images/sky2.png"),
                      fit: BoxFit.fill)),
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 150.0),
            ),
            ListView.builder(
              itemCount: length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: GestureDetector(
                          onTap: () async {
                            await getSubjectVideos(subjects[index], thisclass);
                            print("yesss1");
                            await getSubjectExersizes(
                                subjects[index], thisclass);
                            print("yesss2");

                            await getNumberOfVeiwer(
                                id, subjects[index], thisclass);

                            var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new LessonAndExersize(
                                        count_veiwer_letters:
                                            count_veiwer_letters,
                                        className: thisclass,
                                        id: id,
                                        title: title + '-' + subjects[index],
                                        sub_name: subjects[index],
                                        videos: subjectVideos,
                                        // exersizes: subjectExersizes,
                                        exersizesLetters:
                                            subjectExersizeLetters,
                                        exersizesType: excersizesType));
                            Navigator.of(context).push(route);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  color: Colors.black,
                                  onPressed: () async {
                                    await getSubjectVideos(
                                        subjects[index], thisclass);
                                    print("yesss1");
                                    await getSubjectExersizes(
                                        subjects[index], thisclass);
                                    print("yesss2");

                                    await getNumberOfVeiwer(
                                        id, subjects[index], thisclass);

                                    var route = new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new LessonAndExersize(
                                                count_veiwer_letters:
                                                    count_veiwer_letters,
                                                className: thisclass,
                                                id: id,
                                                title: title +
                                                    '-' +
                                                    subjects[index],
                                                sub_name: subjects[index],
                                                videos: subjectVideos,
                                                // exersizes: subjectExersizes,
                                                exersizesLetters:
                                                    subjectExersizeLetters,
                                                exersizesType: excersizesType));
                                    Navigator.of(context).push(route);
                                  },
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 20, 5),
                                        child: Text('${subjects[index]}',
                                            style: GoogleFonts.amiri(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)))),
                              ],
                            ),
                            elevation: 5,
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          ),
                        ),
                      )
                    ],
                  );
                } else if (index == length - 1) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: GestureDetector(
                          onTap: () async {
                            await getSubjectVideos(subjects[index], thisclass);
                            await getSubjectExersizes(
                                subjects[index], thisclass);
                            await getNumberOfVeiwer(
                                id, subjects[index], thisclass);
                            print('count_veiwer_letters');

                            print(count_veiwer_letters);
                            var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new LessonAndExersize(
                                        count_veiwer_letters:
                                            count_veiwer_letters,
                                        className: thisclass,
                                        id: id,
                                        title: title + '-' + subjects[index],
                                        sub_name: subjects[index],
                                        videos: subjectVideos,
                                        // exersizes: subjectExersizes,
                                        exersizesLetters:
                                            subjectExersizeLetters,
                                        exersizesType: excersizesType));
                            Navigator.of(context).push(route);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  color: Colors.black,
                                  onPressed: () async {
                                    //get subect video and excersize
                                    await getSubjectVideos(
                                        subjects[index], thisclass);
                                    await getSubjectExersizes(
                                        subjects[index], thisclass);
                                    await getNumberOfVeiwer(
                                        id, subjects[index], thisclass);
                                    print('count_veiwer_letters');

                                    print(count_veiwer_letters);
                                    var route = new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new LessonAndExersize(
                                                count_veiwer_letters:
                                                    count_veiwer_letters,
                                                className: thisclass,
                                                id: id,
                                                title: title +
                                                    '-' +
                                                    subjects[index],
                                                sub_name: subjects[index],
                                                videos: subjectVideos,
                                                // exersizes: subjectExersizes,
                                                exersizesLetters:
                                                    subjectExersizeLetters,
                                                exersizesType: excersizesType));
                                    Navigator.of(context).push(route);
                                  },
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 25, 5),
                                        child: Text('${subjects[index]}',
                                            style: GoogleFonts.amiri(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)))),
                              ],
                            ),
                            elevation: 5,
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(15, 50, 15, 5),
                          height: MediaQuery.of(context).size.height * 0.16,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: Colors.orange,
                              ),
                              onPressed: () async {
                                await getStudent(thisclass);

                                var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new Students(
                                          id: id,
                                          thistitle: title,
                                          students: students,
                                          gender: gender),
                                );
                                Navigator.of(context).push(route);
                              },
                              child: Text("استعراض الطلبة",
                                  style: GoogleFonts.amiri(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)))),
                    ],
                  );
                } else
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: GestureDetector(
                      onTap: () async {
                        //get subect video and excersize
                        await getSubjectVideos(subjects[index], thisclass);
                        await getSubjectExersizes(subjects[index], thisclass);

                        await getNumberOfVeiwer(id, subjects[index], thisclass);

                        var route = new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new LessonAndExersize(
                                    count_veiwer_letters: count_veiwer_letters,
                                    className: thisclass,
                                    id: id,
                                    title: title + '-' + subjects[index],
                                    sub_name: subjects[index],
                                    videos: subjectVideos,
                                    // exersizes: subjectExersizes,
                                    exersizesLetters: subjectExersizeLetters,
                                    exersizesType: excersizesType));
                        Navigator.of(context).push(route);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              color: Colors.black,
                              onPressed: () async {
                                //get subect video and excersize
                                await getSubjectVideos(
                                    subjects[index], thisclass);
                                await getSubjectExersizes(
                                    subjects[index], thisclass);

                                await getNumberOfVeiwer(
                                    id, subjects[index], thisclass);

                                var route = new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new LessonAndExersize(
                                            count_veiwer_letters:
                                                count_veiwer_letters,
                                            className: thisclass,
                                            id: id,
                                            title:
                                                title + '-' + subjects[index],
                                            sub_name: subjects[index],
                                            videos: subjectVideos,
                                            // exersizes: subjectExersizes,
                                            exersizesLetters:
                                                subjectExersizeLetters,
                                            exersizesType: excersizesType));
                                Navigator.of(context).push(route);
                              },
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 20, 5),
                                    child: Text('${subjects[index]}',
                                        style: GoogleFonts.amiri(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17)))),
                          ],
                        ),
                        elevation: 5,
                        margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      ),
                    ),
                  );
              },
            )
          ],
        ));
  }
}
