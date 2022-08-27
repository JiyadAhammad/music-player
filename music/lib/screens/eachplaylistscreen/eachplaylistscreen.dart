import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/hivedb/musicdb.dart';
import 'package:music/screens/eachplaylistscreen/widget.dart';
import 'package:music/screens/nowplayingscreen/musicplayscreen.dart';
import 'package:music/screens/splashscreen/splashscreen.dart';
import 'package:music/widget/openplayer.dart';

class EachPlayList extends StatelessWidget {
  String playlistnameId;

  EachPlayList({
    Key? key,
    required this.playlistnameId,
  }) : super(key: key);

  List<Songs> playlistSongs = [];

  @override
  Widget build(BuildContext context) {
    playlistSongs = box.get(playlistnameId)!.cast<Songs>();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF911BEE),
            Colors.black.withOpacity(0.94),
            Colors.black,
            Colors.black.withOpacity(0.94),
            const Color(0xFF911BEE),
          ],
          stops: const [
            0.01,
            0.3,
            0.5,
            0.7,
            1,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(playlistnameId),
          centerTitle: true,
          elevation: 0,
        ),
        body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (BuildContext context, playlistdatalist, Widget? child) {
            playlistSongs = box.get(playlistnameId)!.cast<Songs>();
            List<Audio> playPlaylist = [];
            for (var item in playlistSongs) {
              playPlaylist.add(
                Audio.file(
                  item.path!,
                  metas: Metas(
                    id: item.id.toString(),
                    artist: item.artist,
                    title: item.songname,
                  ),
                ),
              );
            }
            return playlistSongs.isEmpty
                ? Center(
                    child: SizedBox(
                      child: Text(
                        'No Songs',
                        style: TextStyle(color: Colors.white, fontSize: 25.sp),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: ListView.builder(
                      itemCount: playlistSongs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              color: Colors.white54,
                              width: 2.0,
                            ),
                          ),
                          color: Colors.transparent,
                          elevation: 0,
                          child: Container(
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              
                              onTap: () {
                                Openplayer(
                                  fullSongs: playPlaylist,
                                  index: index,
                                  songId:
                                      playPlaylist[index].metas.id.toString(),
                                ).openAssetPlayer(
                                    index: index, songs: playPlaylist);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MusicPlaySceeen(
                                      allSongs: playPlaylist,
                                      index: index,
                                      songId: playPlaylist[index].metas.id!,
                                    ),
                                  ),
                                );
                                log("$playPlaylist favourite song");
                              },
                              leading: const CircleAvatar(
                                child: Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                ),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(
                                        left: 5.0, bottom: 3, top: 3)
                                    .r,
                                child: Text(
                                  playlistSongs[index].songname!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                              // title: SizedBox(
                              //   height: 40.h,
                              //   child: Marquee(
                              //     blankSpace: 50.w.h,
                              //     startAfter: Duration.zero,
                              //     velocity: 50,
                              //     // text: songdata.songtitle!,
                              //     text: playlistSongs[index].songname!,
                              //     style: TextStyle(
                              //       overflow: TextOverflow.ellipsis,
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 20.sp,
                              //     ),
                              //   ),
                              // ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(
                                        top: 3.0, left: 2.0, bottom: 5)
                                    .r,
                                child: Text(
                                  // songdata.songartist!,
                                  playlistSongs[index].artist!.toLowerCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              trailing: SizedBox(
                                width: 30,
                                child: IconButton(
                                  onPressed: () {
                                    playlistSongs.removeAt(index);
                                    box.put(playlistnameId, playlistSongs);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
          },
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: const RadialGradient(
              colors: [
                Color(0xFF911BEE),
                Color(0xFF4D0089),
              ],
            ),
          ),
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: const Radius.circular(25).r)),
                backgroundColor: Colors.deepPurple,
                context: context,
                builder: (ctx) {
                  return SizedBox(
                    height: 350.h,
                    child: AddsongsToPlaylist(
                      playListName: playlistnameId,
                    ),
                  );
                },
              );
            },
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
