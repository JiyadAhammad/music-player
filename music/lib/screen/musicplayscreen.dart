import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:marquee/marquee.dart';
import 'package:music/dbmodel/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/navbar/navbar.dart';
import 'package:music/screen/homescreen.dart';
import 'package:music/screen/playlist.dart';
import 'package:music/screen/splashscreen.dart';
import 'package:hive_flutter/adapters.dart';

class MusicPlaySceeen extends StatefulWidget {
  List<Audio>? allSongs = [];
  int? index;
  final String? songId;
  AssetsAudioPlayer? audioPlayer;
  List<Audio>? music;
  final path;

  // final songpath;
  MusicPlaySceeen({
    Key? key,
    this.allSongs,
    this.index,
    this.songId,
    this.audioPlayer,
    this.music, this.path,
  }) : super(key: key);

  @override
  State<MusicPlaySceeen> createState() => _MusicPlaySceeenState();
}

class _MusicPlaySceeenState extends State<MusicPlaySceeen>
    with SingleTickerProviderStateMixin {
      
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  bool isRepeat = false;
  Color color = const Color.fromARGB(255, 235, 139, 171);
  late AnimationController animationController;

  @override
  void initState() {
    setState(() {
      playSong(
        audioPlayer,
      );
    });

    super.initState();
// log('${fullsonglist}from data');
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    );
    animationController.repeat();
  }

  Future<void> playSong(AssetsAudioPlayer assetAudioPlayer) async {
    await assetAudioPlayer.open(
      Playlist(audios: fullsonglist, startIndex: widget.index!),
      notificationSettings: const NotificationSettings(
        stopEnabled: false,
      ),
      autoStart: true,
      showNotification: true,
      playInBackground: PlayInBackground.enabled,
      loopMode: LoopMode.playlist,
    );
  }

  //  void setupPlaylist(){
  //   audioPlayer.open(Playlist(
  //     audios: [
  //       Audio.file(
  //         widget.allSongs.toString(),
  //         metas: Metas(
  //           title:'sample',
  //           artist: '<Unknown>'
  //         ),
  //       ),
  //     ]
  //   ));
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
              // Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => NavBar(
                      // index: widget.index,
                      // title: fullsonglist,

                      )),
                ),
              );
            },
            icon: const Icon(
              Icons.expand_more,
            ),
          ),
        ),
        body: audioPlayer.builderRealtimePlayingInfos(
          builder: ((context, realtimePlayingInfos) {
            // if (realtimePlayingInfos != null) {
            return audioplayerUI(realtimePlayingInfos);
            // } else {
            //   return Container();
            // }
          }),
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

  Widget audioplayerUI(RealtimePlayingInfos realtimePlayingInfos) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: animationController,
            child: Image.asset(
              'assets/img/musiclogo.png',
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: animationController.value * 6.3,
                child: child,
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              SizedBox(
                height: 50,
                width: 200,
                child: Marquee(
                  blankSpace: 20.0,
                  startAfter: Duration.zero,
                  velocity: 60,
                  text: realtimePlayingInfos.current!.audio.audio.metas.title
                      .toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // SizedBox(
              //   height: 30,
              //   width: 200,
              //   child: Marquee(
              //     blankSpace: 50.0,
              //     startAfter: Duration.zero,
              //     velocity: 50,
              //     text: realtimePlayingInfos.current!.audio.audio.metas.artist
              //         .toString(),
              //     style: const TextStyle(
              //       color: Colors.white,
              //       fontSize: 15,
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  realtimePlayingInfos.current!.audio.audio.metas.artist
                      .toString(),
                  // '<unknown>',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 25),
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
                  
                  onPressed: () {
                    Songs? audio = box.getAt(widget.index!);
                    addToFavourite(path: audio!.songtitle);
                    getsnackbar(context: context);
                  },
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
                                            controller: nameController,
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
                                          actions: [
                                            TextButton(
                                              
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                onOkButtonPressed(context);
                                                
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
                                child: ValueListenableBuilder(
                                  valueListenable: playlistDb.listenable(),

                                  builder: (BuildContext context, Box<PlaylistName> value, Widget? child) {  
                                  return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 4 / 3,
                                    ),
                                    itemCount: value.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                          PlaylistName? nameplaylist = playlistDb.getAt(index);
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 15, 10),
                                        child: InkWell(
                                          onTap: () {
                              PlaylistData object = PlaylistData(
                                  playlistAudio: widget.path,
                                  playlistName: nameplaylist.toString());
                              playlistdataDb.add(object);
                              print(playlistdataDb.length);
                              Navigator.pop(context);

                              // ScaffoldMessenger.of(context).showSnackBar( getSnackBarTwo(context: context));

                              // <><><><><><><><><><><><><>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                            },
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
                                            child:  Center(
                                              child: Text(
                                                nameplaylist!.playlistName.toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
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
  onOkButtonPressed(BuildContext contxt) {
    final palyListNameValidate = nameController.text.trim();
    // log('$palyListNameValidate values in plaulisdy');
    if (palyListNameValidate.isEmpty) {
      ScaffoldMessenger.of(contxt).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 206, 14, 0),
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text("Name cannot be null"),
          duration: Duration(seconds: 1)));
      return;
    }
    if (palyListNameValidate == 'favourite') {
      ScaffoldMessenger.of(contxt).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 206, 14, 0),
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text("Enter valid Name"),
          duration: Duration(seconds: 1)));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color.fromARGB(255, 49, 185, 11),
        margin: EdgeInsets.all(30),
        behavior: SnackBarBehavior.floating,
        content: Center(
          heightFactor: 1.0,
          child: Text(
            "Added Succesfully",
          ),
        ),
        duration: Duration(seconds: 1),
        shape: StadiumBorder(),
        elevation: 100,
      ),
    );
    Navigator.pop(context, 'ok');
    // final playlisvalue = PlaylistName(
    //   playlistName: palyListNameValidate,
    // );
    final playlistvalue = PlaylistName(
      
      playlistName: palyListNameValidate
    
    );
    playlistDb.add(playlistvalue);
    // final key=playlistDb.get()
//     playlistDb.add(playlistvalue);
//     log('$playlistvalue hdfshaklfhl');
//  playlist= playlistDb.keys.toList();
 }

//   void deletedPlayList(int index) {
    
//   }
 @override
  void dispose() {
    bool isDisposed = false;
    super.dispose();
    audioPlayer.dispose();
    isDisposed = true;
  }
}
