import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/screen/front_page.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();
  final pageController = PageController();
  final currentPageIndex = 0.obs;

  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }

  void dotNavigationClicked(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (currentPageIndex.value == 3) {
      Get.to(() => const FrontPage());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    if (currentPageIndex.value == 3) {
      Get.to(() => const FrontPage());
    }
    currentPageIndex.value = 3;
    pageController.jumpToPage(3);
  }
}
