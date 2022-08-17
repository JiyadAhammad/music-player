// import 'package:flutter/material.dart';
// import 'package:jmusic/screens/nowplayingscreen/musicplayscreen.dart';


// class CustomContainer extends StatelessWidget {
//   final IconData? leadingicons;
//   final String songName;
//   final String artistName;
//   final IconData? favouriteIcon;
//   final IconData? trailingIcon;

//   const CustomContainer({
//     Key? key,
//     this.leadingicons,
//     required this.songName,
//     required this.artistName,
//     this.favouriteIcon,
//     this.trailingIcon,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
//       child: ListView.builder(
//         itemCount: 10,
//         itemBuilder: (BuildContext context, int index) {
//           return Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//               side: const BorderSide(
//                 color: Colors.white54,
//                 width: 2.0,
//               ),
//             ),
//             color: Colors.transparent,
//             elevation: 0,
//             child: Container(
//               height: 75,
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: ListTile(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: ((context) =>  MusicPlaySceeen()),
//                     ),
//                   );
//                 },
//                 leading: const CircleAvatar(
//                   child: Icon(
//                     Icons.music_note,
//                     color: Colors.white,
//                   ),
//                 ),
//                 title: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Text(
//                     songName,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//                 subtitle: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Text(
//                     artistName,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 trailing: Wrap(
//                   children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.favorite,
//                         color: Colors.white,
//                       ),
//                     ),
//                     PopupMenuButton(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(15.0),
//                         ),
//                       ),
//                       color: Colors.black,
//                       itemBuilder: (context) {
//                         return [
//                           const PopupMenuItem(
//                             value: '1',
//                             child: Text(
//                               'Add to playlist',
//                               style: TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ];
//                       },
//                       onSelected: (String value) {},
//                       icon: const Icon(
//                         Icons.more_vert,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
