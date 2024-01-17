import 'package:get/get.dart';
import 'package:marketplacedb/screen/signin_pages/discoverpage_pages/discover_page.dart';
import 'package:marketplacedb/screen/landing_pages/home_page.dart';
import 'package:marketplacedb/screen/signin_pages/mepage_pages/mepage.dart';
import 'package:marketplacedb/screen/signin_pages/messagespage_pages/messagepage.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/sellpage.dart';

class NavigationController extends GetxController {
  static NavigationController get static => Get.find();

  final Rx<int> index = 0.obs;

  final screens = [
    const HomePage(),
    const DiscoverPage(),
    const Sellpage(),
    const Messagepage(),
    const Mepage(),
  ];
}
