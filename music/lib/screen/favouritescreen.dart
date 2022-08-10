import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/dbmodel/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/navbar/navbar.dart';
import 'package:music/screen/musicplayscreen.dart';
import 'package:music/screen/splashscreen.dart';

class FavouriteMusicScreen extends StatefulWidget {
  const FavouriteMusicScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteMusicScreen> createState() => _FavouriteMusicScreenState();
}

class _FavouriteMusicScreenState extends State<FavouriteMusicScreen> {
  List<Audio> favSong = [];
  // List<dynamic> audioinfavourite = [];
  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Favourite'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => NavBar()),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
              )),
        ),
        body: ValueListenableBuilder(
          valueListenable: favouriteDb.listenable(),
          builder: (BuildContext context, Box<Favourite> favouritelist,
              Widget? child) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ListView.builder(
                itemCount: favouriteDb.values.length,
                itemBuilder: (BuildContext context, int index) {
                  Favourite? favaudioDb = favouriteDb.getAt(index);
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
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        onTap: () {
                           List<dynamic> audioinfavourite;
                           audioinfavourite = getList(favouritelist.values.toList());
                          // audioinfavourite =
                          //     getList(favouritelist.values.toList());
                          // log("${audioinfavourite[index]}    before loop");
                          // log("${favaudioDb!.favouriteAudio}db");
                          for (var item in audioinfavourite) {
                            log("message in satrting loop");
                            favSong.add(
                              Audio.file(
                                audioinfavourite[item],
                                metas: Metas(
                                  id:musicId[item].toString() ,
                                  title:musicTitles[item],
                                  artist: musicArtist[item],
                                ),
                              ),
                            );
                            log("$favSong songs in audio inside loop");
                            // log("$audioinfavourite indide loop");
                          }
                          // log("${favSong} songs in audio ouside loop");
                          // log("$audioinfavourite after loop");
                          // final audioinfavourite = favaudioDb.getAt(index);
                          // favSong=getList();
                          // for (var item in audioinfavourite) {
                          //   favSong.add(
                          //     Audio.file(
                          //       item.path,
                          //       metas: Metas(
                          //         id: item.musicId.toString(),
                          //         title: item.songtitle,
                          //         artist: item.songartist,
                          //       ),
                          //     ),
                          //   );
                          // }
                          // for (var i = 0; i < ; i++) {
                          //   favSong.add(Audio.file(
                          //     (favouritelist.toString() ),
                          //     metas: Metas(
                          //       id: musicId[i].toString(),
                          //       title: musicTitles[i],
                          //       artist: musicArtist[i],
                          //     ),
                          //   ));
                          // }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: ((context) => MusicPlaySceeen(
                          //           allSongs: favSong,
                          //           index: index,
                          //           songId: favSong[index].metas.title,
                          //         )),
                          //   ),
                          // );

                          
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: ((context) => MusicPlaySceeen(
                          //       songId: result[index],
                          //       index: index,
                          //           // songId: result[index],
                          //           // allSongs: fullsonglist,
                          //           // index: index,
                          //           // songId:
                          //           //     fullsonglist[index].metas.id.toString(),
                          //           // audioPlayer: audioPlayer,
                          //         )),
                          //   ),
                          // );
                        },
                        leading: const CircleAvatar(
                          child: Icon(
                            Icons.music_note,
                            color: Colors.white,
                          ),
                        ),
                        title: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            favaudioDb!.favouriteAudio!.trim().toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        subtitle: const SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            '<Favourite>',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        // trailing: Icon(Icons.abc,color: Colors.white,),
                        trailing:
                            SizedBox(width: 25, child: deleteFav(index: index)),
                        // trailing: IconButton(
                        //   onPressed: () {
                        //     favouriteDb.deleteAt(index);
                        //     // if (favouritelist.id != null) {
                        //     //   deleteFromFavourite(favouritelist.id);
                        //     // }

                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //         backgroundColor: Colors.red,
                        //         margin: EdgeInsets.all(20),
                        //         behavior: SnackBarBehavior.floating,
                        //         content: Center(
                        //             heightFactor: 1.0,
                        //             child: Text(
                        //               "Succesfully removed",
                        //             )),
                        //         duration: Duration(seconds: 1),
                        //         shape: StadiumBorder(),
                        //         elevation: 100,
                        //       ),
                        //     );
                        //   },
                        //   icon: const Icon(
                        //     Icons.remove_circle,
                        //     color: Colors.white,
                        //   ),
                        // ),
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

  List<String> getList(List<Favourite> list) {
    List<String>? audioPath = [];
    for (Favourite obj in list) {
      audioPath.add(obj.favouriteAudio!);
    }
    return audioPath;
  }

  Widget deleteFav({required index}) {
    return PopupMenuButton(
      padding: EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      onSelected: (value) {
        favouriteDb.deleteAt(index);
      },
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      color: Colors.black,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'Fav',
          child: Row(
            children: const [
              Icon(
                Icons.remove_circle_outline,
                color: Colors.red,
              ),
              Text(
                "Remove",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
