import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/model/musicdb.dart';
// import 'package:hive_flutter/adapters.dart';
import 'package:music/view/favouritescreen/addtofavoutie.dart';
import 'package:music/view/favouritescreen/widget.dart';
import 'package:music/view/homescreen/navbar/navbar.dart';
// import 'package:music/screens/nowplayingscreen/musicplayscreen.dart';
import 'package:music/view/splashscreen/splashscreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/view/widget/openplayer.dart';

class FavouriteMusicScreen extends StatelessWidget {
  const FavouriteMusicScreen({Key? key}) : super(key: key);

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
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: const Radius.circular(25).r)),
                  backgroundColor: Colors.deepPurple,
                  context: context,
                  builder: (ctx) {
                    return SizedBox(
                      height: 350.h,
                      child: const Addtofavourite(),
                    );
                  },
                );
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, favouritelist, child) {
            final favouritesSongs = box.get("favourites");
            List<Audio> favSong = [];

            for (var item in favouritesSongs!) {
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
            return favouritesSongs.isEmpty
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
                                Openplayer(
                                        fullSongs: favSong,
                                        index: index,
                                        songId:
                                            favSong[index].metas.id.toString())
                                    .openAssetPlayer(
                                        index: index, songs: favSong);
                                log("$favSong favourite song");
                              },
                              leading: const CircleAvatar(
                                child: Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                ),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(
                                        left: 5.0, bottom: 3, top: 3)
                                    .r,
                                child: Text(
                                  favouritesSongs[index].songname,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                              // title: SizedBox(
                              //   height: 40.h,
                              //   child: Marquee(
                              //     blankSpace: 50.w.h,
                              //     startAfter: Duration.zero,
                              //     velocity: 50,
                              //     text: favouritesSongs[index].songname,
                              //     style: TextStyle(
                              //       overflow: TextOverflow.ellipsis,
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 20.sp,
                              //     ),
                              //   ),
                              // ),
                              subtitle: Text(
                                favouritesSongs[index].artist,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                              trailing: SizedBox(
                                width: 25,
                                child: FavPopup(
                                  songId: favouritesSongs[index].id.toString(),
                                  // context: context),
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
}

Songs databaseSongs(List<Songs> songs, String id) {
  return songs.firstWhere((element) => element.id.toString().contains(id));
}
