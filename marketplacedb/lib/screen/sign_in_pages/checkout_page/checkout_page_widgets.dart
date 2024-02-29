import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/shimmer/shimmer_progress.dart';
import 'package:marketplacedb/common/widgets/texts/section_headings.dart';
import 'package:marketplacedb/screen/sign_in_pages/checkout_page/checkout_page_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class MPCouponCode extends StatelessWidget {
  const MPCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    return MPCircularContainer(
        height: null,
        showBorder: true,
        borderColor: MPColors.dark,
        backgroundColor: dark ? MPColors.dark : MPColors.white,
        padding: const EdgeInsets.only(
            top: MPSizes.sm,
            bottom: MPSizes.sm,
            right: MPSizes.sm,
            left: MPSizes.md),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Enter Promo Code Here',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none),
              ),
            ),
            MPPrimaryButton(
              onPressed: () {},
              text: "Apply",
              isDisabled: true,
            )
          ],
        ));
  }
}

class MPBillingAmountSection extends StatelessWidget {
  const MPBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
        Text('24054', style: Theme.of(context).textTheme.labelLarge),
      ]),
      const SizedBox(height: MPSizes.spaceBtwItems / 2),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
        Text('200', style: Theme.of(context).textTheme.labelLarge),
      ]),
      const SizedBox(height: MPSizes.spaceBtwItems / 2),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
        Text('15', style: Theme.of(context).textTheme.labelLarge),
      ]),
      const SizedBox(height: MPSizes.spaceBtwItems / 2),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
        Text('69000', style: Theme.of(context).textTheme.titleMedium),
      ]),
    ]);
  }
}

class MPBillingPaymentTypeSection extends StatelessWidget {
  const MPBillingPaymentTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    CheckoutPageController controller = CheckoutPageController.instance;
    final dark = MPHelperFunctions.isDarkMode(context);
    return Column(children: [
      MPSectionHeading(
        title: 'Payment Method',
        showActionButton: true,
        buttonTile: "Change",
        onPressed: () {
          Get.bottomSheet(const MPCircularContainer());
        },
      ),
      Obx(() => controller.isLoading.value
          ? const ShimmerProgressContainer()
          : Row(children: [
              Flexible(
                child: MPCircularContainer(
                    width: 100,
                    height: 75,
                    backgroundColor: dark ? MPColors.light : MPColors.white,
                    padding: const EdgeInsets.all(MPSizes.sm),
                    child: MPRoundedImage(
                        isNetworkImage: true,
                        imageUrl: controller
                            .selectedPaymentMethod.value.productImage!)),
              ),
              const SizedBox(width: MPSizes.spaceBtwItems / 2),
              Text(controller.selectedPaymentMethod.value.name!,
                  style: Theme.of(context).textTheme.bodyLarge)
            ]))
    ]);
  }
}

class MPBillingAddressSection extends StatelessWidget {
  const MPBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
