import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/getx/music_controller.dart';
import '../../model/musicdb.dart';
import '../favouritescreen/favouritescreen.dart';
import '../nowplayingscreen/widget.dart';
import '../splashscreen/splashscreen.dart';

List<Songs>? favourites = box.get('favourites')! as List<Songs>;

Widget popup({required String songId, required BuildContext context}) {
  final Songs temp = databaseSongs(dbSongs, songId);
  return GetBuilder<MusicController>(
    init: MusicController(),
    builder: (MusicController favouriteController) {
      return PopupMenuButton<dynamic>(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            const Radius.circular(15.0).r,
          ),
        ),
        color: Colors.black,
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<dynamic>>[
          if (favourites!
              .where((Songs element) =>
                  element.id.toString() == temp.id.toString())
              .isEmpty)
            PopupMenuItem<dynamic>(
              onTap: () async {
                // musicController.addToFavoutire(temp);
                favouriteController.addToFavoutire(temp);
              },
              child: const Text(
                'Add to Favourite',
                style: TextStyle(color: Colors.white),
              ),
            )
          else
            PopupMenuItem<dynamic>(
              onTap: () async {
                // musicController.removeFromFavourite(temp);
              },
              child: const Text(
                'Remove From Favourites',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          const PopupMenuItem<dynamic>(
            value: 1,
            child: Text(
              'Add to Playlist',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
        onSelected: (dynamic value) {
          if (value == 1) {
            playlistshowbottomsheet(
              context: context,
              playlistNames: temp,
              currentplaysong: temp,
            );
          }
        },
      );
    },
  );
}
