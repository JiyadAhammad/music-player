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
      // print(value.toString());
      final res = value as String;

      // final valueMap = jsonDecode(_res);
      // // final a = MusicListData.fromJson(valueMap);
      // List songlist = valueMap;
      // final songlist2 = songlist.map((e) {
      //   return MusicListData.fromJson(e);
      // }).toList();

      // log('res3 valueeeeeeeee  ${songlist2[1].duration}');

      onSuccess(res);
    }).onError((error, stackTrace) {});
  }

  // void convertingFromMap(Map value) async {
  //   final tempTitle = value['title'] as List<Object?>;
  //   log('aaaaaaaaaanandhuannnn $tempTitle');
  //   mTitle = tempTitle.map((e) => e.toString()).toList();
  //   log("........................${mTitle.length}");

  //   final tempPath = value['path'] as List<Object?>;
  //   log('aaaaaaaaaanandhuannnn $tempPath');
  //   mPath = tempPath.map((e) => e.toString()).toList();
  //   log("........................${mPath.length}");

  //   final tempArtist = value['artist'] as List<Object?>;
  //   log('aaaaaaaaaanandhuannnn $tempTitle');
  //   mArtist = tempArtist.map((e) => e.toString()).toList();
  //   log("........................$mArtist");
  //   log("........................${mArtist.length}");

  //   final tempAlbum = value['album'] as List<Object?>;
  //   log('aaaaaaaaaanandhuannnn $tempAlbum');
  //   malbum = tempAlbum.map((e) => e.toString()).toList();
  //   log("..................albumMMMMM......$malbum");
  //   log("........................${mArtist.length}");
  //   final tempAlbumImage = value['image'] as List<Object?>;
  //   log('aaaaaaaaaanandhuannnn $tempTitle');
  //   malbumImage = tempAlbumImage.map((e) => e.toString()).toList();
  //   log("..........imageeeeeeee..............$malbumImage");
  //   log("........................${malbumImage.length}");
  //   final mDurationtemp = value['duration'] as List<Object?>;
  //   List<String> mDurationtemp2 =
  //       mDurationtemp.map((e) => e.toString()).toList();
  //   log("........................$malbumImage");
  //   log("........................${malbumImage.length}");
  //   List<int> durationtemp = mDurationtemp2.map((e) => int.parse(e)).toList();
  //   final mIdTemp = value['id'] as List<Object?>;
  //   List<String> mId2 = mIdTemp.map((e) => e.toString()).toList();
  //   mId = mId2.map((e) => int.parse(e)).toList();

  //   for (var i = 0; i < mDurationtemp.length; i++) {
  //     String mDuration1 =
  //         _printDuration(Duration(milliseconds: durationtemp[i]));
  //     mDuration.add(mDuration1);
  //   }
  //   log('durationnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn${mDuration.toString()}');
  //   for (int i = 0; i < mPath.length; i++) {
  //     final data = MusicModel(
  //         id: mId[i].toString(),
  //         title: mTitle[i],
  //         path: mPath[i],
  //         album: malbum[i],
  //         duration: mDuration[i]);
  //     // addMusicList(data);

  //     await allSongsDb.put(i, data);
  //     musicValueNotifier.value.add(data);
  //     musicValueNotifier.notifyListeners();

  //     log('db path >>>>>>>>>>>>>>>>>>>>>>${data.path}');
  //     log('db title >>>>>>>>>>>>>>>>>>>>>>${data.title}');
  //     log('db album >>>>>>>>>>>>>>>>>>>>>>${data.album}');
  //     log('db duration >>>>>>>>>>>>>>>>>>>>>>${data.duration}');
  //   }
  // }

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

  // fetchAudiosFromStorage() async {
  //   List<String> query = [".mp3"];
  //   searchInStorage(query, onSuccess, (p0) {});
  // }

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
      print('result $result');
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

      // Future<void> _getDocuments() async {
      //   MethodChannel _methodChannel =
      //       MethodChannel('search_files_in_storage/search');
      //   List<dynamic> documentList = [""];
      //   try {
      //     documentList = await _methodChannel.invokeMethod("Documents");
      //   } on PlatformException catch (e) {
      //     print("exceptiong");
      //   }
      //   documentList.forEach((document) {
      //     print("Document: $document"); // seach in Logcat "Document"
      //   });
    }
  }

  @override
  void initState() {
    // play(assetsAudioPlayer);
    splashFetch();

    // print('started');

    // TODO: implement initState
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
    // log("$allSongs al songs fetched");
    box.put('mymusic', allSongs);
    dbSongs = box.get('mymusic') as List<Songs>;

    // log("$dbSongs all songs");

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

    // log('res3 valueeeeeeeee  ${songlist2[1].duration}>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<><><><><><><><><><><><>');
    // convertingFromMap(audioListFromStorage);

    // final box = await Hive.openBox<MusicModel>('music_db');
    // for (int i = 0; i < mPath.length; i++) {
    //   final data =  MusicModel(
    //     id: 1 ,
    //     title: "aaa" ,
    //     path: "mPath[i]" ,
    //     album: "malbum[i] ",
    //     duration: "mDuration[i]" ,
    //   );

    //  await  box.add(data);
    //   log(box.toString());
    //   box.close();
    // }

    // await getAllMusicList();

    // final data = MusicModel(
    //   path: allAudios,
    // );
    // // addMusicList(data);
    // log('db for data..............??????????????$data');

    // await getAllMusicList();
    //   dbSongs = musicValueNotifier.value[1].path!;
// log("message");
    for (var i = 0; i < songlist2.length; i++) {
      finalSongList.add(
        Audio.file(
          songlist2[i].path!,
          metas: Metas(
            title: songlist2[i].title,
            artist: songlist2[i].albums,
          ),
        ),
      );
      // log('inside for loop ................${fullSongs.toString()}');
    }
    // log("hai ouside");

    //   log('allvideos ${dbSongs.toString()}');
    //   // log('an${a.toString()}');
    // }
  }
}
