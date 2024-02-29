import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/texts/section_headings.dart';
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

class MPBillingPaymentSection extends StatelessWidget {
  const MPBillingPaymentSection({super.key});

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

class MPBillingAddressSection extends StatelessWidget {
  const MPBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    return Column(children: [
      MPSectionHeading(
        title: 'Payment Method',
        showActionButton: true,
        buttonTile: "Change",
        onPressed: () {},
      ),
      const SizedBox(height: MPSizes.spaceBtwItems / 2),
      Row(children: [
        MPCircularContainer(
            width: 60,
            height: 35,
            backgroundColor: dark ? MPColors.light : MPColors.white,
            padding: const EdgeInsets.all(MPSizes.sm),
            child: Container())
      ])
    ]);
  }
}
