import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/screens/favouritescreen/favouritescreen.dart';
import 'package:music/screens/splashscreen/splashscreen.dart';

List? favourites = box.get("favourites");

Widget popup({required songId, required context}) {
  final temp = databaseSongs(dbSongs, songId);
  return PopupMenuButton(
    padding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(15.0).r,
      ),
    ),
    color: Colors.black,
    // onSelected: (value) {
    //   if (value == 'Fav') {
    //     FavouriteIcon(songId: songId);
    //   }
    //   if (value == 'playlist') {
    //     getPLopupaddAudio(context: context, path: songId);
    //   }
    // },
    icon: const Icon(
      Icons.more_vert,
      color: Colors.white,
    ),
    itemBuilder: (context) => [
      favourites!
              .where((element) => element.id.toString() == temp.id.toString())
              .isEmpty
          ? PopupMenuItem(
              onTap: () async {
                favourites!.add(temp);
                await box.put("favourites", favourites!);
              },
              child: const Text(
                "Add to Favourite",
                style: TextStyle(color: Colors.white),
              ),
            )
          : PopupMenuItem(
              onTap: () async {
                favourites!.removeWhere(
                    (element) => element.id.toString() == temp.id.toString());
                await box.put("favourites", favourites!);
              },
              child: const Text(
                'Remove From Favourites',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
      const PopupMenuItem(
        value: 1,
        child: Text(
          "Add to Playlist",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

getPLopupaddAudio({required context, required path}) {
  GlobalKey<FormState> formkey = GlobalKey();
  // showModalBottomSheet(
  //   context: context,
  //   shape: const RoundedRectangleBorder(
  //     borderRadius: BorderRadius.vertical(
  //       top: Radius.circular(30),
  //     ),
  //   ),
  //   builder: (context) {
  //     return Container(
  //       height: 350,
  //       decoration: const BoxDecoration(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(30),
  //           topRight: Radius.circular(30),
  //         ),
  //         gradient: RadialGradient(
  //           colors: [
  //             Color(0xFF911BEE),
  //             Color(0xFF4D0089),
  //           ],
  //         ),
  //       ),
  //       child: Column(
  //         children: [
  //           CircleAvatar(
  //             radius: 30,
  //             backgroundColor: Colors.black,
  //             child: IconButton(
  //               icon: const Icon(
  //                 Icons.add,
  //                 color: Colors.white,
  //                 size: 30,
  //               ),
  //               onPressed: () {
  //                 popupshowDialogbox(context: context);
  //               },
  //             ),
  //           ),
  //           Expanded(
  //             child: ValueListenableBuilder(
  //               valueListenable: playlistDb.listenable(),
  //               builder: (BuildContext context, Box<PlaylistName> value,
  //                   Widget? child) {
  //                 return GridView.builder(
  //                   gridDelegate:
  //                       const SliverGridDelegateWithFixedCrossAxisCount(
  //                     crossAxisCount: 2,
  //                     childAspectRatio: 4 / 3,
  //                   ),
  //                   itemCount: value.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     PlaylistName? nameplaylist = playlistDb.getAt(index);
  //                     return Padding(
  //                       padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
  //                       child: InkWell(
  //                         onTap: () {
  //                           // final datainPlyalist = PlaylistData(
  //                           //     playlistAudio:
  //                           //         fullsonglist[index].metas.title,
  //                           //     playlistName: palyListNameValidate);
  //                           // addToPlaylist(datainPlyalist);
  //                           // Navigator.pop(context);
  //                           //         PlaylistData object = PlaylistData(
  //                           // playlistAudio: path, playlistName: nameplaylist!.playlistName);
  //                           // addToPlaylist(object);
  //                           // // playlistdataDb.add(object);
  //                           // log("${playlistdataDb.length}");
  //                           // Navigator.pop(context);

  //                           // PlaylistData object = PlaylistData(
  //                           //     playlistAudio: path,
  //                           //     playlistName: nameplaylist.toString());
  //                           // playlistdataDb.add(object);
  //                           // print(playlistdataDb.length);
  //                           // Navigator.pop(context);

  //                           // ScaffoldMessenger.of(context).showSnackBar( getSnackBarTwo(context: context));
  //                         },
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(15),
  //                             border: Border.all(
  //                               color: Colors.white54,
  //                               style: BorderStyle.solid,
  //                               width: 2.5,
  //                             ),
  //                             color: Colors.transparent,
  //                           ),
  //                           child: Center(
  //                             child: Text(
  //                               nameplaylist!.playlistName.toString(),
  //                               style: const TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 20,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   },
  // );
}

// popupshowDialogbox({context}) {
//   return showDialog(
//     context: context,
//     builder: (ctx) {
//       return AlertDialog(
//         title: const Text('Playlist Name'),
//         content: TextFormField(
//           controller: nameController,
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: 'Playlist Name',
//           ),
//           validator: (value) {
//             List keys = box.keys.toList();
//             if (value!.trim() == "") {
//               return "Name Required";
//             }
//             if (keys.where((element) => element == value.trim()).isNotEmpty) {
//               return "This Name Already Exist";
//             }
//             return null;
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, 'Cancel'),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // onOkButtonPressed(context: context);
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }
