import 'dart:convert';
import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music/function/songfetch.dart';
import 'package:music/hivedb/musicdb.dart';
import 'package:music/screens/homescreen/navbar/navbar.dart';
import 'package:permission_handler/permission_handler.dart';

List<MusicListData> songlist2 = [];
List<Songs> allSongs = [];
List<Songs> songsFromDb = [];
List<Audio> finalSongList = [];

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final Box<List<dynamic>> box = StorageBox.getInstance();
final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
List<Songs> mappedSongs = [];
List<Songs> dbSongs = [];
List<Audio> fullSongs = [];
Map<dynamic, dynamic> a = {};
List<String> allAudio = [];
List<String> mTitle = [];
List<String> mPath = [];
List<String> mArtist = [];
List<String> malbum = [];
List<String> malbumImage = [];
List<String> mDuration = [];
List<int> mId = [];

class _SplashScreenState extends State<SplashScreen> {
  List<String>? allAudios;
  List<Audio>? secondAllaudios;
  static const _platform = MethodChannel('search_files_in_storage/search');
  bool value = false;
  @override
  Widget build(BuildContext context) {
    // screenEnter(context);
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
    _platform.invokeMethod('search').then((value) {
      final res = value as String;

      onSuccess(res);
    }).onError((error, stackTrace) {});
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
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
      // print('object');
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

  @override
  void initState() {
    splashFetch();

    super.initState();
  }

  Future<void> mSplash() async {
    await Future.delayed(const Duration(seconds: 5));

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const NavBar()),
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

    // for (var i = 0; i < songlist2.length; i++) {
    //   finalSongList.add(
    //     Audio.file(
    //       songlist2[i].path!,
    //       metas: Metas(
    //         title: songlist2[i].title,
    //         artist: songlist2[i].albums,
    //       ),
    //     ),
    //   );
    // }
  }
}
