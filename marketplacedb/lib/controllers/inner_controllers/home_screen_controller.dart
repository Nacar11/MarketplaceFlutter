import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get static => Get.find();

  final carouselCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }
}
