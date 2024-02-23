import 'package:get/get.dart';
import 'package:marketplacedb/data/models/ShoppingCartItemModel.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'dart:convert';
import 'package:marketplacedb/networks/interceptor.dart';

class ShoppingCartPageController extends GetxController {
  static ShoppingCartPageController get instance => Get.find();

  var shoppingCartItemList = <ShoppingCartItemModel>[].obs;
  final isLoading = false.obs;
  // int? subCategoryId;
  // var subCategoryList = <ProductCategoryModel>[].obs;
  // var productTypes = <ProductTypeModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    print('SHOPPING CART CONTROLLER ON INIT');
    print('-----------------------------------------');
    await getShoppingCartItems();
  }

  Future<void> getShoppingCartItems() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${url}getShoppingCartItemsByUser"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ShoppingCartItemModel> list =
            result.map((e) => ShoppingCartItemModel.fromJson(e)).toList();

        shoppingCartItemList.assignAll(list);
        print('SHOPPING CART ITEM LIST LENGTH');
        print(shoppingCartItemList.length);
        print(shoppingCartItemList[0].product_item!.price!.toString());

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
