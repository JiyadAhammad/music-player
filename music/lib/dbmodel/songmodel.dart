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
class Favourite extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String? favouriteAudio;

  Favourite({
    this.favouriteAudio,
  });
}
