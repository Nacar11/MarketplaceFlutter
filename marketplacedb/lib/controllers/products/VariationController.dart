import 'package:get/get.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:marketplacedb/data/models/VariantsModel.dart';
import 'dart:convert';
import 'package:marketplacedb/networks/interceptor.dart';

// import 'package:marketplacedb/models/ProductCategoryModel.dart';
// import 'package:marketplacedb/models/ProductTypeModel.dart';

class VariationController extends GetxController {
  var variationList = <VariationModel>[].obs;

  final isLoading = false.obs;
  final token = ''.obs;

  Future<List<VariationModel>> getAllVariants() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}variation/"));
      final List<dynamic> jsonObject = jsonDecode(response.body);

      final List<VariationModel> variations =
          jsonObject.map((e) => VariationModel.fromJson(e)).toList();

      isLoading.value = false;

      variationList.assignAll(variations);

      return variationList;
    } catch (e) {
      print(e);
      isLoading.value = false;
      return [];
    }
  }

  Future<void> getVariantsByProductType(int productTypeId) async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
// ignore_for_file: file_names, avoid_print
          .get(Uri.parse(
              "${MPConstants.url}getVariantsByProductTypes/$productTypeId"));
      final List<dynamic> jsonObject = jsonDecode(response.body);

      final List<VariationModel> variations =
          jsonObject.map((e) => VariationModel.fromJson(e)).toList();

      isLoading.value = false;

      variationList.assignAll(variations);
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }
}
