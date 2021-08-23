import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:assets_audio_player/playable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class System_exc extends StatefulWidget {
  String title;
  String imageName1;
  String imageName2;
  String imageName3;

  String choice1;
  String choice2;
  String choice3;
  String answer1;
  String answer2;
  String answer3;

  System_exc({
    key,
    this.title,
    this.imageName1,
    this.imageName2,
    this.imageName3,
    this.choice1,
    this.choice2,
    this.choice3,
    this.answer1,
    this.answer2,
    this.answer3,
  }) : super(key: key);

  @override
  _System4State createState() => _System4State();
}

class _System4State extends State<System_exc> {
  bool draged1 = false;
  bool draged2 = false;

  bool draged3 = false;

  @override
  Widget build(BuildContext context) {
    print("JJJJJJJJJJJjjjj");
    print(widget.title);
    print(widget.answer1);
    print(widget.answer2);
    print(widget.answer3);
    print(widget.choice1);
    print(widget.choice2);
    print(widget.choice3);
    print(widget.imageName1);
    print(widget.imageName2);
    print(widget.imageName3);

    return Scaffold(
        backgroundColor: Colors.white,
        body: new Stack(children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/sky.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.07,
                    right: MediaQuery.of(context).size.width * 0.07),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.title,
                            style: GoogleFonts.markaziText(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          //  "http://10.0.2.2/flutter_test/uploads/'${imageName}'"

                                          "http://10.0.2.2/flutter_test/uploads/${widget.imageName3}.jpg"),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            (draged3 != true)
                                ? DragTarget<String>(
                                    builder: (context,
                                        List<String> candidateData,
                                        rejectedData) {
                                      return Container(
                                        child: Center(
                                            child: Text(widget.answer3,
                                                style: GoogleFonts.markaziText(
                                                    color: Colors.grey,
                                                    fontSize: 35,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.black,
                                            ),
                                            // Make rounded corners
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      );
                                    },
                                    // onWillAccept: (data){

                                    // },
                                    onAccept: (data) {
                                      if (data == widget.answer3) {
                                        final assetsAudioPlayer =
                                            AssetsAudioPlayer();

                                        assetsAudioPlayer.open(
                                          Audio("assets/audios/music.mp3"),
                                        );
                                        setState(() {
                                          draged3 = true;
                                        });

                                        print(data);
                                        print(
                                            '..................................................');
                                        return;
                                      }
                                      final assetsAudioPlayer =
                                          AssetsAudioPlayer();
                                      assetsAudioPlayer.open(
                                        Audio("assets/audios/false.mp3"),
                                      );
                                    },
                                  )
                                : DragTarget<String>(
                                    builder: (context,
                                        List<String> candidateData,
                                        rejectedData) {
                                      return Container(
                                        child: Center(
                                            child: Text(widget.answer3,
                                                style: GoogleFonts.markaziText(
                                                    color: Colors.black,
                                                    fontSize: 35,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        decoration: BoxDecoration(
                                            color: Colors.orangeAccent,
                                            border: Border.all(
                                              width: 2,
                                              color: Colors.orangeAccent,
                                            ),
                                            // Make rounded corners
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      );
                                    },
                                    // onWillAccept: (data){

                                    // },
                                    onAccept: (data) {
                                      if (data == widget.answer3) {
                                        final assetsAudioPlayer =
                                            AssetsAudioPlayer();

                                        assetsAudioPlayer.open(
                                          Audio("assets/audios/music.mp3"),
                                        );
                                        setState(() {
                                          draged3 = true;
                                        });

                                        print(data);
                                        print(
                                            '..................................................');
                                        return;
                                      }
                                      final assetsAudioPlayer =
                                          AssetsAudioPlayer();
                                      assetsAudioPlayer.open(
                                        Audio("assets/audios/false.mp3"),
                                      );
                                    },
                                  )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          //  "http://10.0.2.2/flutter_test/uploads/'${imageName}'"

                                          "http://10.0.2.2/flutter_test/uploads/${widget.imageName2}.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            (draged2 != true)
                                ? DragTarget<String>(
                                    builder: (context,
                                        List<String> candidateData,
                                        rejectedData) {
                                      return Container(
                                        child: Center(
                                            child: Text(widget.answer2,
                                                style: GoogleFonts.markaziText(
                                                    color: Colors.grey,
                                                    fontSize: 35,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.black,
                                            ),
                                            // Make rounded corners
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      );
                                    },
                                    // onWillAccept: (data){

                                    // },
                                    onAccept: (data) {
                                      if (data == widget.answer2) {
                                        final assetsAudioPlayer =
                                            AssetsAudioPlayer();

                                        assetsAudioPlayer.open(
                                          Audio("assets/audios/music.mp3"),
                                        );
                                        setState(() {
                                          draged2 = true;
                                        });

                                        print(data);
                                        print(
                                            '..................................................');
                                        return;
                                      }
                                      final assetsAudioPlayer =
                                          AssetsAudioPlayer();
                                      assetsAudioPlayer.open(
                                        Audio("assets/audios/false.mp3"),
                                      );
                                    },
                                  )
                                : DragTarget<String>(
                                    builder: (context,
                                        List<String> candidateData,
                                        rejectedData) {
                                      return Container(
                                        child: Center(
                                            child: Text(widget.answer2,
                                                style: GoogleFonts.markaziText(
                                                    color: Colors.black,
                                                    fontSize: 35,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        decoration: BoxDecoration(
                                            color: Colors.orangeAccent,
                                            border: Border.all(
                                              width: 2,
                                              color: Colors.orangeAccent,
                                            ),
                                            // Make rounded corners
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      );
                                    },
                                    // onWillAccept: (data){

                                    // },
                                    onAccept: (data) {
                                      if (data == widget.answer2) {
                                        final assetsAudioPlayer =
                                            AssetsAudioPlayer();

                                        assetsAudioPlayer.open(
                                          Audio("assets/audios/music.mp3"),
                                        );
                                        setState(() {
                                          draged2 = true;
                                        });

                                        print(data);
                                        print(
                                            '..................................................');
                                        return;
                                      }
                                      final assetsAudioPlayer =
                                          AssetsAudioPlayer();
                                      assetsAudioPlayer.open(
                                        Audio("assets/audios/false.mp3"),
                                      );
                                    },
                                  )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          //  "http://10.0.2.2/flutter_test/uploads/'${imageName}'"

                                          "http://10.0.2.2/flutter_test/uploads/${widget.imageName1}.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            (draged1 != true)
                                ? DragTarget<String>(
                                    builder: (context,
                                        List<String> candidateData,
                                        rejectedData) {
                                      return Container(
                                        child: Center(
                                            child: Text(widget.answer1,
                                                style: GoogleFonts.markaziText(
                                                    color: Colors.grey,
                                                    fontSize: 35,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.black,
                                            ),
                                            // Make rounded corners
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      );
                                    },
                                    // onWillAccept: (data){

                                    // },
                                    onAccept: (data) {
                                      if (data == widget.answer1) {
                                        final assetsAudioPlayer =
                                            AssetsAudioPlayer();

                                        assetsAudioPlayer.open(
                                          Audio("assets/audios/music.mp3"),
                                        );
                                        setState(() {
                                          draged1 = true;
                                        });

                                        print(data);
                                        print(
                                            '..................................................');
                                        return;
                                      }
                                      final assetsAudioPlayer =
                                          AssetsAudioPlayer();
                                      assetsAudioPlayer.open(
                                        Audio("assets/audios/false.mp3"),
                                      );
                                    },
                                  )
                                : DragTarget<String>(
                                    builder: (context,
                                        List<String> candidateData,
                                        rejectedData) {
                                      return Container(
                                        child: Center(
                                            child: Text(widget.answer1,
                                                style: GoogleFonts.markaziText(
                                                    color: Colors.black,
                                                    fontSize: 35,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        decoration: BoxDecoration(
                                            color: Colors.orangeAccent,
                                            border: Border.all(
                                              width: 2,
                                              color: Colors.orangeAccent,
                                            ),
                                            // Make rounded corners
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      );
                                    },
                                    // onWillAccept: (data){

                                    // },
                                    onAccept: (data) {
                                      if (data == widget.answer1) {
                                        final assetsAudioPlayer =
                                            AssetsAudioPlayer();

                                        assetsAudioPlayer.open(
                                          Audio("assets/audios/music.mp3"),
                                        );
                                        setState(() {
                                          draged1 = true;
                                        });

                                        print(data);
                                        print(
                                            '..................................................');
                                        return;
                                      }
                                      final assetsAudioPlayer =
                                          AssetsAudioPlayer();
                                      assetsAudioPlayer.open(
                                        Audio("assets/audios/false.mp3"),
                                      );
                                    },
                                  )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),

                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.01,
                    // ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (draged3 == true && widget.choice3 == widget.answer3)
                            ? Draggable<String>(
                                feedback: Container(
                                  child: Center(
                                      child: Text(widget.choice3,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                // onDragEnd: (data){
                                //  setState{

                                //  }
                                // },
                                childWhenDragging: Container(
                                  child: Center(
                                      child: Text(widget.choice3,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.grey,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                data: widget.choice3,
                                child: Container(
                                  child: Center(
                                      child: Text(widget.choice3,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.grey,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : Draggable<String>(
                                feedback: Container(
                                  child: Center(
                                      child: Text(widget.choice3,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                childWhenDragging: Container(
                                  child: Center(
                                      child: Text(widget.choice3,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.grey,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                data: widget.choice3,
                                child: Container(
                                  child: Center(
                                      child: Text(widget.choice3,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.orange,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.12,
                        ),
                        (draged2 == true && widget.choice2 == widget.answer2)
                            ? Draggable<String>(
                                feedback: Container(
                                  child: Center(
                                      child: Text(widget.choice2,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                // onDragEnd: (data){
                                //  setState{

                                //  }
                                // },
                                childWhenDragging: Container(
                                  child: Center(
                                      child: Text(widget.choice2,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.grey,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                data: widget.choice2,
                                child: Container(
                                  child: Center(
                                      child: Text(widget.choice2,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.grey,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : Draggable<String>(
                                feedback: Container(
                                  child: Center(
                                      child: Text(widget.choice2,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                childWhenDragging: Container(
                                  child: Center(
                                      child: Text(widget.choice2,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.grey,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                data: widget.choice2,
                                child: Container(
                                  child: Center(
                                      child: Text(widget.choice2,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.orange,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.12,
                        ),
                        (draged1 == true && widget.choice1 == widget.answer1)
                            ? Draggable<String>(
                                feedback: Container(
                                  child: Center(
                                      child: Text(widget.choice1,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                // onDragEnd: (data){
                                //  setState{

                                //  }
                                // },
                                childWhenDragging: Container(
                                  child: Center(
                                      child: Text(widget.choice1,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.grey,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                data: widget.choice1,
                                child: Container(
                                  child: Center(
                                      child: Text(widget.choice1,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.grey,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : Draggable<String>(
                                feedback: Container(
                                  child: Center(
                                      child: Text(widget.choice1,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                childWhenDragging: Container(
                                  child: Center(
                                      child: Text(widget.choice1,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.grey,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                data: widget.choice1,
                                child: Container(
                                  child: Center(
                                      child: Text(widget.choice1,
                                          style: GoogleFonts.markaziText(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.orange,
                                      ),
                                      // Make rounded corners
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}
