import 'dart:developer';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music/dbmodel/songmodel.dart';
import 'package:music/navbar/navbar.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:music/dbmodel/dbfunction.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

List<Songs> allAudios = [];
List<String> allAudio = [];
List<String> dbSongs = [];
List<Audio> fullsonglist = [];

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
              const Text(
                'jMUSIC',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.w400,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/img/musiclogo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchInStorage(
    List<String> query,
    void Function(List<String>) onSuccess,
    void Function(String) onError,
  ) {
    _platform.invokeMethod('search', query).then((value) {
      final _res = value as List<Object?>;
      // log('res 1 ${_res.toString()}');

      setState(() {
        // a = [Audio(_res[1].toString())];
      });

      onSuccess(allAudios = _res.map((e) => e.toString()).toList());
    }).onError((error, stackTrace) {
      log(error.toString());
      onError(error.toString());
      // print(onError);
      // print(onSuccess);
    });
  }

  Future splashFetch() async {
    log('requst permission');
    if (await _requestPermission(Permission.storage)) {
      searchInStorage([
        '.mp3',
      ], onSuccess, (p0) {});
    } else {
      splashFetch();
    }
  }

//request for the permission
  Directory? dir;

  Future<bool> _requestPermission(Permission permission) async {
    const store = Permission.storage;
    const access = Permission.accessMediaLocation;
    if (await permission.isGranted) {
      await access.isGranted && await access.isGranted;
      log('permission granted ');
      return true;
    } else {
      var result = await store.request();
      var oneresult = await access.request();
      log('permission request ');

      if (result == PermissionStatus.granted &&
          oneresult == PermissionStatus.granted) {
        log('permission status granted ');

        return true;
      } else {
        log('permission denied ');

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
      MaterialPageRoute(builder: (ctx) => const NavBar()),
    );
  }

  onSuccess(List<String> internalstorageaudio) async {
    allAudio = internalstorageaudio;
    allAudio.sort((a, b) {
      return a.split("/").last.compareTo(b.split("/").last);
    });
    setState(() {
      // allAudios = allAudio;

      log('${allAudios.toString()}all audio');
      log('${allAudios!.length}all splash');
      log('${fullsonglist.length} full splash');
            log('${allAudio.length}splash all');

      // a = [Audio(allVideos.toString())];
    });
    // final data = Songs(path: allAudios);
    final data = Songs(path: allAudios!);
    addMusicList(data);
    // log('${data.id} haiii');
    await getAllSongsDetails();
    dbSongs = musicValueNotifier.value[1].path!;
    // log('begore for loop');
    for (var i = 0; i < dbSongs.length; i++) {
      // log('insode for loop');
      fullsonglist.add(
        Audio.file(
          dbSongs[i],
          metas: Metas(
            title: basename(
              musicValueNotifier.value[1].path![i].toString(),
            ),
          ),
        ),
      );
      // log('inside for loop ................${fullsonglist.toString()} jnjknkjhkhj');
    }
    // log()
    // log('outside for loop');
    // log('${fullsonglist.length} lenght of fullof string');
    // log('allvideos ${dbSongs.toString()}dbsongsakgaijhgaghnaierngdja');
  }
}
