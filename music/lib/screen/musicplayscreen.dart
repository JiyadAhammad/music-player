import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music/screen/playlist.dart';

class MusicPlaySceeen extends StatefulWidget {
  final index;
  final songtitle;
  // final songpath;
  const MusicPlaySceeen({
    Key? key,
    this.index,
    this.songtitle,
    // this.songpath,
  }) : super(key: key);

  @override
  State<MusicPlaySceeen> createState() => _MusicPlaySceeenState();
}

class _MusicPlaySceeenState extends State<MusicPlaySceeen> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  bool isRepeat = false;
  Color color = Color.fromARGB(255, 235, 139, 171);

  // @override
  // void initState() {
  //   super.initState();
  //   setupPlaylist();
  // }

  // void setupPlaylist() async {
  //   audioPlayer.open(
  //     Playlist(
  //       audios: [
  //         Audio(
  //           'assets/audio/01 Sanam Teri Kasam.mp3',
  //           metas: Metas(title: widget.songtitle, artist: '<unknown>'),
  //         ),
  //         Audio(
  //           'assets/audio/Arabic Kuthu.mp3',
  //           metas: Metas(
  //             title: 'Arabic Kuthu',
  //             artist: '<unknown>',
  //           ),
  //         ),
  //         Audio(
  //           'assets/audio/audio1.mp3',
  //           metas: Metas(
  //             title: 'vikram-surya',
  //             artist: '<unknown>',
  //           ),
  //         ),
  //         Audio(
  //           'assets/audio/audio2.mp3',
  //           metas: Metas(
  //             title: 'vikram -theme',
  //             artist: '<unknown>',
  //           ),
  //         ),
  //         Audio(
  //           'assets/audio/audio3.mp3',
  //           metas: Metas(
  //             title: 'messi',
  //             artist: '<unknown>',
  //           ),
  //         ),
  //         Audio(
  //           'assets/audio/Kutti Story.mp3',
  //           metas: Metas(
  //             title: 'Kutty Story',
  //             artist: '<unknown>',
  //           ),
  //         ),
  //         Audio(
  //           'assets/audio/Master the Blaster.mp3',
  //           metas: Metas(
  //             title: 'Master the Balaster',
  //             artist: '<unknown>',
  //           ),
  //         ),
  //         Audio(
  //           'assets/audio/Mehabooba-Malayalam.mp3',
  //           metas: Metas(
  //             title: 'Mehabooba',
  //             artist: '<unknown>',
  //           ),
  //         ),
  //         Audio(
  //           'assets/audio/Sanam Re.mp3',
  //           metas: Metas(title: 'Sanam Re', artist: '<unknown>'),
  //         ),
  //         Audio(
  //           'assets/audio/Sulthana.mp3',
  //           metas: Metas(title: 'KGF Sulthana', artist: '<unknown>'),
  //         ),
  //         Audio(
  //           'assets/audio/Vaathi Coming.mp3',
  //           metas: Metas(title: 'Vaathi comming', artist: '<unknown>'),
  //         ),

  //         // widget.index,
  //       ],
  //     ),
  //     notificationSettings: const NotificationSettings(
  //       stopEnabled: false,
  //     ),
  //     autoStart: true,
  //     playInBackground: PlayInBackground.enabled,
  //     loopMode: LoopMode.playlist,
  //   );
  // }

  // @override
  // void dispose() {
  //   audioPlayer.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final songtitle= songtitle[index];
    // final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('NowPlaying'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: ((context) => const NavBar()),
              //   ),
              // );
            },
            icon: const Icon(
              Icons.expand_more,
            ),
          ),
        ),
        body: SafeArea(
          child: audioPlayer.builderRealtimePlayingInfos(
            builder: ((context, realtimePlayingInfos) {
              // if (realtimePlayingInfos != null) {
              return audioplayerUI(realtimePlayingInfos);
              // } else {
              //   return Container();
              // }
            }),
          ),
        ),
      ),
    );
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    audioPlayer.seek(newDuration);
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
                audioPlayer.seek(Duration(seconds: 0));
              } else if (value >= realtimePlayingInfos.duration.inSeconds) {
                audioPlayer.seek(realtimePlayingInfos.duration);
              } else {
                audioPlayer.seek(Duration(seconds: value.toInt()));
              }
            },
          ),
        )
      ],
    );
  }

  Widget getTimeText(Duration currentValue) {
    return Text(
      transformingString(currentValue.inSeconds),
      style: const TextStyle(color: Colors.white),
    );
  }

  String transformingString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString =
        '${(seconds % 60).floor() < 10 ? 0 : ''}${(seconds % 60).floor()}';
    return '$minuteString:$secondString';
  }

  Widget audioplayerUI(RealtimePlayingInfos realtimePlayingInfos) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
      child: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/musiclogo.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Text(
                  " ${realtimePlayingInfos.current?.audio.audio.metas.title}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  " ${realtimePlayingInfos.current?.audio.audio.metas.artist}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if (isRepeat == false) {
                      audioPlayer.setLoopMode(LoopMode.single);
                      setState(
                        () {
                          isRepeat = true;
                          color = Colors.black;
                        },
                      );
                    } else {
                      audioPlayer.setLoopMode(LoopMode.playlist);
                      setState(
                        () {
                          isRepeat = false;
                          color = Colors.white;
                        },
                      );
                    }
                  },
                  icon: Icon(
                    isRepeat == false ? Icons.loop : Icons.repeat_one,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      builder: (context) {
                        return Container(
                          height: 350,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            gradient: RadialGradient(
                              colors: [
                                Color(0xFF911BEE),
                                Color(0xFF4D0089),
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.black,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          title: const Text('Playlist Name'),
                                          content: TextFormField(
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Playlist Name',
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context, 'ok');
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 4 / 3,
                                  ),
                                  itemCount: listofitemsgrid.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 15, 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Colors.white54,
                                            style: BorderStyle.solid,
                                            width: 2.5,
                                          ),
                                          color: Colors.transparent,
                                        ),
                                        child: Center(
                                          child: Text(
                                            listofitemsgrid[index],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.queue_music,
                    size: 35,
                    color: Colors.white,
                  ),
                )
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     Icons.shuffle,
                //     color: Colors.pink[100],
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          slider(realtimePlayingInfos),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // timeStamp(realtimePlayingInfos)
              getTimeText(
                realtimePlayingInfos.currentPosition,
              ),
              getTimeText(realtimePlayingInfos.duration -
                  realtimePlayingInfos.currentPosition),
            ],
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  audioPlayer.previous();
                },
                icon: const Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(realtimePlayingInfos.isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill_outlined),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: () {
                    audioPlayer.playOrPause();
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  audioPlayer.next();
                },
                icon: const Icon(
                  Icons.skip_next,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
