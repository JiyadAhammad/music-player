import 'dart:convert';
import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music/model/songfetch.dart';
import 'package:music/model/musicdb.dart';
import 'package:music/view/homescreen/navbar/navbar.dart';
import 'package:permission_handler/permission_handler.dart';

final Box<List<dynamic>> box = StorageBox.getInstance();
final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
List<Songs> dbSongs = [];
List<Audio> fullSongs = [];
List<MusicListData> songlist2 = [];
List<Songs> allSongs = [];

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  static const _platform = MethodChannel('search_files_in_storage/search');
  bool value = false;
  @override
  Widget build(BuildContext context) {
    splashFetch();
    return Scaffold(
      body: Container(
        decoration: backgrounColor(),
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
                      'ΜΟΥΣΙΚΗ',
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
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white,
                size: 70.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  void searchInStorage() {
    _platform.invokeMethod('search').then(
      (value) {
        final res = value as String;

        onSuccess(res);
      },
    ).onError((error, stackTrace) {});
  }

  Future splashFetch() async {
    if (await _requestPermission(Permission.storage)) {
      searchInStorage();
      mSplash();
    } else {
      splashFetch();
    }
  }

  Future<bool> _requestPermission(Permission isPermission) async {
    const store = Permission.storage;
    const access = Permission.accessMediaLocation;

    if (await isPermission.isGranted) {
      await access.isGranted && await store.isGranted;
      log('permission granted');
      return true;
    } else {
      var result = await store.request();
      var oneresult = await access.request();
      log('permission request ');

      if (result == PermissionStatus.limited &&
          oneresult == PermissionStatus.limited) {
        log('permission status granted ');

        return true;
      } else {
        log('permission denied ');

        return false;
      }
      // }

    }
  }

  // @override
  // void initState() {
  //   splashFetch();

  //   super.initState();
  // }

  Future<void> mSplash() async {
    await Future.delayed(const Duration(seconds: 5));

    // ignore: use_build_context_synchronously
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (ctx) =>  NavBar()),
    // );
    Get.to(
      () => NavBar(),
    );
  }

  onSuccess(audioListFromStorage) async {
    final valueMap = jsonDecode(audioListFromStorage);
    // final a = MusicListData.fromJson(valueMap);
    List songlist = valueMap;
    songlist2 = songlist.map((e) {
      return MusicListData.fromJson(e);
    }).toList();
    allSongs = songlist2
        .map((music) => Songs(
              id: int.parse(music.id!),
              songname: music.title!,
              path: music.path!,
              artist: music.artist!,
            ))
        .toList();

    box.put('mymusic', allSongs);
    dbSongs = box.get('mymusic') as List<Songs>;

    for (var element in dbSongs) {
      fullSongs.add(
        Audio.file(
          element.path!,
          metas: Metas(
            title: element.songname,
            artist: element.artist,
            id: element.id.toString(),
          ),
        ),
      );
    }
  }
}

BoxDecoration backgrounColor() {
  return BoxDecoration(
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
  );
}

BoxDecoration backgroundColordrawer() {
  return const BoxDecoration(
    gradient: RadialGradient(
      colors: [
        Color(0xFF911BEE),
        Color(0xFF4D0089),
      ],
    ),
  );
}
