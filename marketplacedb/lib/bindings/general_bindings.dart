import 'package:get/get.dart';
import 'package:marketplacedb/controllers/network_manager/network_manager.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(NavigationController());
  }
}
