import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/getx/music_controller.dart';
import '../../model/musicdb.dart';
import '../homescreen/navbar/navbar.dart';
import '../splashscreen/splashscreen.dart';
import '../widget/openplayer.dart';
import 'addtofavoutie.dart';
import 'widget.dart';

class FavouriteMusicScreen extends StatelessWidget {
  FavouriteMusicScreen({super.key});
  final List<Songs> favouritesSongs = <Songs>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgrounColor(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Favourites'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.to(
                () => NavBar(),
              );
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: ((context) => NavBar()),
              //   ),
              // );
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: const Radius.circular(25).r),
                  ),
                  backgroundColor: Colors.deepPurple,
                  context: context,
                  builder: (BuildContext ctx) {
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
        body: GetBuilder<MusicController>(
          init: MusicController(),
          builder: (MusicController favController) {
            final List<Songs> favouritesSongs =
                box.get('favourites')! as List<Songs>;
             List<Audio> favSong = <Audio>[];

            for (final Songs item in favouritesSongs) {
              favSong.add(
                Audio.file(
                  item.path!,
                  metas: Metas(
                    id: item.id.toString(),
                    artist: item.artist.toString(),
                    title: item.songname.toString(),
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
                                  songId: favSong[index].metas.id.toString(),
                                ).openAssetPlayer(index: index, songs: favSong);
                                log('$favSong favourite song');
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
                                  favouritesSongs[index].songname.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                favouritesSongs[index].artist.toString(),
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
  return songs
      .firstWhere((Songs element) => element.id.toString().contains(id));
}
