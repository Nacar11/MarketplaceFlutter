import 'package:get/get.dart';

class ProductItemPageController extends GetxController {
  static ProductItemPageController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final singleProductImage = ''.obs;
  void updateImagePreviewIndex(index) {
    carouselCurrentIndex.value = index;
  }
}
