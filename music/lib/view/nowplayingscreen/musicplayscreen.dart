import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import '../../controller/getx/music_controller.dart';
import '../../main.dart';
import '../../model/musicdb.dart';
import '../favouritescreen/favouriteicon.dart';
import '../favouritescreen/favouritescreen.dart';
import '../homescreen/navbar/navbar.dart';
import '../splashscreen/splashscreen.dart';
import 'widget.dart';

class MusicPlaySceeen extends StatelessWidget {
  MusicPlaySceeen({
    super.key,
    this.songId,
    this.allSongs,
    this.index,
  });
  List<Audio>? allSongs = <Audio>[];
  final int? index;
  final String? songId;
  bool isRotate = true;
  List<dynamic> playlist = <dynamic>[];
  List<dynamic> playlistSongs = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    final Songs playlistName = databaseSongs(dbSongs, songId!);
    // log(dbsongs.toString());
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: <Color>[
            Color(0xFF911BEE),
            Color(0xFF4D0089),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('ΜΟΥΣΙΚΗ playing'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_drop_down_outlined,
              size: 35.sp,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: audioPlayer.builderCurrent(
            builder: (BuildContext context, Playing? playing) {
              final Audio myAudio = find(allSongs!, playing!.audio.audio.path);
              final Songs currentSong = dbSongs.firstWhere((Songs element) =>
                  element.id.toString() == myAudio.metas.id.toString());
              return Padding(
                padding: EdgeInsets.only(top: 50.h, left: 25.w, right: 25.w),
                child: Column(
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: musicController.animationController,
                      child: Image.asset(
                        'assets/img/musiclogo.png',
                      ),
                      builder: (BuildContext context, Widget? child) {
                        return Transform.rotate(
                          angle:
                              musicController.animationController.value * 6.3,
                          child: child,
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 50.h,
                            width: 250.w,
                            child: Marquee(
                              blankSpace: 50.w.h,
                              velocity: 60,
                              text: myAudio.metas.title!,
                              style: TextStyle(
                                fontSize: 25.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              myAudio.metas.artist!.toLowerCase(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GetBuilder<MusicController>(
                              init: MusicController(),
                              builder: (_) {
                                return IconButton(
                                  onPressed: () {
                                    if (musicController.isRepeate == false) {
                                      audioPlayer.setLoopMode(LoopMode.single);
                                      musicController.isLoopmode(
                                          true, Colors.black);
                                    } else {
                                      audioPlayer
                                          .setLoopMode(LoopMode.playlist);
                                      musicController.isLoopmode(
                                          false, Colors.white);
                                    }
                                  },
                                  icon: Icon(
                                    musicController.isRepeate == false
                                        ? Icons.loop
                                        : Icons.repeat_one,
                                    color: Colors.white,
                                    size: 30.sp,
                                  ),
                                );
                              }),
                          FavouriteIcon(
                            songId: myAudio.metas.id!,
                          ),
                          IconButton(
                            onPressed: () {
                              playlistshowbottomsheet(
                                  context: context,
                                  playlistNames: playlistName,
                                  currentplaysong: currentSong);
                            },
                            icon: Icon(
                              Icons.queue_music_sharp,
                              color: Colors.white,
                              size: 30.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    audioPlayer.builderRealtimePlayingInfos(
                      builder: (
                        BuildContext context,
                        RealtimePlayingInfos realtimePlayingInfos,
                      ) {
                        return audioplayerUI(realtimePlayingInfos);
                      },
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
