// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:music/screens/favouritescreen/favouritescreen.dart';
// import 'package:music/screens/nowplayingscreen/widget.dart';
// import 'package:music/screens/splashscreen/splashscreen.dart';

// List? favourites = box.get("favourites");

// Widget favpopup({required songId, required context}) {
//   final temp = databaseSongs(dbSongs, songId);
//   return PopupMenuButton(
//     padding: EdgeInsets.zero,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.all(
//         const Radius.circular(15.0).r,
//       ),
//     ),
//     color: Colors.black,
//     icon: const Icon(
//       Icons.more_vert,
//       color: Colors.white,
//     ),
//     itemBuilder: (context) => [
//       favourites!
//               .where((element) => element.id.toString() == temp.id.toString())
//               .isEmpty
//           ? PopupMenuItem(
//               onTap: () async {
//                 favourites!.add(temp);
//                 await box.put("favourites", favourites!);
//               },
//               child: const Text(
//                 "Add to Favourite",
//                 style: TextStyle(color: Colors.white),
//               ),
//             )
//           : PopupMenuItem(
//               onTap: () async {
//                 favourites!.removeWhere(
//                   (element) => element.id.toString() == temp.id.toString(),
//                 );

//                 await box.put("favourites", favourites!);
//               },
//               child: const Text(
//                 'Remove From Favourites',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//     ],
//   );
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/screens/favouritescreen/favouritescreen.dart';
import 'package:music/screens/homescreen/widget.dart';
import 'package:music/screens/splashscreen/splashscreen.dart';

class FavPopup extends StatefulWidget {
  final songId;
  FavPopup({Key? key, required this.songId}) : super(key: key);

  @override
  State<FavPopup> createState() => _FavPopupState();
}

class _FavPopupState extends State<FavPopup> {
  @override
  Widget build(BuildContext context) {
    // log("message on the build context");
    final temp = databaseSongs(dbSongs, widget.songId);
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
