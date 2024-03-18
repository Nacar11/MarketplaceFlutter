import 'dart:convert';
import 'package:get/get.dart';
import 'package:marketplacedb/data/models/products/product_category_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final preferredSubCategory = 'Male'.obs;
  var preferredSubCategoryList = <ProductCategoryModel>[].obs;
  var productCategoryList = <ProductCategoryModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getProductCategories();
    await getUserGender();
  }

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  void preferredSubCategories(String gender) async {
    if (gender == 'Male') {
      preferredSubCategoryList.value = productCategoryList[1].children!;
    } else if (gender == 'Female') {
      preferredSubCategoryList.value = productCategoryList[2].children!;
    }
  }

  Future<void> getProductCategories() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}getOrganizedProductCategories"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ProductCategoryModel> categoryList =
            result.map((e) => ProductCategoryModel.fromJson(e)).toList();

        productCategoryList.assignAll(categoryList);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data getProductCategories: $e');
    }
  }

  Future<void> getUserGender() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}getUserGender"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final String result = jsonObject['data'];
        preferredSubCategories(result);
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
