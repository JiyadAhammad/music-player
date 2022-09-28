import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/getx/music_controller.dart';
import '../../main.dart';
import '../../model/musicdb.dart';
import '../constants/colors/colors.dart';
import '../favouritescreen/favouritescreen.dart';
import '../nowplayingscreen/widget.dart';
import '../splashscreen/splashscreen.dart';

List<dynamic>? favourites = box.get('favourites');

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
        color: kblack,
        icon: const Icon(
          Icons.more_vert,
          color: kwhiteIcon,
        ),
        itemBuilder: (_) => <PopupMenuEntry<dynamic>>[
          if (favourites!
              .where((dynamic element) =>
                  element.id.toString() == temp.id.toString())
              .isEmpty)
            PopupMenuItem<dynamic>(
              onTap: () {
                // musicController.addToFavoutire(temp);
                musicController.addToFavoutire(temp);
              },
              child: const Text(
                'Add to Favourite',
                style: TextStyle(color: kwhiteText),
              ),
            )
          else
            PopupMenuItem<dynamic>(
              onTap: () async {
                musicController.removeFromFavourite(temp);
              },
              child: const Text(
                'Remove From Favourites',
                style: TextStyle(
                  color: kwhiteText,
                ),
              ),
            ),
          const PopupMenuItem<dynamic>(
            value: 1,
            child: Text(
              'Add to Playlist',
              style: TextStyle(
                color: kwhiteText,
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
