import 'package:get/get.dart';
import 'package:music/view/homescreen/widget.dart';
import 'package:music/view/splashscreen/splashscreen.dart';

class MusicController extends GetxController {
  int currentIndex = 1;
  bool isSwitched = false;
  double rating = 0;

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
      (elemet) => elemet.id.toString() == dbSongs[index].id.toString(),
    );

    await box.put('favourites', songinfav);
    update();
  }

  onFavIconclicktoAdd(favouritesSong, fav) {
    favouritesSong.add(fav);
    box.put("favourites", favouritesSong);
    update();
  }

  onFavIconclicktoRemove(favouritesSong, fav) {
    favouritesSong.removeWhere(
      (element) => element.id.toString() == fav.id.toString(),
    );
    box.put("favourites", favouritesSong);
    update();
  }
}
