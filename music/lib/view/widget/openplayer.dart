import 'package:assets_audio_player/assets_audio_player.dart';
import '../splashscreen/splashscreen.dart';

class Openplayer {
  Openplayer(
      {required this.fullSongs,
      required this.index,
      this.notify,
      required this.songId});
  List<Audio> fullSongs;
  int index;
  bool? notify;
  String songId;
  Future<void> openAssetPlayer({
    List<Audio>? songs,
    required int index,
  }) async {
    audioPlayer.open(
      Playlist(audios: songs, startIndex: index),
      notificationSettings: const NotificationSettings(
        stopEnabled: false,
      ),
      loopMode: LoopMode.playlist,
      headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
    );
  }
}
