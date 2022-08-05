import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/dbmodel/dbfunction.dart';
import 'package:music/dbmodel/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/navbar/navbar.dart';

import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

List<Songs> allSongs = [];
List<Songs> dbSongs = [];
List<Songs> mappedSongs = [];
List<String> allAudio = [];
// List<String> dbSongs = [];
List<Audio> fullsonglist = [];
Map<dynamic, dynamic> allSongsFetch = {};
List<String> musicTitles = [];
List<String> musicArtist = [];
List<String> musicpath = [];
List<String> musicAlbum = [];
List<int> musicId = [];

class _SplashScreenState extends State<SplashScreen> {
  // List<String>? allAudios;
  // List<Audio>? secondAllaudios;

  static const _platform = MethodChannel('search_files_in_storage/search');
  bool value = false;

  @override
  Widget build(BuildContext context) {
    screenEnter(context);
    return Scaffold(
      body: Container(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const SizedBox(
                    height: 150,
                  ),

                 const Text(
                    'jMUSIC',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                 const SizedBox(
                    height: 10,
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Image.asset('assets/img/splash.png'),
                  ),
                 const SizedBox(
                    height: 30,
                  ),
                 const Text(
                    'Feel the Music',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              ),
            ),
            LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white, size: 70.0)
          ],
            // children: [
            //   const Text(
            //     'jMUSIC',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 80,
            //       fontWeight: FontWeight.w400,
            //     ),
            //   ),
            //   ClipRRect(
            //     borderRadius: BorderRadius.circular(20),
            //     child: Image.asset(
            //       'assets/img/musiclogo.png',
            //       width: 200,
            //       height: 200,
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ],


          ),
        ),
      ),
    );
  }

  void searchInStorage() {
    _platform.invokeMethod('search').then((value) {
      final res = value as Map<Object?, Object?>;
      onSuccess(res);
    }).onError((error, stackTrace) {
    });
  }

  void convertingFromMap(value) {
    final tempTitle = value['title'] as List<Object?>;
    musicTitles = tempTitle.map((e) => e.toString()).toList();
    final tempPath = value['path'] as List<Object?>;
    musicpath = tempPath.map((e) => e.toString()).toList();
    final tempArtist = value['artist'] as List<Object?>;
    musicArtist = tempArtist.map((e) => e.toString()).toList();
    final tempId = value['id'] as List<Object?>;
    List<String> mId = tempId.map((e) => e.toString()).toList();
    musicId = mId.map((e) => int.parse(e)).toList();
    // musicId = tempId.map((e) => e.toString()).toList();

    // log("$musicId this id get from kotlin");

// for (var e in value) {
//   allSongs.add()
// }
  }

  Future splashFetch() async {
    if (await _requestPermission(Permission.storage)) {
      searchInStorage();
    } else {
      splashFetch();
    }
  }
  Directory? dir;

  Future<bool> _requestPermission(Permission permission) async {
    const store = Permission.storage;
    const access = Permission.accessMediaLocation;
    if (await permission.isGranted) {
      await access.isGranted && await access.isGranted;
      return true;
    } else {
      var result = await store.request();
      var oneresult = await access.request();
      if (result == PermissionStatus.granted &&
          oneresult == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  void initState() {
    splashFetch();
    super.initState();
  }

  Future<void> screenEnter(contxt) async {
    await Future.delayed(const Duration(seconds: 5));

    Navigator.of(contxt).pushReplacement(
      MaterialPageRoute(builder: (ctx) => NavBar()),
    );
  }

  

  onSuccess(audioListFromStorage) async {
    convertingFromMap(audioListFromStorage);

    setState(() {
      
    });

    // log('$audioListFromStorage    anything here' );

    // final data = Songs(
    //   path: musicpath,
    //   songtitle: musicTitles.toString(),
    //   songartist: musicArtist.toString(),
    // );
    // addMusicList(data);
    for (var i = 0; i < musicpath.length; i++) {
      final data = Songs(
        id: musicId[i],
        path: musicpath[i], 
        songtitle: musicTitles[i], 
        songartist: musicArtist[i]);


        
        await box.put(i,data);
        musicValueNotifier.value.add(data);
        musicValueNotifier.notifyListeners();


        // log('${data.id } this is id');
        // log('${data.path } this is path');
        // log('${data.songtitle} this is songtitle');
        // log('${data.songartist} this is songartist');
    }
    


    for (var i = 0; i < musicpath.length; i++) {
      fullsonglist.add(Audio.file(
        musicpath[i],
        metas: Metas(
          id: musicId[i].toString(),
          title: musicTitles[i],
          artist: musicArtist[i],
        ),
      ));
    }
  }
  
}
