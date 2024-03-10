import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/layouts/list_view_layout.dart';
import 'package:marketplacedb/data/models/order_process/order_line_model.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/orders_list_page/orders_list_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/order_details_page/order_details_page.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class MPOrderListItems extends StatelessWidget {
  const MPOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    OrdersListPageController controller = OrdersListPageController.instance;
    return Obx(() => MPListViewLayout(
        itemCount: controller.orderLinesList.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: MPSizes.spaceBtwItems),
        itemBuilder: (_, index) {
          OrderLineModel orderLine = controller.orderLinesList[index];
          return MPSingleOrderListItem(orderLine: orderLine);
        }));
  }
}

class MPSingleOrderListItem extends StatelessWidget {
  const MPSingleOrderListItem({
    super.key,
    required this.orderLine,
  });
  final OrderLineModel orderLine;

  @override
  Widget build(BuildContext context) {
    OrdersListPageController controller = OrdersListPageController.instance;
    final dark = MPHelperFunctions.isDarkMode(context);
    return MPCircularContainer(
        height: null,
        width: double.infinity,
        showBorder: true,
        padding: const EdgeInsets.all(MPSizes.md),
        backgroundColor: dark ? MPColors.dark : MPColors.light,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(children: [
            const Icon(Iconsax.ship),
            const SizedBox(width: MPSizes.spaceBtwItems / 2),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(orderLine.orderStatus!.status!,
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: MPColors.secondary, fontWeightDelta: 1)),
                    Text(MPHelperFunctions.convertDate(orderLine.orderDate!),
                        style: Theme.of(context).textTheme.headlineSmall)
                  ]),
            ),
            IconButton(
                onPressed: () {
                  controller.singleOrderLineDetails.value = orderLine;
                  Get.to(() => const OrderDetailsPage());
                },
                icon: const Icon(Iconsax.arrow_right_34, size: MPSizes.md))
          ]),
          const SizedBox(height: MPSizes.spaceBtwItems),
          Row(children: [
            Expanded(
              child: Row(children: [
                const Icon(Iconsax.tag),
                const SizedBox(width: MPSizes.spaceBtwItems / 2),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Order',
                            style: Theme.of(context).textTheme.labelMedium),
                        Text(orderLine.sku!,
                            style: Theme.of(context).textTheme.labelLarge)
                      ]),
                ),
              ]),
            ),
            Expanded(
              child: Row(children: [
                const Icon(Iconsax.calendar),
                const SizedBox(width: MPSizes.spaceBtwItems / 2),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Shipping Date',
                            style: Theme.of(context).textTheme.labelMedium),
                        Text('TBA',
                            style: Theme.of(context).textTheme.titleMedium)
                      ]),
                ),
              ]),
            ),
          ])
        ]));
  }
}

class NoOrdersDisplay extends StatelessWidget {
  const NoOrdersDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Center(
          child: AnimationContainer(
              forever: true,
              width: 1,
              height: 0.3,
              animation: AnimationsUtils.orderDetails,
              duration: Duration(seconds: 4)),
        ),
        const SizedBox(height: MPSizes.spaceBtwSections),
        Text(
          MPTexts.orderListPageTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: MPSizes.spaceBtwItems),
        Text(
          MPTexts.orderListPageSubTitle,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
