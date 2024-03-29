import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/favourite_controller/favourite_controller.dart';
import '../../model/musicdb.dart';
import '../constants/colors/colors.dart';
import '../homescreen/navbar/navbar.dart';
import '../splashscreen/splashscreen.dart';
import '../widget/openplayer.dart';
import 'addtofavoutie.dart';
import 'widget.dart';

List<dynamic> favouritesSongs = <dynamic>[];

class FavouriteMusicScreen extends StatelessWidget {
  FavouriteMusicScreen({super.key});

  final FavouriteController favouriteController =
      Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    favouritesSongs = box.get('favourites')!;
    return Container(
      decoration: backgrounColor(),
      child: Scaffold(
        backgroundColor: ktransparent,
        appBar: AppBar(
          backgroundColor: ktransparent,
          title: const Text('Favourites'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.to(
                () => NavBar(),
              );
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
                  backgroundColor: kHomeColor,
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
        body: GetBuilder<FavouriteController>(
          init: FavouriteController(),
          builder: (FavouriteController favController) {
            final List<Audio> favSong = <Audio>[];

            for (final dynamic item in favouritesSongs) {
              favSong.add(
                Audio.file(
                  item.path!.toString(),
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
                          color: kwhiteText,
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
                              color: kwhite54,
                              width: 2.0,
                            ),
                          ),
                          color: ktransparent,
                          elevation: 0,
                          child: Container(
                            height: 75.h,
                            decoration: BoxDecoration(
                              color: ktransparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              onTap: () {
                                Openplayer(
                                  fullSongs: favSong,
                                  index: index,
                                  songId: favSong[index].metas.id.toString(),
                                ).openAssetPlayer(
                                  index: index,
                                  songs: favSong,
                                );
                              },
                              leading: const CircleAvatar(
                                child: Icon(
                                  Icons.music_note,
                                  color: kwhiteIcon,
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
                                    color: kwhiteText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                favouritesSongs[index].artist.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: kwhiteText,
                                  fontSize: 16.sp,
                                ),
                              ),
                              trailing: SizedBox(
                                width: 25,
                                child: FavPopup(
                                  songId: favouritesSongs[index].id.toString(),
                                  controlfav: favouriteController,
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
