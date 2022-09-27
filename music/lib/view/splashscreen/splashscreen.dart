import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../model/musicdb.dart';
import '../../model/songfetch.dart';
import '../homescreen/navbar/navbar.dart';

final Box<List<dynamic>> box = StorageBox.getInstance();
final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
List<Songs> dbSongs = <Songs>[];
List<Audio> fullSongs = <Audio>[];
List<MusicListData> songlist2 = <MusicListData>[];
List<Songs> allSongs = <Songs>[];

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const MethodChannel _platform =
      MethodChannel('search_files_in_storage/search');
  // final bool value = false;
  @override
  Widget build(BuildContext context) {
    splashFetch();
    return Scaffold(
      body: Container(
        decoration: backgrounColor(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                    SizedBox(
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
      (dynamic value) {
        final String res = value as String;

        onSuccess(res);
      },
    ).onError((Object? error, StackTrace stackTrace) {});
  }

  Future<void> splashFetch() async {
    if (await _requestPermission(Permission.storage)) {
      searchInStorage();
      mSplash();
    } else {
      splashFetch();
    }
  }

  Future<bool> _requestPermission(Permission isPermission) async {
    const Permission store = Permission.storage;
    const Permission access = Permission.accessMediaLocation;

    if (await isPermission.isGranted) {
      await access.isGranted && await store.isGranted;
      return true;
    } else {
      final PermissionStatus result = await store.request();
      final PermissionStatus oneresult = await access.request();

      if (result == PermissionStatus.limited &&
          oneresult == PermissionStatus.limited) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<void> mSplash() async {
    await Future<dynamic>.delayed(
      const Duration(seconds: 5),
    );
    Get.to(
      () => NavBar(),
    );
  }

  Future<void> onSuccess(String audioListFromStorage) async {
    final dynamic valueMap = jsonDecode(audioListFromStorage);
    final List<dynamic> songlist = valueMap as List<dynamic>;
    songlist2 = songlist.map((dynamic e) {
      return MusicListData.fromJson(e as Map<String, dynamic>);
    }).toList();
    allSongs = songlist2
        .map(
          (MusicListData music) => Songs(
            id: int.parse(music.id!),
            songname: music.title,
            path: music.path,
            artist: music.artist,
          ),
        )
        .toList();
    // log('${allSongs.length} this is all songs');
    box.put('mymusic', allSongs);
    dbSongs = box.get('mymusic')! as List<Songs>;
    fullSongs.clear();
    for (final Songs element in dbSongs) {
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
      colors: <Color>[
        const Color(0xFF911BEE),
        Colors.black.withOpacity(0.94),
        Colors.black,
        Colors.black.withOpacity(0.94),
        const Color(0xFF911BEE),
      ],
      stops: const <double>[
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
      colors: <Color>[
        Color(0xFF911BEE),
        Color(0xFF4D0089),
      ],
    ),
  );
}
