import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/view/favouritescreen/favouritescreen.dart';
import 'package:music/view/homescreen/widget.dart';
import 'package:music/view/splashscreen/splashscreen.dart';

class FavPopup extends StatelessWidget {
  final dynamic songId;
  const FavPopup({Key? key, required this.songId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log("message on the build context");
    final temp = databaseSongs(dbSongs, songId);
    return PopupMenuButton(
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
      itemBuilder: (context) => [
        favourites!
                .where((element) => element.id.toString() == temp.id.toString())
                .isEmpty
            ? PopupMenuItem(
                onTap: () async {
                  favourites!.add(temp);
                  await box.put("favourites", favourites!);
                },
                child: const Text(
                  "Add to Favourite",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : PopupMenuItem(
                onTap: () async {
                  favourites!.removeWhere(
                    (element) => element.id.toString() == temp.id.toString(),
                  );
                  box.put("favourites", favourites!);
                },
                child: const Text(
                  'Remove From Favourites',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
      ],
    );
  }
}
