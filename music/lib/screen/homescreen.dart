import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music/dbmodel/dbfunction.dart';
import 'package:music/dbmodel/songmodel.dart';
import 'package:music/function/searchdelagete.dart';
import 'package:music/main.dart';
import 'package:music/navdrawer/navdrawer.dart';
import 'package:music/screen/eachplaylistscreen.dart';
import 'package:music/screen/musicplayscreen.dart';
import 'package:music/screen/playlist.dart';
import 'package:music/screen/splashscreen.dart';
import 'package:hive_flutter/adapters.dart';

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
  //

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
                itemCount: songslist.length,
                itemBuilder: (BuildContext context, int index) {
                  Songs? audio = box.getAt(index);
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
                          // audioPlayer.playlistPlayAtIndex(index);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => MusicPlaySceeen(
                                allSongs: fullsonglist,
                                index: index,
                                songId: fullsonglist[index].metas.id.toString(),
                                audioPlayer: audioPlayer,
                                path: audio!.songtitle,
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

                        trailing: popup(
                          path: audio!.songtitle,
                          context: context,
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

  // @override
  // void dispose() {
  //   bool isDisposed = false;
  //   super.dispose();
  //   audioPlayer.dispose();
  //   isDisposed = true;
  // }

  Widget popup({required path, required context}) {
    return PopupMenuButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      color: Colors.black,
      onSelected: (value) {
        if (value == 'Fav') {
          addToFavourite(path: path);
          getsnackbar(context: context);
        }
        if (value == 'playlist') {
          getPLopupaddvideos(context: context, path: path);
        }
      },
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () async {
            // favouriteAudiodb.add(fullsonglist)
          },
          value: 'Fav',
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
      ],
    );
  }

  getPLopupaddvideos({required context, required path}) {
    GlobalKey<FormState> formkey = GlobalKey();
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
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
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
                  builder: (BuildContext context, Box<PlaylistName> value,
                      Widget? child) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 4 / 3,
                      ),
                      itemCount: value.length,
                      itemBuilder: (BuildContext context, int index) {
                        PlaylistName? nameplaylist = playlistDb.getAt(index);
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: InkWell(
                            onTap: () {
                              PlaylistData object = PlaylistData(
                                  playlistAudio: path,
                                  playlistName: nameplaylist.toString());
                              playlistdataDb.add(object);
                              print(playlistdataDb.length);
                              Navigator.pop(context);

                              // ScaffoldMessenger.of(context).showSnackBar( getSnackBarTwo(context: context));

                              // <><><><><><><><><><><><><>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white54,
                                  style: BorderStyle.solid,
                                  width: 2.5,
                                ),
                                color: Colors.transparent,
                              ),
                              child: Center(
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
  }
  // getPLopupaddvideos({required context, required path}) {
  //   GlobalKey<FormState> formkey = GlobalKey();
  //   final controller = TextEditingController();
  //   return showDialog(
  //       context: context,
  //       builder: (ctx1) {
  //         return Form(
  //           key: formkey,
  //           child: AlertDialog(
  //             title: const Text(
  //               "Add audio to Playlist",
  //             ),
  //             content: SizedBox(
  //               height: 300,
  //               child: Column(
  //                 children: [
  //                   TextFormField(
  //                     autovalidateMode: AutovalidateMode.onUserInteraction,
  //                     controller: controller,
  //                     decoration: const InputDecoration(
  //                       border: OutlineInputBorder(),
  //                     ),
  //                     // validator: (value) {
  //                     //   if (value!.isEmpty) {
  //                     //     return "Invalid the Folder name is empty!";
  //                     //   } else if (getplaylistsatus(playlistpath: value)) {
  //                     //     return "Already exist";
  //                     //   }
  //                     // },
  //                   ),
  //                   TextButton.icon(
  //                       onPressed: () {
  //                         if (formkey.currentState!.validate()) {
  //                           PlaylistName objplaylist =
  //                               PlaylistName(playlistName: controller.text);
  //                           playlistDb.add(objplaylist);
  //                           // Navigator.pop(context);

  //                           // ScaffoldMessenger.of(context)
  //                           //     .showSnackBar(getSnackBarOne(context: context));
  //                           // log("Added");
  //                         }
  //                       },
  //                       icon: Icon(Icons.add),
  //                       label: Text("Add")),
  //                   Expanded(
  //                     child: SizedBox(
  //                       height: 300,
  //                       width: 300,
  //                       child: ValueListenableBuilder(
  //                         valueListenable: playlistDb.listenable(),
  //                         builder: (BuildContext context,
  //                                 Box<PlaylistName> listenplaylist,
  //                                 Widget? child) =>
  //                             GridView.builder(
  //                           gridDelegate:
  //                               const SliverGridDelegateWithFixedCrossAxisCount(
  //                             crossAxisCount: 2,
  //                             childAspectRatio: 4 / 3,
  //                           ),
  //                           itemCount: listenplaylist.length,
  //                           itemBuilder: (BuildContext context, int index) {
  //                            PlaylistName? playlistnameDb = playlistDb.getAt(index);
  //                             return Padding(
  //                               padding:
  //                                   const EdgeInsets.fromLTRB(15, 10, 15, 10),
  //                               child: InkWell(
  //                                 onTap: () {
  //                                   PlaylistData object = PlaylistData(
  //                                       playlistAudio: path,
  //                                       playlistName: playlistnameDb.toString());
  //                                   playlistdataDb.add(object);
  //                                   // print(playlistdataDb.length);
  //                                   // Navigator.pop(context);

  //                                   // ScaffoldMessenger.of(context).showSnackBar( getSnackBarTwo(context: context));

  //                                   // <><><><><><><><><><><><><>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  //                                 },
  //                                 child: Container(
  //                                   decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(15),
  //                                     border: Border.all(
  //                                       color: Colors.white54,
  //                                       style: BorderStyle.solid,
  //                                       width: 2.5,
  //                                     ),
  //                                     color: Colors.transparent,
  //                                   ),
  //                                   child: Center(
  //                                     child: Text(
  //                                       playlistnameDb!.playlistName.toString(),
  //                                       style: const TextStyle(
  //                                         color: Colors.white,
  //                                         fontSize: 20,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             );
  //                           },
  //                         ),
  //                         // ? emptyDisplay("Videos")
  //                         //  ListView.builder(
  //                         //   shrinkWrap: true,
  //                         //   itemCount: playlistDb.values.length,
  //                         //   itemBuilder:
  //                         //       (BuildContext context, int index) {
  //                         //     PlaylistName? playlistobj =
  //                         //         playlistDb.getAt(index);
  //                         //     return PopPlaylistFolder(
  //                         //       folderName: playlistobj!,
  //                         //       index: index,
  //                         //       videoPath: path,
  //                         //     );
  //                         //   },
  //                         // ),
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }

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
    final playlistvalue = PlaylistName(playlistName: palyListNameValidate);
    playlistDb.add(playlistvalue);
    // final key=playlistDb.get()
