import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/getx/music_controller.dart';
import '../../Playlist/playlist.dart';
import '../../constants/colors/colors.dart';
import '../../favouritescreen/favouritescreen.dart';
import '../homescreen.dart';
import 'miniplayer.dart';

Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((Audio element) => element.path == fromPath);
}

class NavBar extends StatelessWidget {
  NavBar({super.key});

  // int currentSelectedIndex = 1;

  final List<StatelessWidget> navbarpages = <StatelessWidget>[
    const FavouriteMusicScreen(),
    const HomeScreen(),
    const PlayListScreen()
  ];

  final List<Icon> itembottomnavabr = const <Icon>[
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
      builder: (MusicController navController) {
        return Scaffold(
          extendBody: true,
          body: navbarpages[navController.currentIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: const IconThemeData(
                color: kwhiteIcon,
              ),
            ),
            child: CurvedNavigationBar(
              color: kHomeColor,
              height: 50,
              backgroundColor: ktransparent,
              buttonBackgroundColor: Colors.deepOrangeAccent,
              index: navController.currentIndex,
              onTap: (int newIndex) {
                navController.currentIndexChange(newIndex);
              },
              items: itembottomnavabr,
            ),
          ),
          bottomSheet: const MiniPlayer(),
        );
      },
    );
  }
}
