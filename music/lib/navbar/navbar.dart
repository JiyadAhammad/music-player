import 'package:flutter/material.dart';
import 'package:music/screen/favouritescreen.dart';
import 'package:music/screen/homescreen.dart';
import 'package:music/screen/playlist.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

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
      
      bottomSheet: Container(
        color: Colors.deepPurple[700],
        height: 60,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: const Text(
                'data',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,               ),
              ),
              leading: const Icon(
                Icons.music_note,
                color: Colors.white,
                size: 25,
              ),
              trailing: Wrap(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.pause_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  )

                  // Icon(Icons.pause_circle),
                  // SizedBox(width: 10,),
                  // Icon(Icons.skip_next_rounded)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
