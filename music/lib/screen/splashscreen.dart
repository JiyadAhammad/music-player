import 'dart:developer';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music/dbmodel/songmodel.dart';
import 'package:music/navbar/navbar.dart';

import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

List<Songs> allAudios = [];
List<String> allAudio = [];
List<String> dbSongs = [];
List<Audio> fullsonglist = [];
Map<dynamic, dynamic> allSongsFetch = {};
List<String> musicTitles = [];
List<String> musicArtist = [];
List<String> musicpath = [];
List<String> musicAlbum = [];

class _SplashScreenState extends State<SplashScreen> {
  List<String>? allAudios;
  List<Audio>? secondAllaudios;

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
                  SizedBox(
                    height: 150.h,
                  ),

                  Text(
                    'jMUSIC',
                    style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Image.asset('assets/img/splash.png'),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'Feel the Music',
                    style: TextStyle(fontSize: 30.sp, color: Colors.white),
                  ),
                ],
              ),
            ),
            LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white, size: 70.0.w.h)
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
      // log('res 1 ${res.toString()}');
      // log('res 2 $value');

      onSuccess(res);
    }).onError((error, stackTrace) {
      // log(error.toString());
      // onError(error.toString());
      // print(onError);
      // print(onSuccess);
    });
  }

  void convertingFromMap(value) {
    final tempTitle = value['title'] as List<Object?>;
    // log('title of song $tempTitle');
    musicTitles = tempTitle.map((e) => e.toString()).toList();
    // log("${musicTitles.length}");

    final tempPath = value['path'] as List<Object?>;
    // log('path of song $tempPath');
    musicpath = tempPath.map((e) => e.toString()).toList();
    // log("${musicpath.length}");

    final tempArtist = value['artist'] as List<Object?>;
    // log('Artist of song $tempTitle');
    musicArtist = tempArtist.map((e) => e.toString()).toList();

    // final tempAlbum = value['album'] as List<Object?>;

    // musicAlbum = tempAlbum.map((e) => e.toString()).toList();
    // log("$musicAlbum");

    // final tempAlbum = value['alubm'] as List<Object?>;
    // log('$tempTitle');
    // malbum = tempAlbum.map((e) => e.toString()).toList();
    // log("........................$malbum");
    // log("........................${mArtist.length}");
  }

  Future splashFetch() async {
    // log('requst permission');
    if (await _requestPermission(Permission.storage)) {
      searchInStorage();
    } else {
      splashFetch();
    }
  }

//request for the permission.
  Directory? dir;

  Future<bool> _requestPermission(Permission permission) async {
    const store = Permission.storage;
    const access = Permission.accessMediaLocation;
    if (await permission.isGranted) {
      await access.isGranted && await access.isGranted;
      // log('permission granted ');
      return true;
    } else {
      var result = await store.request();
      var oneresult = await access.request();
      // log('permission request ');

      if (result == PermissionStatus.granted &&
          oneresult == PermissionStatus.granted) {
        // log('permission status granted ');

        return true;
      } else {
        // log('permission denied ');

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

    final data = Songs(
      path: allAudios,
    );
   

    for (var i = 0; i < musicpath.length; i++) {
      fullsonglist.add(Audio.file(
        musicpath[i],
        metas: Metas(
          title: musicTitles[i],
          artist: musicArtist[i],
          // album: musicAlbum[i],

        ),
      ));
      
    }

    
  }
}
