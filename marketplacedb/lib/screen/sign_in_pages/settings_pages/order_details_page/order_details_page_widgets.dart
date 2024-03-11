import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/styles/shadows.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/custom_shapes/custom_curved_edge_widget.dart';
import 'package:marketplacedb/common/widgets/texts/text_with_icons.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/discover_pages/product_item_page/product_item_page.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/orders_list_page/orders_list_page_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class OrderStatusInformation extends StatelessWidget {
  const OrderStatusInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OrdersListPageController controller = OrdersListPageController.instance;
    final dark = MPHelperFunctions.isDarkMode(context);
    return CurvedEdgeWidget(
        child: Container(
            color: dark ? MPColors.darkerGrey : MPColors.secondary,
            child: SizedBox(
              height: null,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(MPSizes.defaultSpace),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Order ${controller.singleOrderLineDetails.value.orderStatus!.status}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .apply(color: MPColors.white)),
                                const SizedBox(height: MPSizes.spaceBtwItems),
                                Text(
                                    MPHelperFunctions.orderDescription(
                                        controller.singleOrderLineDetails.value
                                            .orderStatus!.status!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .apply(color: MPColors.white)),
                                const SizedBox(height: MPSizes.spaceBtwSections)
                              ])),
                      const Icon(
                        Iconsax.receipt_15,
                        color: Colors.white,
                        size: MPSizes.iconLg,
                      ),
                    ]),
              ),
            )));
  }
}

class ShippingInformation extends StatelessWidget {
  const ShippingInformation({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    OrdersListPageController controller = OrdersListPageController.instance;

    return Row(children: [
      Icon(icon),
      const SizedBox(width: MPSizes.defaultSpace),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shipping Information',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: MPSizes.spaceBtwItems / 2),
          Text(controller.singleOrderLineDetails.value.shippingMethod!.name!,
              style: Theme.of(context).textTheme.bodyLarge)
        ],
      )
    ]);
  }
}

class DeliveryAddressInformation extends StatelessWidget {
  const DeliveryAddressInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OrdersListPageController controller = OrdersListPageController.instance;
    return Row(children: [
      const Icon(
        Iconsax.location,
      ),
      const SizedBox(width: MPSizes.defaultSpace),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Delivery Address',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: MPSizes.spaceBtwItems / 2),
            Text(
                '${controller.singleOrderLineDetails.value.user!.firstName!} ${controller.singleOrderLineDetails.value.user!.lastName!}',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: MPSizes.spaceBtwItems / 2),
            Text(controller.singleOrderLineDetails.value.user!.contactNumber!,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: MPSizes.spaceBtwItems / 2),
            Text(
              '${controller.singleOrderLineDetails.value.shippingAddress!.addressLine1!}, ${controller.singleOrderLineDetails.value.shippingAddress!.city!.name}, ${controller.singleOrderLineDetails.value.shippingAddress!.region!.name} ${controller.singleOrderLineDetails.value.shippingAddress!.postalCode!}',
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      )
    ]);
  }
}

class ProductSellerInformation extends StatelessWidget {
  const ProductSellerInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OrdersListPageController controller = OrdersListPageController.instance;
    return Row(children: [
      const Icon(
        Iconsax.user,
      ),
      const SizedBox(width: MPSizes.defaultSpace),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ordered From:', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: MPSizes.spaceBtwItems / 2),
          Text(
              '${controller.singleOrderLineDetails.value.productItem!.user!.firstName!} ${controller.singleOrderLineDetails.value.productItem!.user!.lastName!}',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: MPSizes.spaceBtwItems / 2),
        ],
      )
    ]);
  }
}

class ProductItemInformation extends StatelessWidget {
  const ProductItemInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductItemController productItemController =
        ProductItemController.instance;
    OrdersListPageController controller = OrdersListPageController.instance;
    final dark = MPHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Container(
          width: 90,
          height: 100,
          decoration: BoxDecoration(
              boxShadow: [MPShadowStyle.verticalProductShadow],
              borderRadius: BorderRadius.circular(MPSizes.productImageRadius),
              color: dark ? MPColors.darkerGrey : MPColors.white),
          child: GestureDetector(
            onTap: () async {
              Get.to(() => const ProductItemPage());
              await productItemController.getSingleProductItemDetail(
                  controller.singleOrderLineDetails.value.productItem!.id!);
            },
            child: MPCircularContainer(
              height: 90,
              padding: const EdgeInsets.all(MPSizes.xs),
              backgroundColor: dark ? MPColors.dark : MPColors.light,
              child: MPRoundedImage(
                  isNetworkImage: true,
                  imageUrl: controller.singleOrderLineDetails.value.productItem!
                      .productImages![0].productImage!),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryNameWithCheckIcon(
                textStyle: Theme.of(context).textTheme.labelMedium!,
                text: controller
                    .singleOrderLineDetails.value.productItem!.product!.name!,
              ),
              const SizedBox(height: MPSizes.spaceBtwItems / 2),
              Text(
                controller
                    .singleOrderLineDetails.value.productItem!.description!,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: MPSizes.spaceBtwItems / 2),
              Row(
                children: [
                  Text(
                    'Order ID: ',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: MPSizes.spaceBtwItems / 2),
                  Text(
                    controller.singleOrderLineDetails.value.sku!,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: MPSizes.spaceBtwItems / 2),
            ],
          ),
        ),
      ],
    );
  }
}
