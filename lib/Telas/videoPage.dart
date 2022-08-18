import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube/model/Video.dart';

class VideoPage extends StatefulWidget {
  static String _idVideo = '';
  Video video;
  String id = '';
  String url;

  VideoPage(this.id, this.video, this.url, {super.key});

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
      body: Container(
        padding: EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _controller,
              liveUIColor: Colors.black,
              progressColors: ProgressBarColors(
                  playedColor: Colors.red,
                  bufferedColor: Colors.black,
                  handleColor: Colors.red,
                  backgroundColor: Colors.white),
              progressIndicatorColor: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15),
              child: Text(
                widget.video.titulo!,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Text(
                widget.video.descricao!,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.network(widget.url),
            )
          ],
        ),
      ),
    );
  }
}
