import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music/dbmodel/dbfunction.dart';
import 'package:music/dbmodel/songmodel.dart';
import 'package:music/function/searchdelagete.dart';
import 'package:music/navdrawer/navdrawer.dart';
import 'package:music/screen/musicplayscreen.dart';
import 'package:music/screen/splashscreen.dart';

AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
bool boolfav = false;
var showsnackbar;

class HomeScreen extends StatefulWidget {
  static int index = 0;
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     setState(() {
//       play(audioPlayer);
//     });
//     super.initState();
// // log('${fullsonglist}from data');
//   }

  // Future<void> play(AssetsAudioPlayer assetsaudioPlayer) async {
  //   log('..........................!!!!!!!!!${HomeScreen.index}');
  //   // log('${fullsonglist}fullhome');
  //   // log('${allAudios.length} home all');
  //   // log('${allAudio.length}all home');

  //   // for (var i = 0; i < 3; i++) {
  //   //   widget.abc.add(Audio.file(
  //   //     musicValueNotifier.value[0].path![i],
  //   //   ));
  //   //   log('inside for loop ................${widget.abc.toString()}');
  //   // }

  //   await assetsaudioPlayer.open(
  //     Playlist(audios: fullsonglist),
  //     showNotification: false,
  //     autoStart: false,
  //     loopMode: LoopMode.playlist,
  //     notificationSettings: const NotificationSettings(
  //         stopEnabled: false, nextEnabled: true, prevEnabled: true),
  //   );
  // }

  @override
  void initState() {
    // setState(() {
    //   play(
    //     audioPlayer,
    //   );
    // });
    super.initState();
  }

  // Future<void> play(AssetsAudioPlayer assetAudioPlayer) async {
  //   await assetAudioPlayer.open(
  //     Playlist(audios: fullsonglist),
  //     notificationSettings: const NotificationSettings(
  //       stopEnabled: false,
  //     ),
  //     autoStart: true,
  //     showNotification: true,
  //     playInBackground: PlayInBackground.enabled,
  //     loopMode: LoopMode.playlist,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    getAllSongsDetails();
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
        drawer: const Navdrawer(),

        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('jMUSIC'),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearch(),
                );
              },
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: ValueListenableBuilder(
          valueListenable: musicValueNotifier,
          builder:
              (BuildContext context, List<Songs> songslist, Widget? child) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: fullsonglist.length,
                itemBuilder: (BuildContext context, int index) {
                  // final songdata = songslist[index];
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
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        // onTap: () {
                        // //  audioPlayer.playlistPlayAtIndex(index);
                        // },
                        //  onTap: () async {
                        //     await OpenPlayer(fullSongs: [], index: index)
                        //         .openAssetPlayer(
                        //       index: index,
                        //       songs: fullsonglist,
                        //     );
                        //   },
                        onTap: (() {
                          audioPlayer.playlistPlayAtIndex(index);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => MusicPlaySceeen(
                                allSongs: fullsonglist,
                                index: index,
                                songId: fullsonglist[index].metas.id.toString(),
                                audioPlayer: audioPlayer,
                                // path:musicpath
                              ),
                            ),
                          );

                          // audioPlayer.playlistPlayAtIndex(index);
                        }),
                        // leading: fullsonglist[index].metas.album!,
                        leading: const CircleAvatar(
                          // child:
                          child: Icon(
                            Icons.music_note,
                            color: Colors.white,
                          ),
                        ),
                        title: SizedBox(
                          height: 45,
                          // width: 200,
                          child: Marquee(
                            blankSpace: 20.0,
                            startAfter: Duration.zero,
                            velocity: 60,
                            // text: songdata.songtitle!,
                            text: fullsonglist[index].metas.title!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        // subtitle: SizedBox(
                        //   height: 20,
                        //   child: Marquee(
                        //      blankSpace: 100.0,
                        //     startAfter: Duration.zero,
                        //     velocity: 20,
                        //     text: fullsonglist[index].metas.artist!,
                        //      style: const TextStyle(
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 10,
                        //     ),
                        //   ),
                        // ),
                        subtitle: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            // songdata.songartist!,
                            fullsonglist[index].metas.artist!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        trailing: PopupMenuButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          color: Colors.black,
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                onTap: () async {
                                  // favouriteAudiodb.add(fullsonglist)
                                },
                                value: 'favourites',
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Add to favorite',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: (() {}),
                                value: 'playlist',
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.queue_music,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Add to playlist',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ];
                          },
                          onSelected: (value) {
                            if (value == 'favourites') {
                              // getFavourites(Path: musicpath.toString());
                              getsnackbar(context: context);
                            }
                            if (value == 'playlist') {
                              // return getPLopupaddvideos(context: context, path: path);
                            }
                          },
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
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
      ),
    );
  }

  @override
  void dispose() {
    bool isDisposed = false;
    super.dispose();
    audioPlayer.dispose();
    isDisposed = true;
  }
}