//     playlistDb.add(playlistvalue);
//     log('$playlistvalue hdfshaklfhl');
//  playlist= playlistDb.keys.toList();
  }
}

addToFavourite({required path}) async {
  List<Favourite> favList = favouriteDb.values.toList();
  List<Favourite> result =
      favList.where((checking) => checking.favouriteAudio == path).toList();
  if (result.isEmpty) {
    var favobj = Favourite(favouriteAudio: path);
    favouriteDb.add(favobj);
    // path.id=id;
    log(result.toString());
  } else {
    boolfav = true;
  }
}

getsnackbar({
  required context,
}) {
  if (boolfav == true) {
    showsnackbar = SnackBar(
        content: const Text(
          'Already added in favourites',
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ));
  } else {
    showsnackbar = SnackBar(
        content: const Text(
          'Added',
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ));
  }
  ScaffoldMessenger.of(context).showSnackBar(showsnackbar);
}
// PopupMenuButton(
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(15.0),
//                             ),
//                           ),
//                           color: Colors.black,
//                           itemBuilder: (context) {
//                             return [
//                               PopupMenuItem(
//                                 onTap: () async {
//                                   // favouriteAudiodb.add(fullsonglist)
//                                 },
//                                 value: 'favourites',
//                                 child: Row(
//                                   children: const [
//                                     Icon(
//                                       Icons.favorite,
//                                       color: Colors.white,
//                                     ),
//                                     Text(
//                                       'Add to favorite',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               PopupMenuItem(
//                                 onTap: (() {}),
//                                 value: 'playlist',
//                                 child: Row(
//                                   children: const [
//                                     Icon(
//                                       Icons.queue_music,
//                                       color: Colors.white,
//                                     ),
//                                     Text(
//                                       'Add to playlist',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ];
//                           },
//                           onSelected: (value) {
//                             if (value == 'favourites') {
                           
//                               addToFavourite(audio!.path );
//                               getsnackbar(context: context);
//                             }
//                             if (value == 'playlist') {
//                               // return getPLopupaddvideos(context: context, path: path);
//                             }
//                           },
//                           icon: const Icon(
//                             Icons.more_vert,
//                             color: Colors.white,
//                           ),
//                         ),