import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music/dbmodel/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/navbar/navbar.dart';
import 'package:music/screen/eachplaylistscreen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/screen/widget/delete_playlist.dart';

final GlobalKey<FormState> _formKey = GlobalKey();

// final listofitemsgrid = [
//   'Malaylam',
//   'English',
//   'Hindi',
//   'Melody',
//   'tamil',
//   // 'Favourites',
//   'Sleep',
//   'Gym',
// ];

final nameController = TextEditingController();

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  List<dynamic>? playlist;
  @override
  Widget build(BuildContext context) {
    // final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
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
          title: const Text('Playlist'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) {
                    return NavBar();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: playlistDb.listenable(),
          builder: (BuildContext context, Box<PlaylistName> playlsitname,
              Widget? child) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 3,
              ),
              itemCount: playlsitname.length,
              itemBuilder: (context, index) {
                PlaylistName? playlistnameDb = playlistDb.getAt(index);
                // log("${playlistnameDb} jofdskiaaaaasdjioagjiodg");
                // log("${playlistnameDb!.playlistName} dataasindsohsdg");
                // log("$playlsitname jkldsafgdghfjhjgjgshkgshjk");
                //  final playlistnameData = playlsitname;
                //  log("$playlistnameData name thay is saved");
                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return EachPlayList(
                              plalistnameId: playlistnameDb!.playlistName,
                            );
                          },
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
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
                              playlistnameDb!.playlistName.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        PopupMenuButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          color: Colors.black,
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          itemBuilder: (_) => <PopupMenuItem<String>>[
                            PopupMenuItem<String>(
                                onTap: () {},
                                // child: const Text(
                                //   'Rename Playlist',
                                // ),
                                value: 'rename',
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      ' Edit playlist',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )),
                            PopupMenuItem<String>(
                                onTap: () {},
                                // child: const Text(
                                //   'Delete Playlist',
                                // ),
                                value: 'delete',
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      ' Delete playlist ',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                          onSelected: (selected) {
                            if (selected == 'delete') {
                              deletePlaylist(
                                  playlistVideoName:
                                      playlistnameDb.playlistName!,
                                  index: index);
                            } else if (selected == 'rename') {
                              playlistEdit(
                                context: context,
                                playName: playlistnameDb.playlistName,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
              showDialog(
      context: context,
      builder: (context) => Form(
        key: _formKey,
        child: AlertDialog(
          title: const Text("Edit Playlist"),
          content: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Playlist Name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter Playlist Name";
              } else if (checkPlaylistExists(value).isNotEmpty) {
                return "Playlist already exists";
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // editPlayDB(
                  //   oldValue: playName!,
                  //   newValue: nameController.text.trim(),
                  // );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      margin: EdgeInsets.all(20),
                      behavior: SnackBarBehavior.floating,
                      content: Text("Playlist Name Updated"),
                      duration: Duration(seconds: 1)));
                  return;
                  // const snackBar =
                  //     SnackBar(content: Text("Playlist Name Updated"));
                }
              },
              child: const Text(
                "Update",
              ),
            ),
          ],
        ),
      ),
    );
              // showDialog(
              //   context: context,
              //   builder: (ctx) {
              //     return AlertDialog(
              //       title: const Text('Playlist Name'),
              //       content: TextFormField(
              //         controller: nameController,
              //         decoration: const InputDecoration(
              //           border: OutlineInputBorder(),
              //           labelText: 'Playlist Name',
              //         ),
              //         validator: (value) {
              //           if (value == null || value.isEmpty) {
              //             return 'Please enter some text';
              //           }
              //           return null;
              //         },
              //       ),
              //       actions: [
              //         TextButton(
              //           onPressed: () => Navigator.pop(context, 'Cancel'),
              //           child: const Text('Cancel'),
              //         ),
              //         ElevatedButton(
              //           onPressed: () {
              //             onOkButtonPressed(context);
              //           },
              //           child: const Text('OK'),
              //         ),
              //       ],
              //     );
              //   },
              // );
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
  }

  deletePlaylist({required String playlistVideoName, required int index}) {
    playlistDb.deleteAt(index); //playlist name delete from db
  }

  void playlistEdit({required BuildContext context, String? playName}) {
    showDialog(
      context: context,
      builder: (context) => Form(
        key: _formKey,
        child: AlertDialog(
          title: const Text("Edit Playlist"),
          content: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Playlist Name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter Playlist Name";
              } else if (checkPlaylistExists(value).isNotEmpty) {
                return "Playlist already exists";
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  editPlayDB(
                    oldValue: playName!,
                    newValue: nameController.text.trim(),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      margin: EdgeInsets.all(20),
                      behavior: SnackBarBehavior.floating,
                      content: Text("Playlist Name Updated"),
                      duration: Duration(seconds: 1)));
                  return;
                  // const snackBar =
                  //     SnackBar(content: Text("Playlist Name Updated"));
                }
              },
              child: const Text(
                "Update",
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkPlaylistExists(value) {
    List<PlaylistName> currentList = playlistDb.values.toList();
    var contains =
        currentList.where((element) => element.playlistName == value);
    //no duplicaate items in the list of objects
    return contains;
  }

  editPlayDB({
    required String oldValue,
    required String newValue,
  }) {
    final Map<dynamic, PlaylistName> playlistNameMap = playlistDb.toMap();
    dynamic desiredKey;
    playlistNameMap.forEach((key, value) {
      if (value.playlistName == oldValue) desiredKey = key;
    });
    final playlistObj = PlaylistName(playlistName: newValue);
    playlistDb.put(
        desiredKey, playlistObj); //playlist name changed successfully

    // final Map<dynamic, PlayListVideos> playlistVideoMap =
    //     playListVideosDB.toMap();
    // playlistVideoMap.forEach((key, value) {
    //   if (value.playListName == oldValue) {
    //     PlayListVideos playVideos = PlayListVideos(playListName: newValue, playListVideo: value.playListVideo);
    //     playListVideosDB.put(key, playVideos);
    //   }
    // });
  }

//   void deletedPlayList(int index) {

//   }

}
// class AddPlaylistname extends StatelessWidget {
//   const AddPlaylistname({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }