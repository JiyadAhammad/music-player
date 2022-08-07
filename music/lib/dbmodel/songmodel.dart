import 'package:hive_flutter/hive_flutter.dart';
part 'songmodel.g.dart';

@HiveType(typeId: 1)
class Songs extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? path;
  @HiveField(2)
  String? songtitle;
  @HiveField(3)
  String? songartist;

  Songs({
    this.id,
    required this.path,
    required this.songtitle,
    required this.songartist,
  });
}

@HiveType(typeId: 2)
class Favourite {
  @HiveField(0)
  final String? favouriteAudio;

  Favourite({
    this.favouriteAudio,
  });
}

@HiveType(typeId: 3)
class PlaylistName extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? playlistName;

  PlaylistName({
    this.id,
    this.playlistName,
  });
}

@HiveType(typeId: 4)
class PlaylistData extends HiveObject {
  @HiveField(0)
  String? playlistName;

  @HiveField(1)
  String? playlistAudio;

  PlaylistData({
    this.playlistName,
    this.playlistAudio,
  });
}
