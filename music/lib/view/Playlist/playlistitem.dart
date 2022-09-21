import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/model/musicdb.dart';
import 'package:music/view/splashscreen/splashscreen.dart';

// ignore: must_be_immutable
class PlaylistItem extends StatelessWidget {
  Songs song;
  List playlists = [];
  List<dynamic>? playlistSongs = [];
  final dynamic countsong;
  PlaylistItem({
    Key? key,
    required this.song,
    required this.countsong,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    playlists = box.keys.toList();
    return Column(
      children: [
        ...playlists
            .map(
              (playlistName) => playlistName != "mymusic" &&
                      playlistName != "favourites"
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15).r),
                      child: ListTile(
                        onTap: () async {
                          playlistSongs = box.get(playlistName);
                          List existingSongs = [];
                          existingSongs = playlistSongs!
                              .where((element) =>
                                  element.id.toString() == song.id.toString())
                              .toList();
                          if (existingSongs.isEmpty) {
                            final temp = dbSongs.firstWhere((element) =>
                                element.id.toString() == song.id.toString());
                            playlistSongs?.add(temp);
                            await box.put(playlistName, playlistSongs!);

                            Get.back();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                // backgroundColor: darkBlue,
                                content: Text(
                                  '${song.songname!}Added to Playlist',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          } else {
                            Get.back;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${song.songname!}is Already in Playlist.',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }
                        },
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 6.0, top: 6).r,
                          child: Icon(
                            Icons.queue_music_rounded,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        ),

                        // playlist name
                        title: Padding(
                          padding: const EdgeInsets.only(
                                  left: 3.0, bottom: 3, top: 5)
                              .r,
                          child: Text(
                            playlistName.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.sp),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 3.0).r,
                          child: Text(
                            countsong,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            )
            .toList()
      ],
    );
  }
}
