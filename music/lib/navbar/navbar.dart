import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music/screen/favouritescreen.dart';
import 'package:music/screen/homescreen.dart';
import 'package:music/screen/playlist.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
 
class NavBar extends StatefulWidget {
  final index;
  List<Audio>? title;
  
  NavBar({Key? key, this.index, this.title}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentSelectedIndex = 1;
  bool isMusicPlaying = false;

  List navbarpages = [
    const FavouriteMusicScreen(),
    const HomeScreen(),
    const PlayListScreen()
  ];

  final itembottomnavabr = const [
    Icon(
      Icons.favorite,
      size: 30,
    ),
    Icon(
      Icons.home_rounded,
      size: 30,
    ),
    Icon(
      Icons.queue_music_rounded,
      size: 30,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      extendBody: true,
      body: navbarpages[currentSelectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        child: CurvedNavigationBar(
          color: Colors.deepPurple,
          height: 50,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.deepOrangeAccent,
          index: currentSelectedIndex,
          onTap: (newIndex) {
            setState(
              () {
                currentSelectedIndex = newIndex;
              },
            );
          },
          items: itembottomnavabr,
        ),
      ),
      // bottomSheet: bottomminiplayer(context,audioPlayer,realtimePlayingInfos)
      // bottomSheet: bottomminiplayer(context, audioPlayer),
      // bottomSheet: GestureDetector(
      //   onTap: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => MusicPlaySceeen(
      //           audioPlayer: audioPlayer,
      //           allSongs: fullsonglist,
      //           songId: fullsonglist[widget.index].metas.id.toString(),
      //         ),
      //       ),
      //     );
      //   },
      //   child: Container(
      //     // color: Colors.black,
      //     // margin: const EdgeInsets.all(10),
      //     decoration: BoxDecoration(
      //       color: Colors.deepPurple[700],
      //       border: Border.all(
      //         color: const Color.fromARGB(255, 56, 100, 136),
      //         width: 3.0,
      //       ),
      //       // borderRadius: const BorderRadius.all(
      //       //   Radius.circular(
      //       //    15.0,
      //       //   ),
      //       // ),
      //       boxShadow: const [
      //         BoxShadow(
      //           blurRadius: 10,
      //           color: Colors.black,
      //           offset: Offset(1, 3),
      //         ),
      //       ],
      //     ),
      //     height: 55,
      //     child: ListTile(
      //       title: Marquee(
      //         text: "ThemeData",
      //         // text: fullsonglist[widget.index].metas.title!,
      //         style: const TextStyle(
      //           color: Colors.white,
      //           fontSize: 20,
      //         ),
      //       ),
      //       leading: const Icon(
      //         Icons.music_note,
      //         color: Colors.white,
      //         size: 25,
      //       ),
      //       trailing: IconButton(
      //         onPressed: () {},
      //         icon: const Icon(
      //           Icons.pause_circle,
      //           color: Colors.white,
      //           size: 30,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
  
  // bottomminiplayer(BuildContext context, AssetsAudioPlayer audioPlayer, realtimePlayingInfos) {

  // }

  // Widget bottomminiplayer(context, AssetsAudioPlayer audioPlayer) {
  //   return audioPlayer.builderRealtimePlayingInfos(
  //     builder: ((context, RealtimePlayingInfos realtimePlayingInfos) {
  //       return GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => MusicPlaySceeen(
  //                 audioPlayer: audioPlayer,
  //               ),
  //             ),
  //           );
  //         },
  //           child: Container(
  //         // color: Colors.black,
  //          // margin: const EdgeInsets.all(10),
  //          decoration: BoxDecoration(
  //            color: Colors.deepPurple[700],
  //            border: Border.all(
  //              color: const Color.fromARGB(255, 56, 100, 136),
  //              width: 3.0,
  //            ),
  //             borderRadius: const BorderRadius.all(
  //               Radius.circular(
  //                15.0,
  //               ),
  //             ),
  //            boxShadow: const [
  //              BoxShadow(
  //                blurRadius: 10,
  //                color: Colors.black,
  //                offset: Offset(1, 3),
  //              ),
  //            ],
  //          ),
  //          height: 55,
  //          child: ListTile(
  //            title:const  Text(
  //              'hai',
  //               // fullsonglist[widget.index].metas.title!,
  //              style: TextStyle(
  //                color: Colors.white,
  //                fontSize: 25,
  //              ),
  //            ),
  //            leading: const Icon(
  //              Icons.music_note,
  //              color: Colors.white,
  //              size: 25,
  //            ),
  //            trailing: Wrap(
  //              children: [
  //                IconButton(
  //                  onPressed: () {},
  //                  icon: const Icon(
  //                    Icons.pause_circle,
  //                    color: Colors.white,
  //                    size: 30,
  //                  ),
  //                ),
  //                IconButton(
  //                  onPressed: () {},
  //                  icon: const Icon(
  //                    Icons.skip_next_rounded,
  //                    color: Colors.white,
  //                    size: 30,
  //                  ),
  //                )
  //              ],
  //            ),
  //          ),
  //        ),
  //       );
  //     }),
  //   );
  // }
}

// Widget textMoving(RealtimePlayingInfos realtimePlayingInfos, context) {
//   return Container(
//     margin: const EdgeInsets.only(left: 10),
//     // width: MediaQuery.of(context).size.width * 0.3,
//     // height: MediaQuery.of(context).size.width * 0.055,
//     child: Marquee(
//       pauseAfterRound: const Duration(seconds: 0),
//       velocity: realtimePlayingInfos.duration.inMinutes.toDouble(),
//       style: const TextStyle(color: Colors.white),

//       blankSpace: 30,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       text: realtimePlayingInfos.current!.audio.audio.metas.title.toString(),
//       // text Text(
//       //   realtimePlayingInfos
//       //       .current!.audio.audio.metas.title!,
//       //   overflow: TextOverflow.clip,
//       //   maxLines: 1,
//       //   softWrap: false,
//       //   style: TextStyle(
//       //     color: Colors.white,
//       //   ),
//       // ),
//     ),
//   );
// }
