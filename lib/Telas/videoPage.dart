import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
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
  static String _idVideo = '';
  late String url;

  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: VideoPage.get_idVideo,
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  Future<List<Video>> _listarVideos() {
    Api api = Api();
    Future<List<Video>> videos = api.pesquisar(widget.video.titulo!);

    return videos;
  }

  Future<String> _imagemCanal(String idCanal) async {
    Future<String> urlImg;
    Api api = Api();
    urlImg = api.img(idCanal);
    return urlImg;
  }

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
              progressColors: const ProgressBarColors(
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
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 15, right: 15, bottom: 10),
                child: Flexible(
                    child: RichText(
                  overflow: TextOverflow.visible,
                  text: TextSpan(
                      text: widget.video.descricao!,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal)),
                )) /*Text(
                widget.video.descricao!,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.normal),
              ),*/
                ),
            const Divider(
              height: 8,
              color: Color.fromARGB(80, 128, 128, 128),
              thickness: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        widget.url,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(text: widget.video.nomeCanal, style: TextStyle(fontSize: 17)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Flexible(
                flex: 3,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: const Text("INSCREVER-SE",
                        style: TextStyle(color: Colors.red, fontSize: 20)),
                ),
                    )),
              ],
            ),
            const Divider(
              height: 8,
              color: Color.fromARGB(80, 128, 128, 128),
              thickness: 5,
            ),
            Expanded(
              child: FutureBuilder<List<Video>>(
                  future: _listarVideos(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            List<Video>? videos = snapshot.data;
                            Video video = videos![index];
                            return GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _idVideo = video.id!;
                                  VideoPage.set_idVideo = _idVideo;
                                });
                                url = await _imagemCanal(video.canal!);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoPage(_idVideo, video, url)));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                video.imagem.toString()))),
                                  ),
                                  ListTile(
                                    title: Text(video.titulo.toString()),
                                    subtitle: Text(video.nomeCanal.toString()),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Padding(
                            padding: EdgeInsets.only(bottom: 17),
                          ),
                          itemCount: snapshot.data!.length,
                        )
                      : const Center(child: CircularProgressIndicator())),
            )
          ],
        ),
      ),
    );
  }
}
