// import 'package:flutter/material.dart';
// import 'package:music/hivedb/function.dart';
// import 'package:music/hivedb/musicdb.dart';
// import 'package:music/screens/splashscreen/splashscreen.dart';

// playlistAddBottomSheet({context}) {
//   return showModalBottomSheet(
//     enableDrag: true,
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
//         child: ValueListenableBuilder(
//           valueListenable: musicValueNotifier,
//           builder:
//               (BuildContext context, List<Songs> songslist, Widget? child) {
//             return ListView.builder(
//               itemCount: songslist.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   onTap: () {},
//                   leading: const CircleAvatar(
//                     child: Icon(
//                       Icons.music_note,
//                       color: Colors.white,
//                     ),
//                   ),
//                   title: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Text(
//                       fullSongs[index].metas.title!,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                   // subtitle: SingleChildScrollView(
//                   //   scrollDirection: Axis.horizontal,
//                   //   child: Text(
//                   //     fullsonglist[index].metas.artist!,
//                   //     style: const TextStyle(
//                   //       color: Colors.white,
//                   //       fontSize: 16,
//                   //     ),
//                   //   ),
//                   // ),
//                   trailing: CircleAvatar(
//                     backgroundColor: Colors.black,
//                     child: IconButton(
//                       icon: const Icon(
//                         Icons.add,
//                         color: Colors.white,
//                         // size: 30,
//                       ),
//                       onPressed: () {
//                         // // log(widget.plalistnameId);
//                         // var name = box.get(playlistDb);

//                         // final datainPlyalist = PlaylistData(
//                         //     playlistAudio:
//                         //         songslist[index].songtitle,
//                         //     playlistName: widget.plalistnameId);
//                         // addToPlaylist(datainPlyalist);
//                       },
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       );
//     },
//   );
// }

// Widget removePlayListItem({index}) {
//   return PopupMenuButton(
//     padding: EdgeInsets.zero,
//     onSelected: (value) {
//       // playlistdataDb.deleteAt(index);
//     },
//     icon: const Icon(
//       Icons.more_vert,
//       color: Colors.white,
//     ),
//     color: Colors.black,
//     itemBuilder: (context) => [
//       PopupMenuItem(
//         value: 'playlist',
//         child: Row(
//           children: const [
//             Icon(
//               Icons.remove_circle_outline,
//               color: Colors.red,
//             ),
//             SizedBox(width: 5),
//             Text(
//               "Remove from Playlist",
//               style: TextStyle(color: Colors.white),
//             )
//           ],
//         ),
//       ),
//     ],
//   );
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/model/musicdb.dart';
import 'package:music/view/splashscreen/splashscreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddsongsToPlaylist extends StatelessWidget {
  String playListName;
  AddsongsToPlaylist({
    Key? key,
    required this.playListName,
  }) : super(key: key);
  List<Songs> playlistSongs = [];

  @override
  Widget build(BuildContext context) {
    // log("checking");
    playlistSongs = box.get(playListName)!.cast<Songs>();
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: dbSongs.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(10.sp),
              child: ListTile(
                title: Padding(
                  padding:
                      const EdgeInsets.only(left: 5.0, bottom: 3, top: 3).r,
                  child: Text(
                    dbSongs[index].songname!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 7.0).r,
                  child: Text(
                    dbSongs[index].artist!.toLowerCase(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                ),
                trailing: playlistSongs
                        .where((element) =>
                            element.id.toString() ==
                            dbSongs[index].id.toString())
                        .isEmpty
                    ? IconButton(
                        onPressed: () async {
                          playlistSongs.add(dbSongs[index]);
                          await box.put(playListName, playlistSongs);
                        },
                        icon: Icon(
                          Icons.add,
                          size: 35.sp,
                          color: Colors.white,
                        ))
                    : IconButton(
                        onPressed: () async {
                          playlistSongs.removeWhere((element) =>
                              element.id.toString() ==
                              dbSongs[index].id.toString());
                          await box.put(playListName, playlistSongs);
                        },
                        icon: Center(
                          child: Icon(
                            Icons.delete,
                            size: 30.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
