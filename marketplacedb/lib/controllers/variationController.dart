import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/constants/constant.dart';
import 'package:marketplacedb/models/VariantsModel.dart';
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
      final response =
          await AuthInterceptor().get(Uri.parse("${url}variation/"));
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

  Future<List<VariationModel>> getVariantsByProductType(
      int productTypeId) async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${url}getVariantsByProductTypes/$productTypeId"));
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
}
