import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  static String _idVideo = '';
  String id = '';

  VideoPage(this.id, {super.key});

  static set set_idVideo(String value) {
    _idVideo = value;
  }

  static String get get_idVideo => _idVideo;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: VideoPage.get_idVideo,
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: YoutubePlayer(
      controller: _controller,
      liveUIColor: Colors.amber,
    ));
  }
}
