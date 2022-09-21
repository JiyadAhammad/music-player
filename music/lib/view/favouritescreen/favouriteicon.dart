import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/controller/getx/music_controller.dart';
import 'package:music/view/favouritescreen/favouritescreen.dart';
import 'package:music/view/splashscreen/splashscreen.dart';

class FavouriteIcon extends StatelessWidget {
  final String songId;

  const FavouriteIcon({Key? key, required this.songId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favouritesSong = box.get("favourites");
    final fav = databaseSongs(dbSongs, songId);

    return GetBuilder<MusicController>(
      init: MusicController(),
      builder: (favIconController) {
        return favouritesSong!
                .where((element) => element.id.toString() == fav.id.toString())
                .isEmpty
            ? IconButton(
                onPressed: () async {
                  favIconController.onFavIconclicktoAdd(
                    favouritesSong,
                    fav,
                  );
                },
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30.sp,
                ),
              )
            : IconButton(
                onPressed: () async {
                  favIconController.onFavIconclicktoRemove(
                    favouritesSong,
                    fav,
                  );
                },
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 30.sp,
                ),
              );
      },
    );
  }
}
