import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'dart:convert';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/data/models/ProductCategoryModel.dart';
import 'package:marketplacedb/data/models/ProductTypeModel.dart';

class ProductController extends GetxController {
  static ProductController get static => Get.find();

  var productCategoryList = <ProductCategoryModel>[].obs;

  int? subCategoryId;
  var subCategoryList = <ProductCategoryModel>[].obs;
  var productTypes = <ProductTypeModel>[].obs;

  final isLoading = false.obs;
  final token = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await getProductCategories();
    subCategoriesInit(1);
  }

  void subCategoriesInit(int counter) {
    subCategoryList.value = productCategoryList[counter].children!;
    print(subCategoryList.length);
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

  Future<void> getProductTypesByCategoryId(int categoryId) async {
    isLoading.value = true;
    try {
      final response = await AuthInterceptor()
          .get(Uri.parse("${url}getProductTypesByCategory/$categoryId"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ProductTypeModel> productTypesData =
            result.map((e) => ProductTypeModel.fromJson(e)).toList();

        productTypes.assignAll(productTypesData);

        print(productTypes[0].name);
      } else {
        throw Exception('Failed to load product types');
      }
    } catch (e) {
      print('Error fetching product types: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
