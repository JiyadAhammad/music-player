import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music/dbmodel/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/navbar/navbar.dart';
import 'package:music/screen/eachplaylistscreen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/screen/widget/delete_playlist.dart';

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
  List<dynamic>?playlist;
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
          builder: (BuildContext context, Box<PlaylistName> playlsitname, Widget?child) {
            return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 3,
            ),
            itemCount: playlsitname.length,
            itemBuilder: (context,index) {
              PlaylistName? playlistnameDb = playlistDb.getAt(index);
          //  final playlistnameData = playlsitname;
          //  log("$playlistnameData name thay is saved");
              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return const EachPlayList();
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
                        child:  Center(
                          child: Text(
                           playlistnameDb!.playlistName.toString(),
                            style:const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      ActionDelete(index: index,),
                    ],
                  ),
                ),
              );
            },
          );
          }
          
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
                builder: (ctx) {
                  return AlertDialog(
                    title: const Text('Playlist Name'),
                    content: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Playlist Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onOkButtonPressed(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
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
    final playlistvalue = PlaylistName(
      
      playlistName: palyListNameValidate
    
    );
    playlistDb.add(playlistvalue);
    // final key=playlistDb.get()
//     playlistDb.add(playlistvalue);
//     log('$playlistvalue hdfshaklfhl');
//  playlist= playlistDb.keys.toList();
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