import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ip_address.dart';

class ChatPage2 extends StatefulWidget {
  String id;
  String stu_name;
  String sub_name;

  ChatPage2({Key key, this.id, this.stu_name, this.sub_name}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage2> {
  String groupChatId;
  String userID;
  String anotherUserId;
  String name = '';

  TextEditingController textEditingController = TextEditingController();

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    getGroupChatId();
    super.initState();
  }

// student_name,sub_name
  Future getTeacherId(String student_name, String sub_name) async {
    userID = '';
    String Class = "";
    name = "";
    final String apiUrl = '${IP}getClassName';
    final response = await http
        .post(Uri.parse(apiUrl), body: {"student_name": student_name});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        Class = decoded['response'][0]['name'];
        print(decoded['response'][0]['name'].runtimeType);
        // print(decoded['response'][0]['id']);
        // userID = decoded['response'][0]['id'];
        // print(userID);
      }
    }
    final String apiUrl2 = '${IP}getTeacherName';
    final response2 = await http.post(Uri.parse(apiUrl2),
        body: {"class_name": Class, "sub_name": sub_name});
    if (response2.statusCode == 200) {
      final String responseString = response2.body;
      if (responseString == "NO") {
      } else {
        Map decoded = json.decode(response2.body) as Map<String, dynamic>;
        print("jjjjjjjjjjjjjjjjjjj");
        name = decoded['response'][0]['name'];
        print(decoded['response'][0]['name'].runtimeType);
        // print(decoded['response'][0]['id']);
        // userID = decoded['response'][0]['id'];
        // pri}nt(userID);
      }
    }
    final String apiUrl3 = '${IP}getTeacherId';
    final response3 =
        await http.post(Uri.parse(apiUrl3), body: {"teacher_name": name});
    if (response3.statusCode == 200) {
      final String responseString = response3.body;
      if (responseString == "NO") {
        // state3 = "1";
      } else {
        Map decoded = json.decode(response3.body) as Map<String, dynamic>;

        print(decoded['response'][0]['id']);
        userID = decoded['response'][0]['id'];
        print(userID);
      }
    }
  }

  getGroupChatId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await getTeacherId(widget.stu_name, widget.sub_name);

    anotherUserId = widget.id;
    print("chattttttttttttttttt2222222222222222222t");
    print(widget.id);
    print("userid");
    print("anotheruserid");

    if (userID.compareTo(anotherUserId) > 0) {
      groupChatId = '$userID - $anotherUserId';
    } else {
      groupChatId = '$anotherUserId - $userID';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.bottomRight,
          child: Text(' محادثة خاصة مع ${name} ',
              style: GoogleFonts.amiri(color: Colors.black, fontSize: 18)),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('messages')
            .document(groupChatId)
            .collection(groupChatId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Container(
              padding: const EdgeInsets.only(left: 8.0),
              color: Colors.grey[100],
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                    controller: scrollController,
                    itemBuilder: (listContext, index) =>
                        buildItem(snapshot.data.documents[index]),
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                  )),
                  Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextField(
                          textAlign: TextAlign.right,
                          controller: textEditingController,
                          decoration: InputDecoration(
                              hintText: 'اكتب رسالة ',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.grey[700]),
                                borderRadius: BorderRadius.circular(25),
                              )),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.green,
                          size: 30,
                        ),
                        onPressed: () => {
                          sendMsg(),
                          textEditingController.text = "",
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(
                child: SizedBox(
              height: 36,
              width: 36,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            ));
          }
        },
      ),
    );
  }

  sendMsg() {
    String msg = textEditingController.text.trim();

    /// Upload images to firebase and returns a URL

    if (msg.isNotEmpty) {
      print('thisiscalled $msg');
      var ref = Firestore.instance
          .collection('messages')
          .document(groupChatId)
          .collection(groupChatId)
          .document(DateTime.now().millisecondsSinceEpoch.toString());
      print(
          "ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg");
      print(userID);
      print(anotherUserId);

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(ref, {
          "senderId": userID,
          "anotherUserId": anotherUserId,
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          'content': msg,
          "type": 'text',
        });
      });

      scrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.bounceInOut);
    } else {
      print('Please enter some text to send');
    }
  }

  buildItem(doc) {
    return Row(
      // padding: EdgeInsets.only(
      //top: 10.0,
      // left: ((doc['senderId'] == userID) ? 185 : 0),
      // right: ((doc['senderId'] == userID) ? 0 : 185),

      // bottom: 10
      // ),
      mainAxisAlignment: (doc['senderId'] == userID)
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Column(
          children: [
            (doc['senderId'] == userID)
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("أنا",
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.amiri(
                                color: Colors.green,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("   ${name} ",
                            style: GoogleFonts.amiri(
                                color: Colors.green,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                        ),
                      ],
                    ),
                  ),
            Container(
                margin: EdgeInsets.all(5),
                // padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                    left: 12.0, right: 20.0, top: 12.0, bottom: 12.0),
                constraints: BoxConstraints(maxWidth: 250),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    color: ((doc['senderId'] == userID)
                        ? Colors.white
                        : Colors.green[400]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: (doc['senderId'] == userID)
                    ? Text(
                        '${doc['content']}',
                        style: GoogleFonts.amiri(
                          color: Colors.green[400],
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.rtl,
                      )
                    : Text('${doc['content']}',
                        style: GoogleFonts.amiri(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold))),
          ],
        ),
      ],
    );
  }
}
