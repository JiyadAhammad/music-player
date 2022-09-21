import 'package:get/get.dart';

class MusicController extends GetxController {
  int currentIndex = 1;
  currentIndexChange(index) {
    currentIndex = index;
    update();
  }
}
