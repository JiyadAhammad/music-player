import 'package:hive/hive.dart';
part 'musicdb.g.dart';

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
