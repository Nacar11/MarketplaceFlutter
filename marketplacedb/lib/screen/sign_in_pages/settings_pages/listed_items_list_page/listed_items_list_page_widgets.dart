import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/billing_address_setup/billing_address_setup.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/sell_page/sell_page.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class MPNoListedItemsDisplay extends StatelessWidget {
  const MPNoListedItemsDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserController userController = UserController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Center(
          child: AnimationContainer(
              forever: false,
              width: 1,
              height: 0.3,
              animation: AnimationsUtils.onboardingAnimation3,
              duration: Duration(seconds: 4)),
        ),
        const SizedBox(height: MPSizes.spaceBtwSections),
        Text(
          MPTexts.userListedItemsTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: MPSizes.spaceBtwItems),
        Text(
          MPTexts.userListedItemsSubTitle,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: MPSizes.spaceBtwItems),
        MPPrimaryButton(
          text: 'Start Selling',
          onPressed: () async {
            await userController.userHasAddress();
            if (userController.userHasAddressValue.value == false) {
              Get.to(() => const BillingAddressSetup());
            } else {
              Get.to(() => const SellPage());
            }
            // Get.off(() => const AddBillingAddress());
          },
        )
      ],
    );
  }
}
