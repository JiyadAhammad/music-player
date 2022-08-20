import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/hivedb/musicdb.dart';
import 'package:music/screens/favouritescreen/favouritescreen.dart';
import 'package:music/screens/favouritescreen/widget.dart';
import 'package:music/screens/splashscreen/splashscreen.dart';

class Addtofavourite extends StatelessWidget {
  const Addtofavourite({Key? key}) : super(key: key);
  // List<Songs> songsinfav = [];

  @override
  Widget build(BuildContext context) {
    // final songsinfav = databaseSongs(dbSongs,);
    // final temp = databaseSongs(dbSongs,);
    // songsinfav = box.get("favourites");
    // final songinfav = box.get("favourites");
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (BuildContext context, dynamic value, Widget? child) {
        return ListView.builder(
          itemCount: dbSongs.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(
                10.sp,
              ),
              child: ListTile(
                title: Padding(
                  padding:
                      const EdgeInsets.only(left: 5.0, bottom: 3, top: 3).r,
                  child: Text(
                    dbSongs[index].songname!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 7.0).r,
                  child: Text(
                    dbSongs[index].artist!.toLowerCase(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                ),
                // trailing: IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     Icons.add,
                //     color: Colors.white,
                //     size: 35.sp,
                //   ),
                // ),
                // trailing: songinfav!.where((element) =>
                //         element.id.toString() !=
                //         dbSongs[index].id.toString().isEmpty)
                //     ? IconButton(
                //         onPressed: () {},
                //         icon: Icon(
                //           Icons.add,
                //           color: Colors.white,
                //           size: 35.sp,
                //         ),
                //       )
                //     : IconButton(
                //         onPressed: () {},
                //         icon: Icon(
                //           Icons.delete,
                //           color: Colors.white,
                //           size: 35.sp,
                //         ),
                //       ),
                // trailing: favourites!.where((element) => element.id.toString() == dbSongs[index].id.toString().isEmpty),
                // trailing: playlistSongs
                //         .where((element) =>
                //             element.id.toString() ==
                //             dbSongs[index].id.toString())
                //         .isEmpty
                //     ? IconButton(
                //         onPressed: () async {
                //           playlistSongs.add(dbSongs[index]);
                //           await box.put(playListName, playlistSongs);
                //         },
                //         icon: Icon(
                //           Icons.add,
                //           size: 35.sp,
                //           color: Colors.white,
                //         ))
                //     : IconButton(
                //         onPressed: () async {
                //           playlistSongs.removeWhere((element) =>
                //               element.id.toString() ==
                //               dbSongs[index].id.toString());
                //           await box.put(playListName, playlistSongs);
                //         },
                //         icon: Center(
                //           child: Icon(
                //             Icons.delete,
                //             size: 30.sp,
                //             color: Colors.white,
                //           ),

                //         ),
                //       ),

                // trailing: IconButton(
                //   onPressed: () {},
                //   icon: CircleAvatar(
                //     child: Icon(
                //       Icons.add,
                //       color: Colors.white,
                //       size: 30.sp,
                //     ),
                //   ),
                // ),
              ),
            );
          },
        );
      },
    );
  }
}
