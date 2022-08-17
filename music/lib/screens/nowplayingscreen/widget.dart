import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/screens/splashscreen/splashscreen.dart';

Widget audioplayerUI(RealtimePlayingInfos realtimePlayingInfos) {
  return Column(
    children: [
      SizedBox(
        height: 5.h,
      ),
      slider(realtimePlayingInfos),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getTimeText(
            realtimePlayingInfos.currentPosition,
          ),
          getTimeText(realtimePlayingInfos.duration -
              realtimePlayingInfos.currentPosition),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              audioPlayer.previous();
            },
            icon: Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 40.sp,
            ),
          ),
          Container(
            height: 60.h,
            width: 60.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.topLeft,
            child: Center(
              child: IconButton(
                icon: Icon(
                  realtimePlayingInfos.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                iconSize: 40.h.w,
                color: Colors.black,
                onPressed: () {
                  audioPlayer.playOrPause();
                },
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              audioPlayer.next();
            },
            icon: Icon(
              Icons.skip_next,
              size: 40.sp,
              color: Colors.white,
            ),
          ),
        ],
      )
    ],
  );
}

Widget getTimeText(Duration currentValue) {
  return Text(
    transformingString(
      currentValue.inSeconds,
    ),
    style: const TextStyle(
      color: Colors.white,
    ),
  );
}

String transformingString(int seconds) {
  String minuteString =
      '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
  String secondString =
      '${(seconds % 60).floor() < 10 ? 0 : ''}${(seconds % 60).floor()}';
  return '$minuteString:$secondString';
}

Widget slider(RealtimePlayingInfos realtimePlayingInfos) {
  return Stack(
    children: [
      SliderTheme(
        data: const SliderThemeData(
          thumbColor: Colors.white,
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.grey,
          overlayColor: Colors.transparent,
        ),
        child: Slider.adaptive(
          value: realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
          max: realtimePlayingInfos.duration.inSeconds.toDouble(),
          min: 0,
          onChanged: (value) {
            if (value <= 0) {
              audioPlayer.seek(
                const Duration(
                  seconds: 0,
                ),
              );
            } else if (value >= realtimePlayingInfos.duration.inSeconds) {
              audioPlayer.seek(realtimePlayingInfos.duration);
            } else {
              audioPlayer.seek(
                Duration(
                  seconds: value.toInt(),
                ),
              );
            }
          },
        ),
      )
    ],
  );
}
