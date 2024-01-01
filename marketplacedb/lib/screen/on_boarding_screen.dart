import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
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
          Positioned(
              child: TextButton(onPressed: () {}, child: const Text("Skip")))
        ],
      ),
    );
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
