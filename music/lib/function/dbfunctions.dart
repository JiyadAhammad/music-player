// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:jmusic/hivedb/function.dart';
// import 'package:jmusic/hivedb/musicdb.dart';
// import 'package:jmusic/main.dart';
// import 'package:jmusic/screens/Playlist/playlist.dart';
// import 'package:jmusic/screens/homescreen/homescreen.dart';

// addToFavourite({
//   required path,
//   required songname,
//   required songartist,
// }) async {
//   List<Favourite> favList = favouriteDb.values.toList();
//   List<Favourite> pathresult = favList
//       .where(
//         (checkingpath) => checkingpath.favouriteAudio == path,
//       )
//       .toList();
//   List<Favourite> nameResult = favList
//       .where(
//         (checkingName) => checkingName.songname == songname,
//       )
//       .toList();
//   List<Favourite> artistResult = favList
//       .where(
//         (checkingAritist) => checkingAritist.artist == songartist,
//       )
//       .toList();
//   log("$songname song name get" );
//   log("$nameResult stored in db");
//   if (pathresult.isEmpty) {
//     var favobj = Favourite(
//       favouriteAudio: path,
//       songname: songname,
//       artist: songartist,
//     );
//     favouriteDb.add(favobj);
//   } else {
//     boolfav = true;
//   }
// }

// getsnackbar({
//   required context,
// }) {
//   if (boolfav == true) {
//     showsnackbar = SnackBar(
//       content: const Text(
//         'Already added in favourites',
//       ),
//       action: SnackBarAction(
//         label: 'OK',
//         onPressed: () {},
//       ),
//     );
//   } else {
//     showsnackbar = SnackBar(
//       content: const Text(
//         'Added',
//       ),
//       action: SnackBarAction(
//         label: 'OK',
//         onPressed: () {},
//       ),
//     );
//   }
//   ScaffoldMessenger.of(context).showSnackBar(showsnackbar);
// }

// // getplaylistsatus({required String playlistpath}) {
// //   List<PlaylistData> textplaylist = playlistdataDb.values.toList();
// //   List<PlaylistData> result = textplaylist
// //       .where((checking) => checking.playlistName == playlistpath)
// //       .toList();
// //   if (result.isEmpty) {
// //     return false;
// //   } else {
// //     return true;
// //   }
// // }
// addtoPlaylist() async {
//   final playlistvalue = PlaylistName(
//     playlistName: palyListNameValidate,
//   );
//   final id = await playlistDb.add(
//     playlistvalue,
//   );
//   playlistvalue.id = id;
//   playlistDb.put(id, playlistvalue);
//   // musicValueNotifier.value.add(playlistvalue);
//   // log("$id id of playlist name");
// }

// deletePlaylist({
//   required String playlistAudioName,
//   required int index,
// }) {
//   playlistDb.deleteAt(index); //playlist name delete from db
// }

// checkPlaylistExists(value) {
//   List<PlaylistName> currentList = playlistDb.values.toList();
//   var contains = currentList.where(
//     (element) => element.playlistName == value,
//   );
//   //no duplicaate items in the list of objects
//   return contains;
// }

// editPlayDB({
//   required String oldValue,
//   required String newValue,
// }) {
//   final Map<dynamic, PlaylistName> playlistNameMap = playlistDb.toMap();
//   dynamic desiredKey;
//   playlistNameMap.forEach(
//     (key, value) {
//       if (value.playlistName == oldValue) desiredKey = key;
//     },
//   );
//   final playlistObj = PlaylistName(
//     playlistName: newValue,
//   );
//   playlistDb.put(
//     desiredKey,
//     playlistObj,
//   ); //playlist name changed successfully
// }
// addToPlaylist(PlaylistData datainPlyalist) {
//     List<PlaylistData> currentList = playlistdataDb.values.toList();
//     var contains = currentList.where((element) =>
//         element.playlistName == datainPlyalist.playlistName &&
//         element.playlistAudio == datainPlyalist.playlistAudio);
//     if (contains.isNotEmpty) {
//       return false;
//     } else {
//       playlistdataDb.add(datainPlyalist);
//       return true;
//     }
//   }

