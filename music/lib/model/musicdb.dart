import 'package:hive/hive.dart';
part 'musicdb.g.dart';

@HiveType(typeId: 0)
class Songs extends HiveObject {
  Songs({
    required this.id,
    required this.path,
    required this.songname,
    required this.artist,
  });
  @HiveField(0)
  String? path;
  @HiveField(1)
  String? songname;
  @HiveField(2)
  String? artist;
  @HiveField(3)
  int? id;
}

String boxname = 'songs';

class StorageBox {
  static Box<List<dynamic>>? _box;
  static Box<List<dynamic>> getInstance() {
    return _box ?? Hive.box(boxname);
  }
}
