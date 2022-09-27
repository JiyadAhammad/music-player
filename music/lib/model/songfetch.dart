class MusicListData {
  MusicListData(
      {this.albums,
      this.artist,
      this.duration,
      this.id,
      this.path,
      this.title});

  MusicListData.fromJson(Map<String, dynamic> json) {
    albums = json['albums'] as String;
    artist = json['artist'] as String;
    duration = json['duration'] as String;
    id = json['id'] as String;
    path = json['path'] as String;
    title = json['title'] as String;
  }
  String? albums;
  String? artist;
  String? duration;
  String? id;
  String? path;
  String? title;
}
