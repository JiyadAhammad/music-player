import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import '../../model/musicdb.dart';
import '../../view/splashscreen/splashscreen.dart';

class PlaylistController extends GetxController {
  dynamic playListNameCreate(String value, List<dynamic> keys) {
    if (value.trim() == '') {
      return 'Name Required';
    }
    if (keys
        .where(
          (dynamic item) => item == value.trim(),
        )
        .isNotEmpty) {
      return 'This Name Already Exist';
    }

    update();
  }

  dynamic playListNameEdit(String value) {
    if (value.trim() == '') {
      return 'Name Required';
    }

    update();
  }

  void validateEditPLayListName(dynamic playlistName, String title) {
    final List<dynamic>? curentPlaylistName = box.get(playlistName);
    box.put(title, curentPlaylistName!);
    box.delete(playlistName);
    update();
  }

  void playlistDelete(dynamic playlistsName, int index) {
    box.delete(playlistsName[index]);
    update();
  }

  void deleteSongInPlayList(
    List<Songs> playlistSongs,
    int index,
    String playlistnameId,
    List<Audio> playPlaylist,
  ) {
    playlistSongs.removeAt(index);
    box.put(playlistnameId, playlistSongs);
    playPlaylist.clear();
    update();
  }

  Future<void> addPlayListMusicFromBottomSheet(
      List<Songs> playlistSongs, int index, String playListName) async {
    playlistSongs.add(dbSongs[index]);
    await box.put(playListName, playlistSongs);
    update();
  }

  Future<void> deletePlayListMusicFromBottomSheet(
      List<Songs> playlistSongs, int index, String playListName) async {
    playlistSongs.removeWhere((Songs element) =>
        element.id.toString() == dbSongs[index].id.toString());
    await box.put(playListName, playlistSongs);
    update();
  }
}
