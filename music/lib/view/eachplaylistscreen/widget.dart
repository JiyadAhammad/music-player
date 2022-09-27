import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/getx/music_controller.dart';
import '../../main.dart';
import '../../model/musicdb.dart';
import '../splashscreen/splashscreen.dart';

// ignore: must_be_immutable
class AddsongsToPlaylist extends StatelessWidget {
  AddsongsToPlaylist({
    super.key,
    required this.playListName,
  });
  final String playListName;
  List<Songs> playlistSongs = <Songs>[];

  @override
  Widget build(BuildContext context) {
    playlistSongs = box.get(playListName)!.cast<Songs>();
    return GetBuilder<MusicController>(
      init: MusicController(),
      builder: (_) {
        return ListView.builder(
          itemCount: dbSongs.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(10.sp),
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
                trailing: playlistSongs
                        .where((Songs element) =>
                            element.id.toString() ==
                            dbSongs[index].id.toString())
                        .isEmpty
                    ? IconButton(
                        onPressed: () {
                          musicController.addPlayListMusicFromBottomSheet(
                            playlistSongs,
                            index,
                            playListName,
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          size: 35.sp,
                          color: Colors.white,
                        ))
                    : IconButton(
                        onPressed: () {
                          musicController.deletePlayListMusicFromBottomSheet(
                              playlistSongs, index, playListName);
                        },
                        icon: Center(
                          child: Icon(
                            Icons.delete,
                            size: 30.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
