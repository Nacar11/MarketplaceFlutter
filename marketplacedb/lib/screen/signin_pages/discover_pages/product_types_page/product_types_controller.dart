import 'package:get/get.dart';
import 'package:marketplacedb/controllers/products/product_controller.dart';

ProductController productController = ProductController.static;

class ProductTypesPageController extends GetxController {
  static ProductTypesPageController get instance => Get.find();

  final currentClickedSubcategory = 0.obs;
  final selectedProductTypeId = 0.obs;
  final expandedHeight = 0.0.obs;

  Future updatePageIndicator(index) async {
    if (currentClickedSubcategory.value == index) {
    } else {
      currentClickedSubcategory.value = index;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    print('ProductTypesController INIT');
    // productController.getProductTypesByCategoryId(
    //     productController.subCategoryList[currentClickedSubcategory.value].id!);
  }
}
