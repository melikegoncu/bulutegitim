import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class Player_mobile extends StatefulWidget {
  late String urlName;
  Player_mobile(this.urlName);
  @override
  _Player_mobileState createState() {
    return _Player_mobileState(this.urlName);
  }
}

class _Player_mobileState extends State<Player_mobile> {
  late String urlName;
  _Player_mobileState(this.urlName);
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
        appBar: AppBar(
          actions:[ IconButton(onPressed: () {
            Navigator.pop(context);
          },
          icon:  const Icon(Icons.arrow_back)), ]
            
        ),
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