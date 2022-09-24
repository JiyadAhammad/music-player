import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/view/homescreen/search/searchdelagete.dart';
import 'package:music/view/homescreen/navdrawer/navdrawer.dart';
import 'package:music/view/homescreen/widget.dart';
import 'package:music/view/splashscreen/splashscreen.dart';
import 'package:music/view/widget/openplayer.dart';

bool boolfav = false;
// ignore: prefer_typing_uninitialized_variables
var showsnackbar;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgrounColor(),
      child: Scaffold(
        drawer: const Navdrawer(),
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('ΜΟΥΣΙΚΗ'),
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: dbSongs.length,
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
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20).r,
                  ),
                  child: ListTile(
                    onTap: (() async {
                      await Openplayer(
                        fullSongs: [],
                        index: index,
                        songId: fullSongs[index].metas.id.toString(),
                      ).openAssetPlayer(
                        index: index,
                        songs: fullSongs,
                      );
                    }),
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.music_note,
                        color: Colors.white,
                      ),
                    ),
                    title: Padding(
                      padding:
                          const EdgeInsets.only(left: 5.0, bottom: 3, top: 3).r,
                      child: Text(
                        fullSongs[index].metas.title!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding:
                          const EdgeInsets.only(top: 3.0, left: 2.0, bottom: 5)
                              .r,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        fullSongs[index].metas.artist!.toLowerCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    trailing: SizedBox(
                      width: 25,
                      child: popup(
                        songId: fullSongs[index].metas.id.toString(),
                        context: context,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}