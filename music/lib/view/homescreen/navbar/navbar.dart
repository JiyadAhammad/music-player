import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:music/controller/getx/music_controller.dart';
import 'package:music/view/Playlist/playlist.dart';
import 'package:music/view/favouritescreen/favouritescreen.dart';
import 'package:music/view/homescreen/homescreen.dart';
import 'package:music/view/homescreen/navbar/miniplayer.dart';

Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}

// ignore: must_be_immutable
class NavBar extends StatelessWidget {
  NavBar({Key? key}) : super(key: key);

  // int currentSelectedIndex = 1;

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
    return GetBuilder<MusicController>(
        init: MusicController(),
        builder: (navController) {
          return Scaffold(
            extendBody: true,
            body: navbarpages[navController.currentIndex],
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
                index: navController.currentIndex,
                onTap: (newIndex) {
                  navController.currentIndexChange(newIndex);
                  // setState(
                  //   () {
                  //     currentSelectedIndex = newIndex;
                  //   },
                  // );
                },
                items: itembottomnavabr,
              ),
            ),
            bottomSheet: const MiniPlayer(),
          );
        });
  }
}
