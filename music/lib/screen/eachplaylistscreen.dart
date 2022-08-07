import 'package:flutter/material.dart';
import 'package:music/dbmodel/dbfunction.dart';
import 'package:music/dbmodel/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/screen/musicplayscreen.dart';
import 'package:music/screen/splashscreen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/screen/widget/delete_playlist.dart';

class EachPlayList extends StatefulWidget {
  const EachPlayList({Key? key}) : super(key: key);

  @override
  State<EachPlayList> createState() => _EachPlayListState();
}

class _EachPlayListState extends State<EachPlayList> {
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
          title: const Text('Melody'),
          centerTitle: true,
          elevation: 0,
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //     //  ActionDelete(index: index);
          //     },
          //     icon: const Icon(Icons.delete),
          //   )
          // ],
        ),
        body:ValueListenableBuilder(
          valueListenable: playlistdataDb.listenable(),
          builder: (BuildContext context, Box<PlaylistData> playlistdatalist, Widget? child) {
            return  Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: ListView.builder(
            itemCount: playlistdataDb.values.length,
            itemBuilder: (BuildContext context, int index) {
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
                          builder: ((context) =>
                               MusicPlaySceeen()),
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
                        "Song Name  ${index + 1}",
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
                        "<artist name ${index + 1}>",
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
                          const PopupMenuItem(
                            value: 'add to playlist',
                            child: Text(
                              'Remove from playlist',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ];
                      },
                      onSelected: (String value) {},
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
              showModalBottomSheet(
                enableDrag: true,
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
                    child: ValueListenableBuilder(
                      valueListenable:  musicValueNotifier,
                      builder: (BuildContext context, List<Songs> songslist, Widget? child) {
                        return ListView.builder(
                        itemCount: songslist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {},
                            leading: const CircleAvatar(
                              child: Icon(
                                Icons.music_note,
                                color: Colors.white,
                              ),
                            ),
                            title: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                fullsonglist[index].metas.title!,
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
                                fullsonglist[index].metas.artist!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  // size: 30,
                                ),
                                onPressed: () {
                                  final datainplaylist = PlaylistData(
                                    playlistAudio: songslist[index].songtitle
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                      },
                    ),
                            
                          
                        
                      
                    
                  );
                },
              );
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
