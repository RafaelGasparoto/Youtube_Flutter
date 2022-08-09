import 'package:flutter/material.dart';
import '../Api.dart';
import '../model/Video.dart';

class Inicio extends StatefulWidget {
  String pesquisa;

  Inicio(this.pesquisa);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  Future<List<Video>> _listarVideos(String pesquisa) {
    Api api = Api();
    Future<List<Video>> videos = api.pesquisar(pesquisa);

    return videos;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
        future: _listarVideos(widget.pesquisa),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  List<Video>? videos = snapshot.data;
                  Video video = videos![index];
                  return Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(

                          image: DecorationImage(fit: BoxFit.cover,image: NetworkImage(video.imagem.toString()))
                        ),
                      ),
                      ListTile(
                        title: Text(video.titulo.toString()),
                        subtitle: Text(video.canal.toString()),
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(
                  height: 3,
                  color: Colors.red,
                ),
                itemCount: snapshot.data!.length,
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
