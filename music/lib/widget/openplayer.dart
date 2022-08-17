import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:music/screens/splashscreen/splashscreen.dart';

class Openplayer {
  List<Audio> fullSongs;
  int index;
  bool? notify;
  String songId;
  Openplayer(
      {required this.fullSongs,
      required this.index,
      this.notify,
      required this.songId});
  openAssetPlayer({List<Audio>? songs, required int index}) async {
    audioPlayer.open(
      Playlist(audios: songs, startIndex: index),
      showNotification: notify == null || notify == true ? true : false,
      notificationSettings: const NotificationSettings(
        stopEnabled: false,
      ),
      autoStart: true,
      loopMode: LoopMode.playlist,
      headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
      playInBackground: PlayInBackground.enabled,
    );
  }
}
