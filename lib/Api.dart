import 'auth/secrets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube/model/Video.dart';

const YOUTUBE_KEY_API = "$SECRET_YOUTUBE_KEY_API";
const ID_CANAL = "UCmEClzCBDx-vrt0GuSKBd9g";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>> pesquisar(String pesquisa) async {
    var url = Uri.parse(
        "${URL_BASE}search?part=snippet&maxResults=3&order=date&key=$YOUTUBE_KEY_API&q=$pesquisa");
    http.Response response = await http.get(url);
    Map<String, dynamic> dadosJson = json.decode(response.body);
    List<Video> videos = dadosJson["items"].map<Video>((map) {
      return Video.fromJson(map);
    }).toList();

    return videos;
  }
}
