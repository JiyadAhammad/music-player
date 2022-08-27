import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:music/screens/Playlist/playlist.dart';
import 'package:music/screens/favouritescreen/favouritescreen.dart';
import 'package:music/screens/homescreen/homescreen.dart';
import 'package:music/screens/homescreen/navbar/miniplayer.dart';

Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentSelectedIndex = 1;

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
      bottomSheet: const MiniPlayer(),
    );
  }
}
