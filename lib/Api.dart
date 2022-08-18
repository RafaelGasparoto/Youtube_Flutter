import 'auth/secrets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube/model/Video.dart';

const YOUTUBE_KEY_API ="$SECRET_YOUTUBE_API";
const ID_CANAL = "UCmEClzCBDx-vrt0GuSKBd9g";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>> pesquisar(String pesquisa, [String? videosRelacionadosId = '']) async {
    late var url;

    if(videosRelacionadosId!.isEmpty) {

      url = Uri.parse(
          "${URL_BASE}search?part=snippet&maxResults=20&key=$YOUTUBE_KEY_API&q=$pesquisa");
    }else{
      print("teste> ${videosRelacionadosId}");

      url = Uri.parse(
          "${URL_BASE}search?part=snippet&maxResults=20&key=$YOUTUBE_KEY_API&type=video&relatedToVideoId=$videosRelacionadosId");
    }
    http.Response response = await http.get(url);

    Map<String, dynamic> dadosJson = json.decode(response.body);

    List<Video> videos = dadosJson["items"].map<Video>((map) {
      return Video.fromJson(map);
    }).toList();

    return videos;
  }

  Future<String> img(String idCanal) async{

    String urlImg;
    var url = Uri.parse("${URL_BASE}channels?part=snippet&key=$YOUTUBE_KEY_API&id=$idCanal");
    http.Response response = await http.get(url);

    Map<String, dynamic> dadosJson = json.decode(response.body);
    urlImg = dadosJson["items"][0]["snippet"]["thumbnails"]["default"]["url"].toString();
    print("status: ${urlImg}");

    return urlImg;
  }
}
