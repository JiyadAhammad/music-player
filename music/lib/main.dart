import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'controller/getx/music_controller.dart';
import 'model/musicdb.dart';
import 'view/splashscreen/splashscreen.dart';

final MusicController musicController = Get.put(MusicController());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<List<Songs>>(boxname);
  final List<dynamic> favKey = box.keys.toList();
  if (!favKey.contains('favourites')) {
    final List<Songs> favouritesSongs = <Songs>[];
    await box.put('favourites', favouritesSongs);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      designSize: const Size(
        360,
        800,
      ),
      builder: (
        BuildContext context,
        Widget? child,
      ) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Music',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
