import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class subjectChat extends StatefulWidget {
  String subjectname;
  String classname;
  String id;
  String userName;

  subjectChat(
      {Key key, this.classname, this.subjectname, this.id, this.userName})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<subjectChat> {
  String groupChatId;
  String userID;
  String anotherUserId;
  String subject;

  TextEditingController textEditingController = TextEditingController();

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    getGroupChatId();
    if (widget.subjectname == 'عربي') {
      subject = 'اللغة العربية';
    } else if (widget.subjectname == 'رياضيات') {
      subject = 'الرياضيات ';
    } else if (widget.subjectname == 'انجليزي') {
      subject = 'اللغة الانجليزية ';
    }
    super.initState();
  }

  getGroupChatId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    userID = widget.classname;
    anotherUserId = widget.subjectname;
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
    print(
        ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
    print(widget.userName);
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'المحادثة الجماعيه الخاصة بمادة ${subject}',
                style: GoogleFonts.amiri(color: Colors.black, fontSize: 20),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
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

                          // child: TextField(
                          //   controller: textEditingController,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.green,
                          size: 30,
                        ),
                        onPressed: () =>
                            {sendMsg(), textEditingController.text = ""},
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
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
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
      print(widget.id);
      print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(ref, {
          "senderId": widget.id,
          "anotherUserId": anotherUserId,
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          'content': msg,
          'sendername': widget.userName,
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

//  ${doc['sendername']}
  buildItem(doc) {
    return Row(
      // padding: EdgeInsets.only(
      //     top: 8.0,
      //     left: ((doc['senderId'] == widget.id) ? 185 : 0),
      //     right: ((doc['senderId'] == widget.id) ? 0 : 185),
      //     bottom: 10),
      mainAxisAlignment: (doc['senderId'] == widget.id)
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Column(
          children: [
            (doc['senderId'] == widget.id)
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("أنا",
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.amiri(
                                color: Colors.black,
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
                        Text("   ${doc['sendername']} ",
                            style: GoogleFonts.amiri(
                                color: Colors.black,
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
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  left: 12.0, right: 20.0, top: 12.0, bottom: 12.0),
              constraints: BoxConstraints(maxWidth: 250),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  color: ((doc['senderId'] == widget.id)
                      ? Colors.green[400]
                      : Colors.white),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Text(
                '${doc['content']}',
                style: (doc['senderId'] == widget.id)
                    ? GoogleFonts.amiri(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)
                    : GoogleFonts.amiri(
                        color: Colors.green,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
