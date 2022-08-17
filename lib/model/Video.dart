class Video{
  String? canal;
  String? id;
  String? titulo;
  String? descricao;
  String? imagem;
  String? canalImg;

  Video({this.canal, this.id, this.titulo, this.descricao, this.imagem, this.canalImg});

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      descricao: json["snippet"]["description"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelId"],
      canalImg: json["snippet"],
    );
  }
}