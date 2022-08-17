import 'package:hive/hive.dart';
part 'musicdb.g.dart';

// @HiveType(typeId: 0)
// class Songs extends HiveObject {
//   @HiveField(0)
//   String? path;
//   @HiveField(1)
//   String? songname;
//   @HiveField(2)
//   String? artist;
//   @HiveField(3)
//   int? id;
//   Songs({
//     required this.id,
//     required this.path,
//     required this.songname,
//     required this.artist,
//   });
// }

// @HiveType(typeId: 2)
// class Favourite extends HiveObject {
//   @HiveField(0)
//   final String? favouriteAudio;
//   @HiveField(1)
//   String? songname;
//   @HiveField(2)
//   String? artist;
//   @HiveField(3)
//   int? id;

//   Favourite({
//     this.id,
//     required this.favouriteAudio,
//     this.songname,
//     this.artist,
//   });
// }

// @HiveType(typeId: 3)
// class PlaylistName extends HiveObject {
//   @HiveField(0)
//   int? id;

//   @HiveField(1)
//   String? playlistName;

//   PlaylistName({
//     this.id,
//     required this.playlistName,
//   });
// }

// @HiveType(typeId: 4)
// class PlaylistData extends HiveObject {
//   @HiveField(0)
//   String? playlistName;

//   @HiveField(1)
//   String? playlistAudio;

//   @HiveField(2)
//   String? songname;
//   @HiveField(3)
//   String? artist;
//   @HiveField(4)
//   int? id;

//   PlaylistData({
//     required this.playlistName,
//     required this.playlistAudio,
//     this.songname,
//     this.artist,
//     this.id,
//   });
// }
@HiveType(typeId: 0)
class Songs extends HiveObject {
  @HiveField(0)
  String? path;
  @HiveField(1)
  String? songname;
  @HiveField(2)
  String? artist;
  @HiveField(3)
  int? id;
  Songs({
    required this.id,
    required this.path,
    required this.songname,
    required this.artist,
  });
}

String boxname = "songs";

class StorageBox {
  static Box<List>? _box;
  static Box<List> getInstance() {
    return _box ??= Hive.box(boxname);
  }
}
