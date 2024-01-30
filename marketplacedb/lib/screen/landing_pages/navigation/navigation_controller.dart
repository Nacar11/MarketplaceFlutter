import 'package:get/get.dart';
import 'package:marketplacedb/screen/signin_pages/discover_pages/discover_page/discover_page.dart';
import 'package:marketplacedb/screen/landing_pages/home_page/home_page.dart';
import 'package:marketplacedb/screen/signin_pages/settings_pages/account_settings_page/account_settings_page.dart';
import 'package:marketplacedb/screen/signin_pages/favorites_page/favorites_page.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/sellpage.dart';

class NavigationController extends GetxController {
  static NavigationController get static => Get.find();

  final Rx<int> index = 0.obs;

  final screens = [
    const HomePage(),
    const DiscoverPage(),
    const Sellpage(),
    const FavoritesPage(),
    const AccountSettingsPage(),
  ];
}
