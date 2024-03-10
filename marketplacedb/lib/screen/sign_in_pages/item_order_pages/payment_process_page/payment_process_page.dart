import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/payment_process_page/payment_process_page_controller.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentProcessPage extends StatelessWidget {
  const PaymentProcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    PaymentProcessPageController controller =
        Get.put(PaymentProcessPageController());
    NavigationController navigationController = Get.put(NavigationController());
    return Scaffold(
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(MPSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: MPSizes.spaceBtwSections),
                Text(
                  MPTexts.paymentProcessPageTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: MPSizes.spaceBtwItems),
                Text(
                  MPTexts.paymentProcessPageSubTitle1,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: MPSizes.spaceBtwItems / 2),
                Text(
                  MPTexts.paymentProcessPageSubTitle2,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: MPSizes.spaceBtwSections),
                Text(
                  'Go to Checkout Payment Session:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: MPSizes.spaceBtwItems / 2),
                InkWell(
                  onTap: () async {
                    await launchUrl(
                      Uri.parse(controller.checkoutUrl.value),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Text(
                    'https://checkout.paymongo.com/${controller.checkoutSessionId.value}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MPColors.primary,
                        decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(height: MPSizes.spaceBtwItems / 2),
                Text(
                  MPTexts.paymentProcessPageSubTitle3,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Center(
                  child: AnimationContainer(
                      forever: true,
                      width: 1,
                      height: 0.2,
                      animation: AnimationsUtils.paymentProcess,
                      duration: Duration(seconds: 4)),
                ),
                const SizedBox(height: MPSizes.spaceBtwSections * 2),
                MPOutlinedButton(
                  icon: const Icon(Iconsax.home4),
                  text: 'Go Back to Homepage',
                  onPressed: () async {
                    navigationController.index.value = 0;
                    Get.offAll(() => const Navigation());
                  },
                ),
                const SizedBox(height: MPSizes.spaceBtwItems / 2),
                MPOutlinedButton(
                  icon: const Icon(Iconsax.bag_tick),
                  text: 'Go to My Orders',
                  onPressed: () async {
                    navigationController.index.value = 4;
                    Get.offAll(() => const Navigation());
                  },
                ),
              ],
            ),
          )),
    );
  }
}
