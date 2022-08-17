import 'package:flutter/material.dart';
import 'package:music/hivedb/function.dart';
import 'package:music/hivedb/musicdb.dart';
import 'package:music/screens/splashscreen/splashscreen.dart';

popupbottomSheet({context}) {
  return showModalBottomSheet(
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
          valueListenable: musicValueNotifier,
          builder:
              (BuildContext context, List<Songs> songslist, Widget? child) {
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
                      fullSongs[index].metas.title!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  // subtitle: SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Text(
                  //     fullsonglist[index].metas.artist!,
                  //     style: const TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  // ),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        // size: 30,
                      ),
                      onPressed: () {
                        // // log(widget.plalistnameId);
                        // var name = box.get(playlistDb);

                        // final datainPlyalist = PlaylistData(
                        //     playlistAudio:
                        //         songslist[index].songtitle,
                        //     playlistName: widget.plalistnameId);
                        // addToPlaylist(datainPlyalist);
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
}

Widget removePlayListItem({index}) {
  return PopupMenuButton(
    padding: EdgeInsets.zero,
    onSelected: (value) {
      // playlistdataDb.deleteAt(index);
    },
    icon: const Icon(
      Icons.more_vert,
      color: Colors.white,
    ),
    color: Colors.black,
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 'playlist',
        child: Row(
          children: const [
            Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
            ),
            SizedBox(width: 5),
            Text(
              "Remove from Playlist",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    ],
  );
}
