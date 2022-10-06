import 'package:get/get.dart';
import '../../model/musicdb.dart';
import '../../view/homescreen/widget.dart';
import '../../view/splashscreen/splashscreen.dart';


class FavouriteController extends GetxController {
  Future<void> addToFavoutire(dynamic temp) async {
    favourites!.add(temp);
    await box.put('favourites', favourites!);
    update();
  }

  Future<void> removeFromFavourite(dynamic temp) async {
    favourites!.removeWhere(
      (dynamic item) => item.id.toString() == temp.id.toString(),
    );
    await box.put('favourites', favourites!);
    update();
  }

  Future<void> removeFavouriteBottomSheet(
    List<dynamic> songinfav,
    int index,
  ) async {
    songinfav.removeWhere(
      (dynamic elemet) => elemet.id.toString() == dbSongs[index].id.toString(),
    );

    await box.put('favourites', songinfav);
    update();
  }

  Future<void> onFavIconclicktoAdd(
    List<dynamic> favouritesSong,
    Songs fav,
  ) async {
    favouritesSong.add(fav);
    box.put('favourites', favouritesSong);
    update();
  }

  Future<void> onFavIconclicktoRemove(
    List<dynamic> favouritesSong,
    Songs fav,
  ) async {
    favouritesSong.removeWhere(
      (dynamic item) => item.id.toString() == fav.id.toString(),
    );
    box.put('favourites', favouritesSong);
    update();
  }
}
