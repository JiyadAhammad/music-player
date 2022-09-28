import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../main.dart';
import '../constants/colors/colors.dart';
import '../homescreen/widget.dart';
import '../splashscreen/splashscreen.dart';
import 'favouritescreen.dart';

class FavPopup extends StatelessWidget {
  const FavPopup({
    super.key,
    required this.songId,
  });
  final String songId;

  @override
  Widget build(BuildContext context) {
    final dynamic temp = databaseSongs(dbSongs, songId);
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
      itemBuilder: (BuildContext context) => <PopupMenuEntry<dynamic>>[
        if (favourites!
            .where(
                (dynamic element) => element.id.toString() == temp.id.toString())
            .isEmpty)
          PopupMenuItem<dynamic>(
            onTap: () {
              musicController.addToFavoutire( temp);
            },
            child: const Text(
              'Add to Favourite',
              style: TextStyle(color: kwhiteText),
            ),
          )
        else
          PopupMenuItem<dynamic>(
            onTap: () {
              musicController.removeFromFavourite(temp);
            },
            child: const Text(
              'Remove From Favourites',
              style: TextStyle(
                color: kwhiteText,
              ),
            ),
          ),
      ],
    );
  }
}
