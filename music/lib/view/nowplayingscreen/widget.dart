import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/musicdb.dart';
import '../Playlist/createplaylist.dart';
import '../Playlist/playlistitem.dart';
import '../constants/colors/colors.dart';
import '../constants/sizedbox/sizedbox.dart';
import '../splashscreen/splashscreen.dart';

Widget audioplayerUI(RealtimePlayingInfos realtimePlayingInfos) {
  // realtimePlayingInfos.isPlaying?isRotate=true:isRotate=false;
  return Column(
    children: <Widget>[
      kHeight5,
      slider(realtimePlayingInfos),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
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
        children: <Widget>[
          IconButton(
            onPressed: () {
              audioPlayer.previous();
            },
            icon: Icon(
              Icons.skip_previous,
              color: kwhiteIcon,
              size: 40.sp,
            ),
          ),
          Container(
            height: 60.h,
            width: 60.w,
            decoration: const BoxDecoration(
              color: kwhite,
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
                color: kwhiteIcon,
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
              color: kwhiteIcon,
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
      color: kwhiteText,
    ),
  );
}

String transformingString(int seconds) {
  final String minuteString =
      '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
  final String secondString =
      // ignore: noop_primitive_operations
      '${(seconds % 60).floor() < 10 ? 0 : ''}${(seconds % 60).floor()}';
  return '$minuteString:$secondString';
}

Widget slider(RealtimePlayingInfos realtimePlayingInfos) {
  return Stack(
    children: <Widget>[
      SliderTheme(
        data: const SliderThemeData(
          thumbColor: Colors.white,
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.grey,
          overlayColor: ktransparent,
        ),
        child: Slider.adaptive(
          value: realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
          max: realtimePlayingInfos.duration.inSeconds.toDouble(),
          onChanged: (double value) {
            if (value <= 0) {
              audioPlayer.seek(
                Duration.zero,
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

Future<dynamic> playlistshowbottomsheet(
    {required BuildContext context,
    required Songs playlistNames,
    required dynamic currentplaysong}) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: const Radius.circular(30).r,
      ),
    ),
    builder: (BuildContext ctx) {
      return Container(
        height: 350.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(30).r,
            topRight: const Radius.circular(30).r,
          ),
          gradient: const RadialGradient(
            colors: <Color>[
              Color(0xFF911BEE),
              Color(0xFF4D0089),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 30.r,
              backgroundColor: kblack,
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: kwhiteIcon,
                  size: 30.sp,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CreatePlaylist();
                    },
                  );
                },
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                PlaylistItem(
                  song: playlistNames,
                  countsong: 'song',
                )
              ],
            ),
          ],
        ),
      );
    },
  );
}
