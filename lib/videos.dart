import 'package:admin_kg1/LogInChild.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import 'video.dart';

class VideoDemo extends StatefulWidget {
  List<dynamic> video_list;
  String code;
  VideoDemo({key, this.video_list, this.code}) : super(key: key);

  @override
  VideoDemoState createState() => VideoDemoState();
}

class VideoDemoState extends State<VideoDemo> {
  List<VideoPlayerController> _controller;
  Future<void> _initializeVideoPlayerFuture;
  int countt;

  @override
  void initState() {
    countt = 0;
    _controller = new List(widget.video_list.length);
    for (int i = 0; i < widget.video_list.length; i++) {
      print("hjklldddddddddddddddddddddddddddd");
      print("http://10.0.2.2/flutter_test/files/${widget.video_list[i]}.mp4");
      _controller[i] = VideoPlayerController.network(
          "http://10.0.2.2/flutter_test/files/${widget.video_list[i]}.mp4");
      print(",,,,,,,,,,,,,,,,,,,,,,,,,,,222222222222222222222222");
      //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
      _initializeVideoPlayerFuture = _controller[i].initialize();
      print("333333333333333333333333333333333333333");
      _controller[i].setLooping(true);
      print("444444444444444444444444444444444444444444");
      _controller[i].setVolume(1.0);
    }
    super.initState();
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.video_list.length; i++) {
      _controller[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    countt = 0;

    List<String> vid = [];
    for (var i = 0; i < widget.video_list.length; i++) {
      vid.add(widget.video_list[i]);
    }
    var size = MediaQuery.of(context).size;
    final double height = 155;
    final double width = (size.width) / 2;

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
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: width / height,
                        controller:
                            new ScrollController(keepScrollOffset: false),

                        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 2, mainAxisSpacing: 10),
                        // itemCount: widget.video_list.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: vid.map((String value) {
                          print("hellllo");
                          print(countt);
                          int x = countt;
                          countt++;

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 3.0, right: 3, top: 15, bottom: 0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    var route = new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new video(
                                        Video: value,
                                      ),
                                    );
                                    Navigator.of(context).push(route);
                                  },
                                  child: Container(
                                    height: 100,
                                    child: FutureBuilder(
                                      future: _initializeVideoPlayerFuture,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Center(
                                            child: AspectRatio(
                                              aspectRatio: _controller[x]
                                                  .value
                                                  .aspectRatio,
                                              child:
                                                  VideoPlayer(_controller[x]),
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
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  value,
                                  style: GoogleFonts.amiri(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
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
                        "دروسي المضافة",
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
  }
}


//  appBar: AppBar(
//           leading: new IconButton(
//             icon: new Icon(
//               Icons.arrow_back_ios_new_outlined,
//               color: Colors.black,
//               size: 18,
//             ),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           backgroundColor: Colors.white,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Text(
//                   "دروسي المضافة",
//                   style: GoogleFonts.amiri(
//                     color: Colors.black,
//                     fontSize: 20,
//                   ),
//                   textDirection: TextDirection.rtl,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: GridView.count(
//           crossAxisCount: 2,
//           childAspectRatio: width / height,
//           controller: new ScrollController(keepScrollOffset: false),

//           // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           //     crossAxisCount: 2, mainAxisSpacing: 10),
//           // itemCount: widget.video_list.length,
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           children: vid.map((String value) {
//             print("hellllo");
//             print(countt);
//             int x = countt;
//             countt++;

//             return Padding(
//               padding: const EdgeInsets.only(
//                   left: 3.0, right: 3, top: 15, bottom: 0),
//               child: Column(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       var route = new MaterialPageRoute(
//                         builder: (BuildContext context) => new video(
//                           Video: value,
//                         ),
//                       );
//                       Navigator.of(context).push(route);
//                     },
//                     child: Container(
//                       height: 100,
//                       child: FutureBuilder(
//                         future: _initializeVideoPlayerFuture,
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.done) {
//                             return Center(
//                               child: AspectRatio(
//                                 aspectRatio: _controller[x].value.aspectRatio,
//                                 child: VideoPlayer(_controller[x]),
//                               ),
//                             );
//                           } else {
//                             return Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     value,
//                     style: GoogleFonts.amiri(color: Colors.black, fontSize: 15),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),


//         ));
 
