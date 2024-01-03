import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      //Get.to(LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPageIndex.value = 3;
    pageController.jumpToPage(3);
  }
}
