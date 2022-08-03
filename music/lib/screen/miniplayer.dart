// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:marquee/marquee.dart';
// import 'package:music/screen/homescreen.dart';

// class MiniPlayerScreen extends StatefulWidget {
//   const MiniPlayerScreen({Key? key}) : super(key: key);

//   @override
//   State<MiniPlayerScreen> createState() => _MiniPlayerScreenState();
// }

// class _MiniPlayerScreenState extends State<MiniPlayerScreen> {
//  Widget audioImage(RealtimePlayingInfos realtimePlayingInfos) {
//     // return Container(
//     //   height: MediaQuery.of(context).size.height * 0.45,
//     //   width: MediaQuery.of(context).size.width * 0.85,
//     //   child: Material(
//     //     elevation: 18.0,
//     //     color: Colors.transparent,
//     //     borderRadius: BorderRadius.circular(50.0),
//     //     child: ClipRRect(
//     //       borderRadius: BorderRadius.circular(50.0),
//     //       // child: Image.asset(
//     //       //   realtimePlayingInfos.current!.audio.audio.metas.image!.path,
//     //       //   fit: BoxFit.cover,
//     //       //   filterQuality: FilterQuality.high,
//     //       // ),
//     //     ),
//     //   ),
//     // );
//     return const CircleAvatar(
//       radius: 120,
//       backgroundColor: Color.fromARGB(0, 48, 207, 228),
//       backgroundImage:
//           // AssetImage(widget.realtimePlayingInfos
//           //     .current!.audio.audio.metas.image!.path)
//           AssetImage(
//         'assets/images/now_playing-mp3.png',
//       ),
//     );
//   }

// Widget playlistFavButtons(RealtimePlayingInfos realtimePlayingInfos) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         children: [
//           Container(
//             // margin: EdgeInsets.only(left: 10),
//             width: MediaQuery.of(context).size.width,
//             height: 20,
//             child: Marquee(
//               text: realtimePlayingInfos.current!.audio.audio.metas.title!,
//               pauseAfterRound: Duration(seconds: 0),
//               velocity: realtimePlayingInfos.duration.inMinutes.toDouble(),
//               style: TextStyle(color: Colors.white, fontSize: 20),
//               blankSpace: 30,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               // text: realtimePlayingInfos.current!.audio.audio.metas.title!,
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // iconBtn(() {
//               //   // add to user's favorite list
//               //   //show snack bar when selected the favorite icon
//               // }, Icons.favorite),
//               // iconBtn(() {
//               //   //open play list and add user selected list
//               // }, Icons.playlist_add),
//               // iconBtn(() {
//               //   Navigator.of(context).pop();
//               // }, Icons.exit_to_app)
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//   Widget build(BuildContext context) {
//     double screenwidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         // title: Text(widget.assetsAudioPlayer!.getCurrentAudioTitle),
//         title: Text('Now Playing'),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       backgroundColor: Color.fromARGB(255, 48, 48, 48),
//       body: audioPlayer.builderRealtimePlayingInfos(
//           builder: ((context, realtimePlayingInfos) {
//         if (realtimePlayingInfos != null) {
//           return Stack(
//             children: [
//               // themeBlue(),
//               // themePink(),
//               Positioned(
//                 left: 20,
//                 top: 10,
//                 right: 20,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 40,
//                     ),
//                     audioImage(realtimePlayingInfos),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     playlistFavButtons(realtimePlayingInfos),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     title(realtimePlayingInfos),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     slider(realtimePlayingInfos),
//                     tmeStamp(realtimePlayingInfos),
//                      SizedBox(
//                       height: 10,
//                     ),
//                     playBar(realtimePlayingInfos),
//                   ],
//                 ),
//               )
//             ],
//           );
//         } else {
//           return Column();
//         }
//       })),
//     );
//   }
// }