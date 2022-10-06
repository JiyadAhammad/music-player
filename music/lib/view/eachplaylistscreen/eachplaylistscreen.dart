import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/playlist_controller/playlist_controller.dart';
import '../../model/musicdb.dart';
import '../Playlist/playlist.dart';
import '../constants/colors/colors.dart';
import '../nowplayingscreen/musicplayscreen.dart';
import '../splashscreen/splashscreen.dart';
import '../widget/openplayer.dart';
import 'widget.dart';

// ignore: must_be_immutable
class EachPlayList extends StatelessWidget {
  EachPlayList({
    super.key,
    required this.playlistnameId,
    required this.playListContrl,
  });
  String playlistnameId;

  List<Songs> playlistSongs = <Songs>[];
  List<Audio> finalaudioPLayLIst = <Audio>[];
  PlaylistController playListContrl;

  @override
  Widget build(BuildContext context) {
    playlistSongs = box.get(playlistnameId)!.cast<Songs>();
    return Container(
      decoration: backgrounColor(),
      child: Scaffold(
        backgroundColor: ktransparent,
        appBar: AppBar(
          backgroundColor: ktransparent,
          title: Text(playlistnameId),
          centerTitle: true,
          elevation: 0,
        ),
        body: GetBuilder<PlaylistController>(
          init: PlaylistController(),
          builder: (PlaylistController _) {
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
                        style: TextStyle(color: kwhiteText, fontSize: 25.sp),
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
                              color: kwhite54,
                              width: 2.0,
                            ),
                          ),
                          color: ktransparent,
                          elevation: 0,
                          child: Container(
                            height: 75,
                            decoration: BoxDecoration(
                              color: ktransparent,
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
                                  color: kwhiteIcon,
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
                                    color: kwhiteText,
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
                                    color: kwhiteText,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              trailing: SizedBox(
                                width: 30,
                                child: IconButton(
                                  onPressed: () {
                                    playListContrl.deleteSongInPlayList(
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
                                    color: kwhiteIcon,
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
                backgroundColor: kHomeColor,
                context: context,
                builder: (BuildContext ctx) {
                  return SizedBox(
                    height: 350.h,
                    child: AddsongsToPlaylist(
                      playListName: playlistnameId,
                      contrlPlayList: playListContrl,
                    ),
                  );
                },
              );
            },
            backgroundColor: ktransparent,
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
