import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/musicdb.dart';
import '../constants/colors/colors.dart';
import '../splashscreen/splashscreen.dart';

List<dynamic> playlists = <dynamic>[];
List<dynamic>? playlistSongs = <dynamic>[];

class PlaylistItem extends StatelessWidget {
  const PlaylistItem({
    super.key,
    required this.song,
    required this.countsong,
  });
  final Songs song;

  final dynamic countsong;

  @override
  Widget build(BuildContext context) {
    playlists = box.keys.toList();
    return Column(
      children: <Widget>[
        ...playlists.map(
          (dynamic playlistName) => playlistName != 'mymusic' &&
                  playlistName != 'favourites'
              ? Container(
                  decoration: BoxDecoration(
                      color: ktransparent,
                      borderRadius: BorderRadius.circular(15).r),
                  child: ListTile(
                    onTap: () async {
                      playlistSongs = box.get(playlistName);
                      List<dynamic> existingSongs = <dynamic>[];
                      existingSongs = playlistSongs!
                          .where(
                            (dynamic element) =>
                                element.id.toString() == song.id.toString(),
                          )
                          .toList();
                      if (existingSongs.isEmpty) {
                        final Songs temp = dbSongs.firstWhere(
                          (Songs element) =>
                              element.id.toString() == song.id.toString(),
                        );
                        playlistSongs?.add(temp);
                        await box.put(playlistName, playlistSongs!);

                        Get.back();
                      } else {
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${song.songname!}is Already in Playlist',
                              style: const TextStyle(color: kwhiteText),
                            ),
                          ),
                        );
                      }
                    },
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 6.0, top: 6).r,
                      child: Icon(
                        Icons.queue_music_rounded,
                        color: kwhiteIcon,
                        size: 30.sp,
                      ),
                    ),

                    // playlist name
                    title: Padding(
                      padding:
                          const EdgeInsets.only(left: 3.0, bottom: 3, top: 5).r,
                      child: Text(
                        playlistName.toString(),
                        style: TextStyle(color: kwhiteText, fontSize: 18.sp),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 3.0).r,
                      child: Text(
                        countsong.toString(),
                        style: const TextStyle(
                          color: kwhiteText,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}
