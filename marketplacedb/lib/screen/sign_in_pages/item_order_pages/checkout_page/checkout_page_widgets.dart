import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/shimmer/shimmer_progress.dart';
import 'package:marketplacedb/common/widgets/texts/section_headings.dart';
import 'package:marketplacedb/controllers/user/user_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/checkout_page/checkout_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/payment_types_page/payment_types_page.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/shopping_cart_page/shopping_cart_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/address_list_page/address_list_page.dart';
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
    ShoppingCartPageController controller = ShoppingCartPageController.instance;
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
        Text('${controller.shoppingCartItemListTotalPrice.value}',
            style: Theme.of(context).textTheme.titleMedium),
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
          Get.to(() => const PaymentTypesPage());
        },
      ),
      Obx(() => controller.isLoading.value
          ? const ShimmerProgressContainer(height: 20, width: 20)
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
                            .confirmedSelectedPaymentType.value.productImage!)),
              ),
              const SizedBox(width: MPSizes.spaceBtwItems / 2),
              Text(controller.confirmedSelectedPaymentType.value.name!,
                  style: Theme.of(context).textTheme.bodyLarge)
            ]))
    ]);
  }
}

class MPBillingAddressSection extends StatelessWidget {
  const MPBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    UserController controller = UserController.instance;
    return Obx(() => controller.isLoading.value
        ? const ShimmerProgressContainer()
        : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            MPSectionHeading(
              title: 'Shipping Address',
              showActionButton: true,
              buttonTile: "Change",
              onPressed: () {
                Get.bottomSheet(
                  const AddressListPage(),
                );
              },
            ),
            Text(
                '${controller.userData.value.firstName} ${controller.userData.value.lastName}',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: MPSizes.spaceBtwItems / 2),
            Row(
              children: [
                const Icon(Icons.phone, color: MPColors.grey, size: 16),
                const SizedBox(width: MPSizes.spaceBtwItems),
                Text(
                    controller.defaultUserAddress.value.address!.contactNumber!,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: MPSizes.spaceBtwItems / 2),
            Row(
              children: [
                const Icon(Icons.location_history,
                    color: MPColors.grey, size: 16),
                const SizedBox(width: MPSizes.spaceBtwItems),
                Expanded(
                    child: Text(
                        '${controller.defaultUserAddress.value.address!.addressLine1!}, ${controller.defaultUserAddress.value.address!.city!.name} ',
                        style: Theme.of(context).textTheme.bodyMedium)),
              ],
            ),
          ]));
  }
}
