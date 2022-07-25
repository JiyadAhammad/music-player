import 'package:hive_flutter/hive_flutter.dart';
part 'songmodel.g.dart';

@HiveType(typeId: 1)
class Songs extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  List<String>? path;
  @HiveField(2)
  String? songtitle;
  Songs({
    this.id,
    required this.path,
    this.songtitle,
  });
}
