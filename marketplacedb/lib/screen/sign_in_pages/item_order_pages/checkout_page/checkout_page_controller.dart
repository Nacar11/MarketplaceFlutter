import 'dart:convert';
import 'package:get/get.dart';
import 'package:marketplacedb/data/models/order_process/payment_type_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/shopping_cart_page/shopping_cart_page_controller.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

ShoppingCartPageController shoppingCartPageController =
    ShoppingCartPageController.instance;

class CheckoutPageController extends GetxController {
  static CheckoutPageController get instance => Get.find();

  final isLoading = false.obs;
  var paymentTypesList = <PaymentTypeModel>[].obs;
  final selectedPaymentType = PaymentTypeModel().obs;
  final confirmedSelectedPaymentType = PaymentTypeModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await getPaymentTypes();
  }

  Future<void> getPaymentTypes() async {
    try {
      isLoading.value = true;
      final response =
          await AuthInterceptor().get(Uri.parse("${url}getPaymentTypes"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<PaymentTypeModel> list =
            result.map((e) => PaymentTypeModel.fromJson(e)).toList();
        paymentTypesList.assignAll(list);
        selectedPaymentType.value = paymentTypesList[0];
        confirmedSelectedPaymentType.value = paymentTypesList[0];
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

  Future<void> checkOutPayMongo() async {
    try {
      isLoading.value = true;
      const String apiKey = 'sk_test_6DhgG2AUrPuzt8VxR3zfQNJG';
      String basicAuth = 'Basic ${base64Encode(utf8.encode('$apiKey:'))}';
      Map<String, String> headers = {
        "authorization": "Basic c2tfdGVzdF82RGhnRzJBVXJQdXp0OFZ4UjN6ZlFOSkc=",
        "accept": "application/json",
        "Content-Type": "application/json"
      };

      Map<String, dynamic> requestBody = {
        // "data": {
        //   "attributes": {
        //     "send_email_receipt": true,
        //     "show_description": true,
        //     "show_line_items": true,
        //     "line_items": [
        //       {
        //         "currency": "PHP",
        //         "images": [
        //           "https://prompt-closely-goose.ngrok-free.app/images/tops.png"
        //         ],
        //         "amount": 20000,
        //         "description": "product item 1",
        //         "name": "product item 1 ",
        //         "quantity": 1
        //       }
        //     ],
        //     "payment_method_types": [confirmedSelectedPaymentType.value.code!],
        //     "reference_number": "test_reference_number",
        //     "description": "test checkout description"
        //   }
        // }
      };
      print(headers);
      // List<Map<String, dynamic>> lineItems = [];
      // for (var item in shoppingCartPageController
      //     .shoppingCartItemListSelectedToCheckout) {
      //   lineItems.add({
      //     "currency": "PHP",
      //     "images": item.productItem!.productImages![0].productImage,
      //     "amount": item.productItem!.price! * 10,
      //     "description": item.productItem!.description,
      //     "name": item.productItem!.product!.name,
      //     "quantity": 1
      //   });
      // }
      final response = await AuthInterceptor().post(
          Uri.parse("https://api.paymongo.com/v1/checkout_sessions"),
          headers: headers,
          body: jsonEncode(requestBody));

      print(response.body);
      // var jsonObject = jsonDecode(response.body);
      // if (jsonObject['message'] == 'success') {
      //   final List<dynamic> result = jsonObject['data'];
      //   final List<PaymentTypeModel> list =
      //       result.map((e) => PaymentTypeModel.fromJson(e)).toList();
      //   paymentTypesList.assignAll(list);
      //   selectedPaymentType.value = paymentTypesList[0];
      //   confirmedSelectedPaymentType.value = paymentTypesList[0];
      //   isLoading.value = false;
      // } else {
      //   isLoading.value = false;
      //   throw Exception('Failed to fetch data');
      // }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data: $e');
    }
  }
}
