import 'package:get/get.dart';
import 'package:music/view/homescreen/widget.dart';
import 'package:music/view/splashscreen/splashscreen.dart';

class MusicController extends GetxController {
  int currentIndex = 1;
  bool isSwitched = false;
  double rating = 0;
  // final temp = databaseSongs(dbSongs, songId);

  isRatingChanged(rate) {
    rating = rate;
    update();
  }

  isSwitchedToggle(value) {
    isSwitched = value;
    update();
  }

  currentIndexChange(index) {
    currentIndex = index;
    update();
  }

  addToFavoutire(temp) async {
    favourites!.add(temp);
    await box.put("favourites", favourites!);
    update();
  }

  removeFromFavourite(temp) async {
    favourites!.removeWhere(
      (element) => element.id.toString() == temp.id.toString(),
    );
    await box.put("favourites", favourites!);
    update();
  }

  removeFavouriteBottomSheet(songinfav, index) async {
    songinfav.removeWhere(
        (elemet) => elemet.id.toString() == dbSongs[index].id.toString());

    await box.put('favourites', songinfav);
  }
}
