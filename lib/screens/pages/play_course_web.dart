import 'package:bulutegitim/screens/pages/anasayfa_web.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import 'admin_videos.dart';

class Player_web extends StatefulWidget {
  late String urlName;
  Player_web(this.urlName);
  @override
  _Player_webState createState() {
    return _Player_webState(this.urlName);
  }
}

class _Player_webState extends State<Player_web> {
  late String urlName;
  _Player_webState(this.urlName);
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        '$urlName')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: IconButton(onPressed: () {
            Navigator.of(context).pop();
          },
          icon:  const Icon(Icons.arrow_back))),
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}