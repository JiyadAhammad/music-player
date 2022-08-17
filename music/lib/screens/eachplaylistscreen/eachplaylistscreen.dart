import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/screens/nowplayingscreen/musicplayscreen.dart';
import 'package:music/screens/splashscreen/splashscreen.dart';

class EachPlayList extends StatelessWidget {
  final playlistnameId;

  const EachPlayList({
    Key? key,
    this.playlistnameId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$playlistName>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$playlistnameId>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
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
          title: Text(playlistnameId),
          centerTitle: true,
          elevation: 0,
        ),
        body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (BuildContext context, playlistdatalist, Widget? child) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ListView.builder(
                itemCount:3,
                // itemCount: playlistdataDb.values.length,
                itemBuilder: (BuildContext context, int index) {
                  // PlaylistData? playlsitdatainDb =
                  //     playlistdatalist.getAt(index);
                  // PlaylistData? playlistdatainDb = playlistdataDb.getAt(index);
                  // log("${playlistdatainDb} dsfgagsdgdgdgd");

                  // if (playlistdatainDb!.playlistName.toString() ==
                  //     widget.plalistnameId) {
                  //   // return PLonevideotile(
                  //   //     playlistvideoname: playlistdatainDb.PLvideopath,
                  //   //     index: index);
                  // }
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) => MusicPlaySceeen()),
                            ),
                          );
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
                            '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        subtitle: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        // trailing: SizedBox(
                        //   width: 25,
                        //   child: removePlaylistAudio(
                        //     index: index,
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
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: const RadialGradient(
              colors: [
                Color(0xFF911BEE),
                Color(0xFF4D0089),
              ],
            ),
          ),
          child: FloatingActionButton(
            onPressed: () {
              // popupbottomSheet(context: context);
            },
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
