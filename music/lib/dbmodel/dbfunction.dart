import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/dbmodel/songmodel.dart';

ValueNotifier<List<Songs>> musicValueNotifier = ValueNotifier([]);

Future<void> addMusicList(Songs value) async {
  final musicListDb = await Hive.openBox<Songs>('music_db');
  final id = await musicListDb.add(value);
  value.id = id;
log('$id this is id ') ;

  musicValueNotifier.value.add(value);
  final musicListData = Songs(path: value.path, id: id);
  musicListDb.put(id, musicListData);
  log('$id id is this');
  log('musiclistlllllllllllllllllllllllllllllllll$musicListData');
  log('${musicListData.path}path in database');
  musicValueNotifier.notifyListeners();
}

Future<void> getAllSongsDetails() async {
  final musicListDb = await Hive.openBox<Songs>('music_db');
  musicValueNotifier.value.clear();
   musicValueNotifier.value.addAll(musicListDb.values);

   log('${musicListDb.length}vlues in db');
  

  musicValueNotifier.notifyListeners();
}
