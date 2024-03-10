import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/custom_shapes/custom_curved_edge_widget.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/orders_list_page/orders_list_page_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    OrdersListPageController controller = OrdersListPageController.instance;
    return Scaffold(
        appBar: PrimarySearchAppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order Details",
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            CurvedEdgeWidget(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Order ${controller.singleOrderLineDetails.value.orderStatus!.status}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .apply(color: MPColors.white)),
                                        const SizedBox(
                                            height: MPSizes.spaceBtwItems),
                                        Text(
                                            MPHelperFunctions.orderDescription(
                                                controller
                                                    .singleOrderLineDetails
                                                    .value
                                                    .orderStatus!
                                                    .status!),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .apply(color: MPColors.white)),
                                        const SizedBox(
                                            height: MPSizes.spaceBtwSections)
                                      ])),
                              const Icon(
                                Iconsax.receipt_15,
                                color: Colors.white,
                                size: MPSizes.iconLg,
                              ),
                            ]),
                      ),
                    ))),
            Padding(
              padding: const EdgeInsets.all(MPSizes.defaultSpace),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Icon(
                        Iconsax.truck,
                      ),
                      const SizedBox(width: MPSizes.defaultSpace),
                      Text('Shipping Information',
                          style: Theme.of(context).textTheme.titleLarge)
                    ]),
                    const SizedBox(height: MPSizes.defaultSpace),
                    Text(
                        controller
                            .singleOrderLineDetails.value.shippingMethod!.name!,
                        style: Theme.of(context).textTheme.titleLarge)
                  ]),
            )
          ],
        )));
  }
}
