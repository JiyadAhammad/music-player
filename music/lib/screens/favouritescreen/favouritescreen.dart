import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:marquee/marquee.dart';
import 'package:music/hivedb/musicdb.dart';
import 'package:music/screens/homescreen/navbar/navbar.dart';
import 'package:music/screens/homescreen/widget.dart';
import 'package:music/screens/nowplayingscreen/musicplayscreen.dart';
import 'package:music/screens/splashscreen/splashscreen.dart';
import 'package:music/widget/openplayer.dart';

class FavouriteMusicScreen extends StatelessWidget {
  FavouriteMusicScreen({Key? key}) : super(key: key);

  List<Audio> favSong = [];

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
          title: const Text('Favourites'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const NavBar()),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
              )),
        ),
        body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, favouritelist, child) {
            final favouritesSongs = box.get("favourites");
            return favouritesSongs!.isEmpty
                ? SizedBox(
                    child: Center(
                      child: Text(
                        'Favourite is Empty',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.sp,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: favouritesSongs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20).r,
                            side: const BorderSide(
                              color: Colors.white54,
                              width: 2.0,
                            ),
                          ),
                          color: Colors.transparent,
                          elevation: 0,
                          child: Container(
                            height: 75.h,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              onTap: () {
                                for (var item in favouritesSongs) {
                                  favSong.add(
                                    Audio.file(
                                      item.path,
                                      metas: Metas(
                                        id: item.id.toString(),
                                        artist: item.artist,
                                        title: item.songname,
                                      ),
                                    ),
                                  );
                                }
                                Openplayer(
                                        fullSongs: favSong,
                                        index: index,
                                        songId:
                                            favSong[index].metas.id.toString())
                                    .openAssetPlayer(
                                        index: index, songs: favSong);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => MusicPlaySceeen(
                                          allSongs: favSong,
                                          index: index,
                                          songId: favSong[index].metas.id!,
                                        )),
                                  ),
                                );
                                log("$favSong favourite song");
                              },
                              // onTap: () {
                              // var soong = favaudioDb!.favouriteAudio;
                              // log("$soong ><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>");
                              // for (var i = 0; i < soong!.length; i++) {
                              //   favSong.add(
                              //     Audio.file(
                              //       soong,
                              //       metas: Metas(
                              //         id: favaudioDb.id.toString(),
                              //         title: favaudioDb.songname,
                              //         artist: favaudioDb.artist,
                              //       ),
                              //     ),
                              //   );
                              // }
                              // for (var i = 0; i < favouritelist.length; i++) {
                              //   favSong.add(
                              //     Audio.file(
                              //       favdata!.toString(),
                              //       metas: Metas(
                              //         id: favdata.id.toString(),
                              //         title: favdata.songname,
                              //         artist: favdata.artist,
                              //       ),
                              //     ),
                              //   );
                              //   log(favdata.id.toString());
                              // }
                              // Iterable<dynamic> iterable = favaudioDb! as Iterable;
                              // for (var item in favrate ) {
                              //   favSong.add(
                              //     Audio.file(
                              //       favaudioDb.toString(),
                              //       metas: Metas(
                              //         id: favaudioDb!.id.toString(),
                              //         artist: favaudioDb.artist,
                              //         title: favaudioDb.songname,
                              //       ),
                              //     ),
                              //   );
                              //   log("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${favSong[index].metas.id}>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                              // }
                              // for (var i = 0;
                              //     i < favouritelist.values.length;
                              //     i++) {
                              //   favSong.add(
                              //     Audio.file(favaudioDb.toString(),
                              //         metas: Metas(
                              //           id: favaudioDb!.favouriteAudio.toString(),
                              //           title: favaudioDb.songname,
                              //           artist: favaudioDb.artist,
                              //         )),
                              //   );
                              // }
                              // for (var item in favrate) {
                              //   favSong.add(Audio.file(item.favouriteAudio.toString(),),)

                              // }
                              //   for (var item in favouritesSongs) {
                              //     favSong.add(
                              //       Audio.file(
                              //         item.songurl,
                              //         metas: Metas(
                              //           id: item.id.toString(),
                              //           artist: item.artist,
                              //           title: item.songname,
                              //         ),
                              //       ),
                              //     );
                              //   }
                              //   Openplayer(
                              //     fullSongs: favSong,
                              //     index: index,
                              //     songId: favSong[index].metas.id.toString(),
                              //   ).openAssetPlayer(
                              //     index: index,
                              //     songs: favSong,
                              //   );
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: ((context) => MusicPlaySceeen(
                              //             allSongs: favSong,
                              //             index: index,
                              //             songId: favSong[index].metas.id!,
                              //           )),
                              //     ),
                              //   );
                              // },
                              leading: const CircleAvatar(
                                child: Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                ),
                              ),
                              title: SizedBox(
                                height: 40.h,
                                child: Marquee(
                                  blankSpace: 50.w.h,
                                  startAfter: Duration.zero,
                                  velocity: 50,
                                  text: favouritesSongs[index].songname,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                              subtitle: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  favouritesSongs[index].artist,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              trailing: SizedBox(
                                width: 25,
                                child: popup(
                                    songId:
                                        favouritesSongs[index].id.toString(),
                                    context: context),
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
}

Songs databaseSongs(List<Songs> songs, String id) {
  return songs.firstWhere((element) => element.id.toString().contains(id));
}
// favouritesSongs!.isEmpty
//                 ? const SizedBox(
//                     child: Center(
//                       child: Text(
//                         'no favourites songs',
//                         style: TextStyle(color: Colors.green),
//                       ),
//                     ),
//                   )
//                 :