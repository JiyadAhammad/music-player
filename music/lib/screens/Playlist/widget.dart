import 'package:flutter/material.dart';
// import 'package:jmusic/function/dbfunctions.dart';
// import 'package:jmusic/hivedb/musicdb.dart';
// import 'package:jmusic/main.dart';
// import 'package:jmusic/screens/Playlist/playlist.dart';
// import 'package:path/path.dart';

// final GlobalKey<FormState> _formKey = GlobalKey();

// onOkButtonPressed({context}) {
//   palyListNameValidate = nameController.text.trim();
//   // log('$palyListNameValidate values in plaulisdy');
//   if (palyListNameValidate.isEmpty) {
//     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//     //     backgroundColor: Color.fromARGB(255, 206, 14, 0),
//     //     margin: EdgeInsets.all(20),
//     //     behavior: SnackBarBehavior.floating,
//     //     content: Text("Name cannot be null"),
//     //     duration: Duration(seconds: 1)));
//     return "Enter Playlist Name";
//   }
//   if (palyListNameValidate == 'favourite') {
//     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//     //     backgroundColor: Color.fromARGB(255, 206, 14, 0),
//     //     margin: EdgeInsets.all(20),
//     //     behavior: SnackBarBehavior.floating,
//     //     content: Text("Enter valid Name"),
//     //     duration: Duration(seconds: 1)));
//     return "Enter valid Name";
//   }
//   ScaffoldMessenger.of(context).showSnackBar(
//     const SnackBar(
//       backgroundColor: Color.fromARGB(255, 49, 185, 11),
//       margin: EdgeInsets.all(30),
//       behavior: SnackBarBehavior.floating,
//       content: Center(
//         heightFactor: 1.0,
//         child: Text(
//           "Added Succesfully",
//         ),
//       ),
//       duration: Duration(seconds: 1),
//       shape: StadiumBorder(),
//       elevation: 100,
//     ),
//   );
//   //

//   Navigator.pop(context, 'ok');
//   // final playlisvalue = PlaylistName(
//   //   playlistName: palyListNameValidate,
//   // );
//   addtoPlaylist();
// }

// playlistEdit({required BuildContext context, String? playName}) {
//   showDialog(
//     context: context,
//     builder: (context) => Form(
//       key: _formKey,
//       child: AlertDialog(
//         title: const Text("Edit Playlist"),
//         content: TextFormField(
//           controller: nameController,
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: 'Playlist Name',
//           ),
//           validator: (value) {
//             if (value!.isEmpty) {
//               return "Enter Playlist Name";
//             } else if (checkPlaylistExists(value).isNotEmpty) {
//               return "Playlist already exists";
//             }

//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//                 editPlayDB(
//                   oldValue: playName!,
//                   newValue: nameController.text.trim(),
//                 );
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     backgroundColor: Colors.green,
//                     margin: EdgeInsets.all(20),
//                     behavior: SnackBarBehavior.floating,
//                     content: Text("Playlist Name Updated"),
//                     duration: Duration(seconds: 1),
//                   ),
//                 );
//                 return;
//               }
//             },
//             child: const Text(
//               "Update",
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
// widget deletePlaylist({context}) {
//   return showDialog(
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: darkBlue,
//         title: const Center(
//           child: Text(
//             "Remove this Playlist",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         content: Padding(
//           padding: const EdgeInsets.only(top: 8.0).r,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Text("Are You Confirm ",
//                   style: TextStyle(color: Colors.yellowAccent)),
//             ],
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20).r,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   child: Text("Cancel",
//                       style: TextStyle(color: textWhite, fontSize: 18.sp)),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 TextButton(
//                   child: Text("Yes",
//                       style: TextStyle(color: textWhite, fontSize: 18.sp)),
//                   onPressed: () {
//                     Navigator.pop(context);
//                     box.delete(playlistsName[index]);

//                     playlistsName = box.keys.toList();
//                   },
//                 )
//               ],
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
