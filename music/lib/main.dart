import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/dbmodel/songmodel.dart';
import 'package:music/screen/playlist.dart';
import 'package:music/screen/splashscreen.dart';

late Box<Favourite> favouriteDb;
late Box<Songs> box;
late Box<PlaylistName> playlistDb;
late Box<PlaylistData> playlistdataDb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(SongsAdapter().typeId)) {
    Hive.registerAdapter(SongsAdapter());
    Hive.registerAdapter(FavouriteAdapter());
    Hive.registerAdapter(PlaylistNameAdapter());
    Hive.registerAdapter(PlaylistDataAdapter());
  }
  favouriteDb = await Hive.openBox<Favourite>('fav_db');
  box = await Hive.openBox<Songs>('Songs_db');
  playlistDb = await Hive.openBox<PlaylistName>('playlistname_db');
  playlistdataDb = await Hive.openBox<PlaylistData>('playlistdata_db');

  // favouriteAudiodb = await Hive.openBox<Favourite>("favourite_db");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      designSize: const Size(360, 800),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Music',
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: const SplashScreen(),
        );
      },
    );
  }
}
