import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/screens/favouritescreen/favouritescreen.dart';
import 'package:music/screens/splashscreen/splashscreen.dart';


class FavouriteIcon extends StatefulWidget {
  final String songId;

  const FavouriteIcon({Key? key, required this.songId}) : super(key: key);

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  @override
  Widget build(BuildContext context) {
    final favouritesSong = box.get("favourites");
    final fav = databaseSongs(dbSongs, widget.songId);

    return favouritesSong!
            .where((element) => element.id.toString() == fav.id.toString())
            .isEmpty
        ? IconButton(
            onPressed: () async {
              setState(() {
                favouritesSong.add(fav);
                log("${widget.songId} song id to favourite added");
                box.put("favourites", favouritesSong);
              });
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 30.sp,
            ),
          )
        : IconButton(
            onPressed: () async {
              setState(() {
                favouritesSong.removeWhere(
                    (element) => element.id.toString() == fav.id.toString());
                box.put("favourites", favouritesSong);
                log("${widget.songId} song id to favourite deleted");
              });
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30.sp,
            ),
          );
  }
}
