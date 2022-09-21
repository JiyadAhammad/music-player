import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/view/Playlist/createplaylist.dart';
import 'package:music/view/Playlist/widget.dart';
import 'package:music/view/eachplaylistscreen/eachplaylistscreen.dart';
import 'package:music/view/homescreen/navbar/navbar.dart';
import 'package:music/view/splashscreen/splashscreen.dart';

final GlobalKey<FormState> formKey = GlobalKey();
var palyListNameValidate = '';
final nameController = TextEditingController();

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgrounColor(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Playlist'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.offAll(
                () => NavBar(),
              );
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (ctx) {
              //       return NavBar();
              //     },
              //   ),
              // );
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (BuildContext context, playlistnameBox, Widget? child) {
            var playlistName = box.keys.toList();

            return playlistName.length == 2
                ? Center(
                    child: Text(
                      'No Playlist',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                      ),
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 3,
                    ),
                    itemCount: playlistName.length - 2,
                    itemBuilder: (context, index) {
                      playlistName.removeWhere(
                          (element) => element.contains('favourites'));
                      playlistName.removeWhere(
                          (element) => element.contains('mymusic'));
                      // var playlistSongs = box.get(playlistName[index]);
                      // return playlistName[index] != "mymusic" &&
                      //         playlistName[index] != "favourites"
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              () => EachPlayList(
                                playlistnameId: playlistName[index],
                              ),
                            );
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: ((context) => EachPlayList(
                            //           playlistnameId: playlistName[index],
                            //         )),
                            //   ),
                            // );
                          },
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15).r,
                                  border: Border.all(
                                    color: Colors.white54,
                                    style: BorderStyle.solid,
                                    width: 2.5,
                                  ),
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    playlistName[index].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    const Radius.circular(15.0).r,
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
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    onTap: () {},
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
                                    ),
                                  ),
                                ],
                                onSelected: (selected) {
                                  if (selected == 'delete') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return deletePlaylist(
                                            context: context,
                                            index: index,
                                            playlistsName: playlistName);
                                      },
                                    );
                                  }
                                  if (selected == 'rename') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return updatePlaylist(
                                          context: context,
                                          playlistName: playlistName[index],
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                      // : const SizedBox(
                      //     height: 0,
                      //     width: 0,
                      //   );
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
                  builder: (BuildContext context) {
                    return const CreatePlaylist();
                  });
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
