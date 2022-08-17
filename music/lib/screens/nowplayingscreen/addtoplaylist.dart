// import 'package:flutter/material.dart';
// import 'package:jmusic/function/dbfunctions.dart';
// import 'package:jmusic/hivedb/musicdb.dart';
// import 'package:jmusic/main.dart';
// import 'package:jmusic/screens/Playlist/playlist.dart';
// import 'package:jmusic/screens/Playlist/widget.dart';
// import 'package:hive_flutter/adapters.dart';

// addtoPlaylistinNowpalying({context}) {
//   return showModalBottomSheet(
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(30),
//       ),
//     ),
//     builder: (context) {
//       return Container(
//         height: 350,
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//           gradient: RadialGradient(
//             colors: [
//               Color(0xFF911BEE),
//               Color(0xFF4D0089),
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 30,
//               backgroundColor: Colors.black,
//               child: IconButton(
//                 icon: const Icon(
//                   Icons.add,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (ctx) {
//                       return AlertDialog(
//                         title: const Text('Playlist Name'),
//                         content: TextFormField(
//                           controller: nameController,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Playlist Name',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, 'Cancel'),
//                             child: const Text('Cancel'),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               onOkButtonPressed(context: context);
//                             },
//                             child: const Text('OK'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             Expanded(
//               child: ValueListenableBuilder(
//                 valueListenable: playlistDb.listenable(),
//                 builder: (BuildContext context, Box<PlaylistName> value,
//                     Widget? child) {
//                   return GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 4 / 3,
//                     ),
//                     itemCount: value.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       PlaylistName? nameplaylist = playlistDb.getAt(index);
//                       return Padding(
//                         padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
//                         child: InkWell(
//                           onTap: () {
//                             Songs? allSongs = box.get(index);
//                             PlaylistData object = PlaylistData(
//                                 playlistAudio:allSongs!.path ,
//                                 playlistName: nameplaylist!.playlistName);
//                             addToPlaylist(object);
//                             // playlistdataDb.add(object);
//                             // log("${playlistdataDb.length}");
//                             Navigator.pop(context);

//                             // PlaylistData object = PlaylistData(
//                             //     playlistAudio: widget.path,
//                             //     playlistName: nameplaylist.toString());
//                             // playlistdataDb.add(object);
//                             // print(playlistdataDb.length);
//                             // Navigator.pop(context);

//                             // ScaffoldMessenger.of(context).showSnackBar( getSnackBarTwo(context: context));

//                             // <><><><><><><><><><><><><>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               border: Border.all(
//                                 color: Colors.white54,
//                                 style: BorderStyle.solid,
//                                 width: 2.5,
//                               ),
//                               color: Colors.transparent,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 nameplaylist!.playlistName.toString(),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
