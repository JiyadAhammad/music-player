import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:music/model/musicdb.dart';
import 'package:music/view/homescreen/widget.dart';
import 'package:music/view/splashscreen/splashscreen.dart';

class MusicController extends GetxController {
  int currentIndex = 1;
  bool isSwitched = false;
  double rating = 0;
  

  void isRatingChanged(double rate) {
    rating = rate;
    update();
  }

  void isSwitchedToggle(bool value) {
    isSwitched = value;
    update();
  }

  void currentIndexChange(int index) {
    currentIndex = index;
    update();
  }

  Future<void> addToFavoutire(Songs temp) async {
    favourites!.add(temp);
    await box.put("favourites", favourites!);
    update();
  }

  Future<void> removeFromFavourite(Songs temp) async {
    favourites!.removeWhere(
      (element) => element.id.toString() == temp.id.toString(),
    );
    await box.put("favourites", favourites!);
    update();
  }

  Future<void> removeFavouriteBottomSheet(
    dynamic songinfav,
    int index,
  ) async {
    songinfav.removeWhere(
      (elemet) => elemet.id.toString() == dbSongs[index].id.toString(),
    );

    await box.put('favourites', songinfav);
    update();
  }

  Future<void> onFavIconclicktoAdd(
    dynamic favouritesSong,
    Songs fav,
  ) async {
    favouritesSong.add(fav);
    box.put("favourites", favouritesSong);
    update();
  }

  Future<void> onFavIconclicktoRemove(
    dynamic favouritesSong,
    Songs fav,
  ) async {
    favouritesSong.removeWhere(
      (element) => element.id.toString() == fav.id.toString(),
    );
    box.put("favourites", favouritesSong);
    update();
  }

  playListNameCreate(String value, List keys) {
    if (value.trim() == "") {
      return "Name Required";
    }
    if (keys
        .where(
          (element) => element == value.trim(),
        )
        .isNotEmpty) {
      return "This Name Already Exist";
    }

    update();
  }

  playListNameEdit(String value) {
    if (value.trim() == "") {
      return "Name Required";
    }

    update();
  }

  validateEditPLayListName(playlistName, String title) {
    List? curentPlaylistName = box.get(playlistName);
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
    playlistSongs.removeWhere(
        (element) => element.id.toString() == dbSongs[index].id.toString());
    await box.put(playListName, playlistSongs);
    update();
  }
}
