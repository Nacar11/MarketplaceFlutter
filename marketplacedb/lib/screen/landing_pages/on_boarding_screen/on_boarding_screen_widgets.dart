import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:marketplacedb/screen/landing_pages/on_boarding_screen/on_boarding_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/device/device_utility.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MPDeviceUtils.getAppBarHeight(),
        right: MPSizes.spaceBtwItems,
        child: TextButton(
            onPressed: () {
              OnBoardingController.instance.skipPage();
            },
            child: const Text("Skip")));
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MPSizes.defaultSpace),
      child: Column(
        children: [
          Lottie.asset(
            image,
            width: MPHelperFunctions.screenWidth() * 0.8,
            height: MPHelperFunctions.screenHeight() * 0.6,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: MPSizes.spaceBtwItems),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class OnBoardingNavigation extends StatelessWidget {
  const OnBoardingNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = MPHelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: MPDeviceUtils.getBottomNavigationBarHeight(),
        left: MPSizes.defaultSpace,
        child: SmoothPageIndicator(
            controller: controller.pageController,
            onDotClicked: controller.dotNavigationClicked,
            count: 4,
            effect: ExpandingDotsEffect(
                activeDotColor: dark ? MPColors.light : MPColors.dark,
                dotHeight: 6)));
  }
}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    return Positioned(
        right: MPSizes.defaultSpace,
        bottom: MPDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
            onPressed: () {
              OnBoardingController.instance.nextPage();
            },
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: dark ? MPColors.buttonPrimary : Colors.black),
            child: Padding(
                padding: const EdgeInsets.all(MPSizes.md),
                child: Icon(Iconsax.arrow_right_3,
                    color: dark ? Colors.white : MPColors.buttonPrimary))));
  }
}
