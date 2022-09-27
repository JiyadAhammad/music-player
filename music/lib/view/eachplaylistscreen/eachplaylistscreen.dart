import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/getx/music_controller.dart';
import '../../model/musicdb.dart';
import '../Playlist/playlist.dart';
import '../nowplayingscreen/musicplayscreen.dart';
import '../splashscreen/splashscreen.dart';
import '../widget/openplayer.dart';
import 'widget.dart';

// ignore: must_be_immutable
class EachPlayList extends StatelessWidget {
  EachPlayList({
    super.key,
    required this.playlistnameId,
  });
  String playlistnameId;

  List<Songs> playlistSongs = <Songs>[];
  List<Audio> finalaudioPLayLIst = <Audio>[];

  @override
  Widget build(BuildContext context) {
    playlistSongs = box.get(playlistnameId)!.cast<Songs>();
    return Container(
      decoration: backgrounColor(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(playlistnameId),
          centerTitle: true,
          elevation: 0,
        ),
        body: GetBuilder<MusicController>(
          init: MusicController(),
          builder: (MusicController playListController) {
            playlistSongs = box.get(playlistnameId)!.cast<Songs>();
            final List<Audio> playPlaylist = <Audio>[];

            for (final Songs item in playlistSongs) {
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
            log('$playPlaylist list song list');
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
                                Get.to(
                                  () => MusicPlaySceeen(
                                    allSongs: playPlaylist,
                                    index: index,
                                    songId: playPlaylist[index].metas.id,
                                  ),
                                );
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
                                    playListController.deleteSongInPlayList(
                                      playlistSongs,
                                      index,
                                      playlistnameId,
                                      playPlaylist,
                                    );
                                    finalaudioPLayLIst =
                                        playlistconvertintoAudio(playPlaylist);
                                    streamFunction(index, finalaudioPLayLIst);
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
          decoration: floatingActionBGColor(),
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: const Radius.circular(25).r),
                ),
                backgroundColor: Colors.deepPurple,
                context: context,
                builder: (BuildContext ctx) {
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

  void streamFunction(int index, List<Audio> finalplaylist) {
    audioPlayer.current.listen(
      (Playing? event) {
        if (event!.playlist.currentIndex != index) {
          audioPlayer.isPlaying;
        } else {
          Openplayer(
            fullSongs: finalplaylist,
            index: index,
            songId: finalplaylist[index].metas.id.toString(),
          ).openAssetPlayer(index: index, songs: finalplaylist);
        }
      },
    );
  }

  List<Audio> playlistconvertintoAudio(List<Audio> afterDeleteplaylist) {
    for (final Songs item in playlistSongs) {
      afterDeleteplaylist.add(
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
    return afterDeleteplaylist;
  }
}
