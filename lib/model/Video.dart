class Video{
  String? canal;
  String? id;
  String? titulo;
  String? descricao;
  String? imagem;
  String? canalImg;
  String? nomeCanal;

  Video({this.canal, this.id, this.titulo, this.descricao, this.imagem, this.canalImg, this.nomeCanal});

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      descricao: json["snippet"]["description"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelId"],
      nomeCanal: json["snippet"]["channelTitle"],
    );
  }
}