import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:marketplacedb/data/models/ProductCategoryModel.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get static => Get.find();

  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final preferredSubCategory = 'Male'.obs;
  var preferredSubCategoryList = <ProductCategoryModel>[].obs;
  var productCategoryList = <ProductCategoryModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getProductCategories();
    subCategoriesInit(1);
  }

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  void subCategoriesInit(int counter) {
    preferredSubCategoryList.value = productCategoryList[counter].children!;
  }

  Future<void> getProductCategories() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse("${url}product-category"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ProductCategoryModel> categoryList =
            result.map((e) => ProductCategoryModel.fromJson(e)).toList();

        productCategoryList.assignAll(categoryList);
        print(productCategoryList.length);

        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data: $e');
    }
  }
}
