import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ip_address.dart';

class ChatPage extends StatefulWidget {
  String id;
  String stu_name;
  String Pname;

  ChatPage({Key key, this.id, this.stu_name, this.Pname}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String groupChatId;
  String userID;
  String anotherUserId;

  TextEditingController textEditingController = TextEditingController();

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    getGroupChatId();
    super.initState();
  }

  Future getParentId(String stu_name) async {
    userID = '';
    final String apiUrl = '${IP}getParentId';
    final response =
        await http.post(Uri.parse(apiUrl), body: {"stu_name": stu_name});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      if (responseString == "NO") {
        // state2 = "1";
      } else {
        Map decoded = json.decode(response.body) as Map<String, dynamic>;
        print("yessssssssssssssssssssssssssssssssss");
        print(decoded['response'][0]['id'].runtimeType);
        print(decoded['response'][0]['id']);
        userID = decoded['response'][0]['id'];
        print(userID);
      }
    }
  }

  getGroupChatId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await getParentId(widget.stu_name);

    anotherUserId = widget.id;
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
          child: Text(' محادثة خاصة مع ${widget.Pname} ',
              style: GoogleFonts.amiri(color: Colors.black, fontSize: 18)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 2),
        child: StreamBuilder(
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
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ));
            }
          },
        ),
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
        //     //top: 10.0,
        //     left: ((doc['senderId'] == userID) ? 185 : 0),
        //     right: ((doc['senderId'] == userID) ? 0 : 185),
        //     bottom: 10),
        mainAxisAlignment: (doc['senderId'] == userID)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Column(
            //  mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (doc['senderId'] == userID)
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(" أنا",
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
                          Text("  ${widget.Pname} ",
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
                        topRight: Radius.circular(30),
                        //topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      )),
                  child: Text(
                    '${doc['content']}',
                    style: ((doc['senderId'] == userID)
                        ? GoogleFonts.amiri(
                            color: Colors.green[400],
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )
                        : GoogleFonts.amiri(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                    textDirection: TextDirection.rtl,
                  )),
            ],
          ),
        ]);
  }
}
