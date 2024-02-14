import 'package:get/get.dart';

class ProductItemPageController extends GetxController {
  static ProductItemPageController get static => Get.find();

  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;

  void updateImagePreviewIndex(index) {
    carouselCurrentIndex.value = index;
  }
}
