import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/getx/music_controller.dart';
import '../eachplaylistscreen/eachplaylistscreen.dart';
import '../homescreen/navbar/navbar.dart';
import '../splashscreen/splashscreen.dart';
import 'createplaylist.dart';
import 'widget.dart';

final GlobalKey<FormState> formKey = GlobalKey();
String palyListNameValidate = '';
final TextEditingController nameController = TextEditingController();

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({super.key});

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
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: GetBuilder<MusicController>(
          init: MusicController(),
          builder: (_) {
            final List<dynamic> playlistName = box.keys.toList();

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
                    itemBuilder: (BuildContext context, int index) {
                      playlistName.removeWhere(
                          (dynamic element) => element == 'favourites');
                      playlistName.removeWhere(
                          (dynamic element) => element == 'mymusic');
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              () => EachPlayList(
                                playlistnameId: playlistName[index].toString(),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15).r,
                                  border: Border.all(
                                    color: Colors.white54,
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
                              PopupMenuButton<dynamic>(
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
                                itemBuilder: (_) => <PopupMenuEntry<dynamic>>[
                                  PopupMenuItem<dynamic>(
                                    onTap: () {},
                                    value: 'rename',
                                    child: Row(
                                      children: const <Widget>[
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
                                      children: const <Widget>[
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
                                onSelected: (Object? selected) {
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
                    },
                  );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Container(
          decoration: floatingActionBGColor(),
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CreatePlaylist();
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

BoxDecoration floatingActionBGColor() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(100),
    gradient: const RadialGradient(
      colors: <Color>[
        Color(0xFF911BEE),
        Color(0xFF4D0089),
      ],
    ),
  );
}
