import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/getx/music_controller.dart';
import '../../model/musicdb.dart';
import '../splashscreen/splashscreen.dart';

class Addtofavourite extends StatelessWidget {
  const Addtofavourite({super.key});

  // List<Songs> songsinfav = [];
  @override
  Widget build(BuildContext context) {
    // final songsinfav = databaseSongs(dbSongs,);
    // final temp = databaseSongs(dbSongs,);
    // songsinfav = box.get("favourites");
    final List<dynamic> songinfav = box.get('favourites')!;
    return ListView.builder(
      itemCount: dbSongs.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(
            10.sp,
          ),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 5.0, bottom: 3, top: 3).r,
              child: Text(
                dbSongs[index].songname ?? 'Unknown',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 7.0).r,
              child: Text(
                dbSongs[index].artist ?? 'Unknown'.toLowerCase(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white60,
                ),
              ),
            ),
            trailing: GetBuilder<MusicController>(
              init: MusicController(),
              builder: (MusicController favouController) {
                return songinfav
                        .where((dynamic element) =>
                            element.id.toString() ==
                            dbSongs[index].id.toString())
                        .isEmpty
                    ? IconButton(
                        onPressed: () {
                          favouController.addToFavoutire(dbSongs[index]);
                          // songinfav.add(dbSongs[index]);
                          // await box.put('favourites', songinfav);

                          // setState(() {});
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 35.sp,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          favouController.removeFavouriteBottomSheet(
                              songinfav, index);
                          // musicController.removeFromFavourite(
                          //     dbSongs[index].id.toString());

                          // setState(() {});
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 35.sp,
                        ),
                      );
              },
            ),
          ),
        );
      },
    );
  }
}
