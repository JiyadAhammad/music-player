import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:music/controller/getx/music_controller.dart';
import 'package:music/main.dart';
import 'package:music/view/favouritescreen/favouriteicon.dart';
import 'package:music/view/favouritescreen/favouritescreen.dart';
import 'package:music/view/homescreen/navbar/navbar.dart';
import 'package:music/view/nowplayingscreen/widget.dart';
import 'package:music/view/splashscreen/splashscreen.dart';

class MusicPlaySceeen extends StatelessWidget {
  List<Audio>? allSongs = [];
  final int? index;
  final String? songId;
  MusicPlaySceeen({
    Key? key,
    this.songId,
    this.allSongs,
    this.index,
  }) : super(key: key);

  // with TickerProviderStateMixin {
  bool isRotate = true;

  List playlist = [];
  List<dynamic> playlistSongs = [];
  // @override
  // void initState() {
  //   super.initState();
  //   animationController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 7),
  //   );
  //   animationController.repeat();
  //   isRotate = true;
  // }

  @override
  Widget build(BuildContext context) {
    final playlistName = databaseSongs(dbSongs, songId!);
    // log(dbsongs.toString());
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
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
            builder: (context, Playing? playing) {
              final myAudio = find(allSongs!, playing!.audio.audio.path);
              final currentSong = dbSongs.firstWhere((element) =>
                  element.id.toString() == myAudio.metas.id.toString());
              // final currentsong = dbsongs!.firstWhere((e)=>e.id.toString() == myAudio.metas.id.toString());
              // log(currentsong.toString());
              return Padding(
                padding: EdgeInsets.only(top: 50.h, left: 25.w, right: 25.w),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: musicController.animationController,
                      child: Image.asset(
                        'assets/img/musiclogo.png',
                      ),
                      builder: (context, child) {
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
                        children: [
                          SizedBox(
                            height: 50.h,
                            width: 250.w,
                            child: Marquee(
                              blankSpace: 50.w.h,
                              startAfter: Duration.zero,
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
                        children: [
                          GetBuilder<MusicController>(
                              init: MusicController(),
                              builder: (_) {
                                return IconButton(
                                  onPressed: () {
                                    if (musicController.isRepeate == false) {
                                      audioPlayer.setLoopMode(LoopMode.single);
                                      musicController.isLoopmode(
                                          true, Colors.black);
                                      // setState(
                                      //   () {
                                      //     isRepeate = true;
                                      //     color = Colors.black;
                                      //   },
                                      // );
                                    } else {
                                      audioPlayer
                                          .setLoopMode(LoopMode.playlist);
                                      musicController.isLoopmode(
                                          false, Colors.white);
                                      // setState(
                                      //   () {
                                      //     isRepeate = false;
                                      //     color = Colors.white;
                                      //   },
                                      // );
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
                              // addtoPlaylistinNowpalying(context: context);
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
                        context,
                        RealtimePlayingInfos realtimePlayingInfos,
                      ) {
                        return audioplayerUI(realtimePlayingInfos);
                      },
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    // if(audioPlayer.isPlaying==playing){
                    //   isRotate=true;
                    // }else{
                    //   isRotate=false
                    // }
                    // slider(),
                    // audioPlayer.isPlaying
                    //     ? isRotate = true
                    //     : isRotate = false,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   musicController.animationController.dispose();
  //   super.dispose();
  // }
}
