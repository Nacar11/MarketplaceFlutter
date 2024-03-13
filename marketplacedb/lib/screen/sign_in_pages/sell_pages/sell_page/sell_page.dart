// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/list_item_page/list_item_page.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/sell_page/sell_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class SellPage extends StatelessWidget {
  const SellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const MPPrimaryHeaderContainer(
            child: Column(children: [
              MPSellPageAppBar(
                showBackArrow: false,
              ),
              SizedBox(height: MPSizes.spaceBtwSections),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(MPSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MPTexts.sellPageTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: MPSizes.spaceBtwItems),
                Text(
                  MPTexts.sellPageSubTitle,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const Center(
                  child: AnimationContainer(
                      forever: false,
                      width: 1,
                      height: 0.3,
                      animation: AnimationsUtils.onboardingAnimation2,
                      duration: Duration(seconds: 4)),
                ),
                const SizedBox(height: MPSizes.spaceBtwSections / 2),
                MPPrimaryButton(
                  text: 'Proceed',
                  onPressed: () {
                    Get.to(() => const ListItemPage());
                  },
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
