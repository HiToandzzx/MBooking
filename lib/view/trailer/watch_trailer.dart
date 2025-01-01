import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart'; // For controlling system chrome (screen orientation)

class TrailerPage extends StatefulWidget {
  final String trailerUrl;

  const TrailerPage({Key? key, required this.trailerUrl}) : super(key: key);

  @override
  TrailerPageState createState() => TrailerPageState();
}

class TrailerPageState extends State<TrailerPage> {
  late YoutubePlayerController _controller;
  late bool _isFullScreen;

  @override
  void initState() {
    super.initState();
    _isFullScreen = false;

    String videoId = YoutubePlayer.convertUrlToId(widget.trailerUrl) ?? '';

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: false,
      ),
    );

    _controller.addListener(() {
      if (_controller.value.isFullScreen != _isFullScreen) {
        setState(() {
          _isFullScreen = _controller.value.isFullScreen;
        });

        if (_isFullScreen) {
          SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
        } else {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
        }
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen
          ? null
          : AppBar(
              title: const Text("Trailer"),
              backgroundColor: Colors.black,
              centerTitle: true,
            ),
      body: Column(
        children: [
          Expanded(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ),
        ],
      ),
    );
  }
}
