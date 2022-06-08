import 'dart:async';

import 'package:firebase_model/ui_sample.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HealthFy extends StatefulWidget {
  const HealthFy({Key? key}) : super(key: key);

  @override
  State<HealthFy> createState() => _HealthFyState();
}

class _HealthFyState extends State<HealthFy> {
  late VideoPlayerController videoPlayerController;
  late Future<void> videoPlayerFuture;
  bool onTouch =true;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(
        // 'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4'
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
    );
    videoPlayerFuture = videoPlayerController.initialize();
    videoPlayerController.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text('HealthFi',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    videoPlayerController.value.isPlaying
                        ? videoPlayerController.pause()
                        : videoPlayerController.play();
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.grey[300]
                      ),
                      height: 200,
                      child: FutureBuilder(
                        future: videoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return AspectRatio(
                              aspectRatio: videoPlayerController.value.aspectRatio,
                              child: ClipRRect(child: VideoPlayer(videoPlayerController),borderRadius: BorderRadius.circular(15),),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    Center(
                      child: Visibility(
                        // visible: onTouch,
                          child: Container(
                            // color: Colors.grey.withOpacity(0.5),
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<CircleBorder>(CircleBorder(side: BorderSide(color: Colors.white)))
                              ),
                              onPressed: () {
                                timer?.cancel();
                                setState(() {
                                  videoPlayerController.value.isPlaying ? videoPlayerController.pause() : videoPlayerController.play();
                                });
                                timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
                                  setState(() {
                                    onTouch = false;
                                  });
                                });
                              },
                              child: Icon(videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.white,),
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50.0,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.grey[300]
                ),
                height: 200,
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          height: 100,
          color: Colors.green,
        ),

      ),
    );
  }
}
