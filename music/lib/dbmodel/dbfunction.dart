

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/dbmodel/songmodel.dart';
import 'package:music/screen/homescreen.dart';

ValueNotifier<List<Songs>> musicValueNotifier = ValueNotifier([]);

// Future<void> addMusicList(Songs value) async {
//   final musicListDb = await Hive.openBox<Songs>('music_db');
//   final id = await musicListDb.add(value);
//   value.id = id;
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
// getFavourites({required Path})async{
//   final favouriteDb = await Hive.openBox<Favourite>('fav_db');

// List<Favourite> favList = favouriteDb.values.toList();
// log('$favList this is th faviurite list vaenfdoooo');
//   List<Favourite> result =
//       favList.where((checking) => checking.favouriteAudio == Path).toList();

//   if (result.isEmpty) {
//     var favobj = Favourite(favouriteAudio: Path);
//     favouriteDb.add(favobj);
//   } else {
//     boolfav = true;
//   }
// }
getsnackbar({
  required context,
}) {
  if (boolfav == true) {
    showsnackbar = SnackBar(
        content: const Text(
          'Already added in favourites',
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ));
  } else {
    showsnackbar = SnackBar(
        content: const Text(
          'Added',
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ));
  }
  ScaffoldMessenger.of(context).showSnackBar(showsnackbar);
}
