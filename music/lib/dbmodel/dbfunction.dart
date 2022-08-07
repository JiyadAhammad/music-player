import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/dbmodel/songmodel.dart';
import 'package:music/screen/homescreen.dart';

import '../main.dart';

ValueNotifier<List<Songs>> musicValueNotifier = ValueNotifier([]);

// Future<void> addMusicList(Songs value) async {
//   final musicListDb = await Hive.openBox<Songs>('music_db');
//   final id = await musicListDb.add(value);
//  value.id = id;
//   musicValueNotifier.value.add(value);
//   final musicListData = Songs(path: value.path, id: id,songtitle: value.songtitle,songartist: value.songartist);
//   musicListDb.put(id, musicListData);
//   musicValueNotifier.notifyListeners();
// }

Future<void> getAllSongsDetails() async {
  final musicListDb = await Hive.openBox<Songs>('Songs_db');
  musicValueNotifier.value.clear();
  musicValueNotifier.value.addAll(musicListDb.values);
  musicValueNotifier.notifyListeners();
}



