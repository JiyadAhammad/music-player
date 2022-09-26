class MusicListData {
  MusicListData(
      {this.albums,
      this.artist,
      this.duration,
      this.id,
      this.path,
      this.title});
  String? albums;
  String? artist;
  String? duration;
  String? id;
  String? path;
  String? title;

  MusicListData.fromJson(Map<String, dynamic> json) {
    albums = json['albums'];
    artist = json['artist'];
    duration = json['duration'];
    id = json['id'];
    path = json['path'];
    title = json['title'];
  }
}
