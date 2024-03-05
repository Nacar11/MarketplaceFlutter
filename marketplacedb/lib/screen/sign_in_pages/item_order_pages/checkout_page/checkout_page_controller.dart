import 'dart:convert';
import 'package:get/get.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/data/models/order_process/payment_type_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/shopping_cart_page/shopping_cart_page_controller.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/util/popups/full_screen_overlay_loader.dart';
import 'package:url_launcher/url_launcher.dart';

ShoppingCartPageController shoppingCartPageController =
    ShoppingCartPageController.instance;
UserController userController = UserController.instance;

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
      MPFullScreenOverlayLoader.openLoadingDialog();
      List<Map<String, dynamic>> lineItems = [];
      for (var item in shoppingCartPageController
          .shoppingCartItemListSelectedToCheckout) {
        lineItems.add({
          "currency": "PHP",
          "images": [item.productItem!.productImages![0].productImage!],
          "amount": (item.productItem!.price! * 100).toInt(),
          "description": item.productItem!.description,
          "name": item.productItem!.product!.name,
          "quantity": 1
        });
        // print(item.productItem!.price!.toInt());
      }
      Map<String, String> headers = {
        "authorization": "Basic c2tfdGVzdF82RGhnRzJBVXJQdXp0OFZ4UjN6ZlFOSkc=",
        "accept": "application/json",
        "Content-Type": "application/json"
      };

      Map<String, dynamic> requestBody = {
        "data": {
          "attributes": {
            "billing": {
              "address": {
                "line1": userController
                    .defaultUserAddress.value.address!.addressLine1!,
                "line2": userController
                        .defaultUserAddress.value.address!.addressLine2 ??
                    'NA',
                "city": userController
                    .defaultUserAddress.value.address!.city!.name!,
                "country": userController
                    .defaultUserAddress.value.address!.country!.code!,
                "postal_code": userController
                    .defaultUserAddress.value.address!.postalCode!,
                "state": userController
                    .defaultUserAddress.value.address!.region!.name!,
              },
              "name":
                  "${userController.userData.value.firstName} ${userController.userData.value.lastName}",
              "email": userController.userData.value.email,
              "phone": userController.userData.value.contactNumber,
            },
            "billing_information_fields_editable": "disabled",
            "send_email_receipt": true,
            "show_description": true,
            "show_line_items": true,
            // "success_url": "//",
            "line_items": lineItems,
            "payment_method_types": [confirmedSelectedPaymentType.value.code!],
            "reference_number": "test_reference_number",
            "description":
                "test checkout description from paymongo developers - marketplace"
          }
        }
      };

      // print(headers);
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
      final response = await http.post(
          Uri.parse("https://api.paymongo.com/v1/checkout_sessions"),
          headers: headers,
          body: jsonEncode(requestBody));

      print(response.body);
      var jsonObject = jsonDecode(response.body);
      print(jsonObject['data']['attributes']['checkout_url']);
      if (jsonObject['data']['attributes']['checkout_url'] != null) {
        print(jsonObject['data']['attributes']['checkout_url']);
        await launchUrl(
          Uri.parse(jsonObject['data']['attributes']['checkout_url']),
          mode: LaunchMode.externalApplication,
        );

        MPFullScreenOverlayLoader.stopLoading();
      } else {
        MPFullScreenOverlayLoader.stopLoading();
      }

      isLoading.value = false;
    } catch (e) {
      MPFullScreenOverlayLoader.stopLoading();
      isLoading.value = false;
      print('Error fetching data: $e');
    }
  }
}
