import 'package:get/get.dart';

class DiscoverPageController extends GetxController {
  static DiscoverPageController get instance => Get.find();

  final currentClickedSubcategory = 0.obs;
  final selectedProductTypeId = 0.obs;
  final expandedHeight = 0.0.obs;

  Future updatePageIndicator(index) async {
    if (currentClickedSubcategory.value == index) {
    } else {
      currentClickedSubcategory.value = index;
    }
  }
}
