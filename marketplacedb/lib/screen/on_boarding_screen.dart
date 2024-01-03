import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/screen_specific/on_boarding_screen.dart';
import 'package:marketplacedb/controllers/inner_controllers/on_boarding_controller.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: AnimationsUtils.animation1,
                title: MPTexts.onBoardingTitle1,
                subtitle: MPTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: AnimationsUtils.animation2,
                title: MPTexts.onBoardingTitle2,
                subtitle: MPTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: AnimationsUtils.animation3,
                title: MPTexts.onBoardingTitle3,
                subtitle: MPTexts.onBoardingSubTitle3,
              ),
              OnBoardingPage(
                image: AnimationsUtils.animation4,
                title: MPTexts.onBoardingTitle4,
                subtitle: MPTexts.onBoardingSubTitle4,
              ),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingNavigation(),
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
