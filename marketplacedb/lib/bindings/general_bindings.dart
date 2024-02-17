import 'package:get/get.dart';
import 'package:marketplacedb/controllers/network_manager/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
