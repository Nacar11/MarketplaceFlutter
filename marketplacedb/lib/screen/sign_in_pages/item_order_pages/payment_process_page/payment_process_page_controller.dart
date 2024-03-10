import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/checkout_page/checkout_page_controller.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';
import 'package:http/http.dart' as http;

CheckoutPageController checkoutPageController = CheckoutPageController.instance;

class PaymentProcessPageController extends GetxController {
  static PaymentProcessPageController get instance => Get.find();
  final checkoutSessionId = ''.obs;
  final checkoutUrl = ''.obs;
  final isLoading = false.obs;
  final MPLocalStorage localStorage = MPLocalStorage();
  @override
  void onInit() async {
    super.onInit();
    await getCheckOutSession();
  }

  @override
  void onClose() async {
    await http.post(
        Uri.parse(
            "https://api.paymongo.com/v1/checkout_sessions/$checkoutSessionId/expire"),
        headers: MPConstants.paymongoApiHeaders);
    getSnackBar('Your payment session with Paymongo has expired.',
        "Payment Session Expired", true);
    localStorage.removeData('checkoutSessionId');
    localStorage.removeData('checkoutUrl');
    super.onClose();
  }

  Future<void> getCheckOutSession() async {
    try {
      checkoutSessionId.value = localStorage.readData('checkoutSessionId');
      checkoutUrl.value = localStorage.readData('checkoutUrl');
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data: $e');
    }
  }
}
