import 'dart:ffi';

import 'package:admin_kg1/LogInChild.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class video extends StatefulWidget {
  String Video;
  video({key, this.Video}) : super(key: key);

  @override
  VideoDemoState createState() => VideoDemoState();
}

class VideoDemoState extends State<video> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        "http://10.0.2.2/flutter_test/files/${widget.Video}.mp4");
    print(",,,,,,,,,,,,,,,,,,,,,,,,,,,222222222222222222222222");
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    print("333333333333333333333333333333333333333");
    _controller.setLooping(true);
    print("444444444444444444444444444444444444444444");
    _controller.setVolume(1.0);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Yeeeeeeeeeees");
    print(widget.Video);
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/sky2.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Stack(
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.97,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Text(
                            " هيا لنتعلم " + widget.Video,
                            style: GoogleFonts.amiri(
                                color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: InkWell(
                              onTap: () {
                                print("from videoffffffffffffffffffffffffff");
                              },
                              child: Center(
                                child: FutureBuilder(
                                  future: _initializeVideoPlayerFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Center(
                                        child: AspectRatio(
                                          aspectRatio:
                                              _controller.value.aspectRatio,
                                          child: VideoPlayer(_controller),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.green,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FloatingActionButton(
                                backgroundColor: Colors.grey[800],
                                onPressed: () {
                                  setState(() {
                                    if (_controller.value.isPlaying) {
                                      _controller.pause();
                                    } else {
                                      _controller.play();
                                    }
                                  });
                                },
                                child: Icon(_controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 0),
                    ),
                  ),
                ),
              ],
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "دروسي المضافة" + '-' + widget.Video,
                        style: GoogleFonts.amiri(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //       title: Directionality(
    //     textDirection: TextDirection.rtl,
    //     child: Container(
    //       width: MediaQuery.of(context).size.width * 1,
    //       child: Text(
    //         "دروسي المضافة" + '-' + widget.Video,
    //         style: GoogleFonts.amiri(color: Colors.black, fontSize: 20),
    //       ),
    //     ),
    //   )),
    //   body: Padding(
    //     padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 0),
    //     child: Container(
    //       width: MediaQuery.of(context).size.width * 1,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.1,
    //           ),
    //           Text(
    //             " هيا لنتعلم " + widget.Video,
    //             style: GoogleFonts.amiri(color: Colors.black, fontSize: 20),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           InkWell(
    //             onTap: () {
    //               print("from videoffffffffffffffffffffffffff");
    //             },
    //             child: Center(
    //               child: FutureBuilder(
    //                 future: _initializeVideoPlayerFuture,
    //                 builder: (context, snapshot) {
    //                   if (snapshot.connectionState == ConnectionState.done) {
    //                     return Center(
    //                       child: AspectRatio(
    //                         aspectRatio: _controller.value.aspectRatio,
    //                         child: VideoPlayer(_controller),
    //                       ),
    //                     );
    //                   } else {
    //                     return Center(
    //                       child: CircularProgressIndicator(),
    //                     );
    //                   }
    //                 },
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       setState(() {
    //         if (_controller.value.isPlaying) {
    //           _controller.pause();
    //         } else {
    //           _controller.play();
    //         }
    //       });
    //     },
    //     child:
    //         Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
    //   ),
    // );
  }
}
