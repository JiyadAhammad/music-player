import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:music/view/homescreen/navbar/navbar.dart';
import 'package:music/view/nowplayingscreen/musicplayscreen.dart';
import 'package:music/view/splashscreen/splashscreen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container();
    return audioPlayer.builderCurrent(
      builder: (BuildContext context, Playing? playing) {
        final myAudio = find(fullSongs, playing!.audio.assetAudioPath);
        return Container(
          height: 60.h,
          decoration: BoxDecoration(
            // shape: BoxShape.rectangle,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20).r,
          ),
          child: ListTile(
            onTap: () {
              Get.to(
                () => MusicPlaySceeen(
                  allSongs: fullSongs,
                  songId: int.parse(myAudio.metas.id!).toString(),
                  index: 0,
                ),
              );
            },
            tileColor: Colors.black,
            leading: const CircleAvatar(
              // child:
              child: Icon(
                Icons.music_note,
                color: Colors.white,
              ),
            ),
            title: SizedBox(
              height: 20.h,
              child: Marquee(
                text: myAudio.metas.title!,
                style: const TextStyle(
                  color: Colors.white,
                ),
                velocity: 20,
                startAfter: Duration.zero,
                blankSpace: 100.w.h,
              ),
            ),
            trailing: PlayerBuilder.isPlaying(
              player: audioPlayer,
              builder: (context, isPlaying) {
                return IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                    size: 43.sp,
                  ),
                  onPressed: () {
                    audioPlayer.playOrPause();
                  },
                  color: Colors.white,
                );
              },
            ),
          ),
        );
      },
    );
  }
}