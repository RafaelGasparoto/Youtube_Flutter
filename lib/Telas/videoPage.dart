import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube/model/Video.dart';
import 'package:youtube/Api.dart';

class VideoPage extends StatefulWidget {
  static String _idVideo = '';
  Video video;
  String id = '';

  VideoPage(this.id, this.video, {super.key});

  static set set_idVideo(String value) {
    _idVideo = value;
  }

  static String get get_idVideo => _idVideo;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

  String _imagemCanal(String idCanal) {
    String urlImg;
    Api api = Api();
    urlImg = api.img(idCanal).toString();
    return urlImg;
  }

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
          padding: const EdgeInsets.only(top: 24),
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
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Image.network(_imagemCanal(widget.video.canal!)),
              ),
            ],
          ),
        )
    );
  }
}
