import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/texts/peso_sign.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/order_details_page/order_details_page_widgets.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/orders_list_page/orders_list_page_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/util/popups/alert_dialog.dart';
import 'package:marketplacedb/util/popups/dialog_container_loader.dart';

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
            const OrderStatusInformation(),
            Padding(
              padding: const EdgeInsets.all(MPSizes.defaultSpace),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShippingInformation(icon: Iconsax.truck),
                    const SizedBox(height: MPSizes.defaultSpace / 2),
                    const Divider(),
                    const SizedBox(height: MPSizes.defaultSpace / 2),
                    const DeliveryAddressInformation(),
                    const SizedBox(height: MPSizes.defaultSpace / 2),
                    const Divider(),
                    const SizedBox(height: MPSizes.defaultSpace / 2),
                    const ProductSellerInformation(),
                    const SizedBox(height: MPSizes.defaultSpace / 2),
                    const ProductItemInformation(),
                    const SizedBox(height: MPSizes.defaultSpace / 2),
                    const Divider(),
                    const SizedBox(height: MPSizes.defaultSpace / 2),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Total ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: MPSizes.defaultSpace / 2),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const PesoSign(),
                                    const SizedBox(
                                        width: MPSizes.defaultSpace / 2),
                                    Text(
                                      controller
                                          .singleOrderLineDetails.value.price!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ],
                                ),
                                controller.singleOrderLineDetails.value
                                            .orderStatus!.status ==
                                        'Processing'
                                    ? MPOutlinedButton(
                                        text: 'Cancel',
                                        onPressed: () async {
                                          MPAlertDialog.openDialog(
                                              context,
                                              "Cancel your Order?",
                                              "Are you sure you want to cancel this item order?",
                                              [
                                                MaterialButton(
                                                    onPressed: () {
                                                      MPAlertDialog.popDialog();
                                                    },
                                                    child: Text("Close",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!)),
                                                MaterialButton(
                                                    onPressed: () async {
                                                      MPAlertLoaderDialog
                                                          .openLoadingDialog();
                                                      await controller
                                                          .cancelOrder();
                                                      MPAlertDialog.popDialog();
                                                      MPAlertLoaderDialog
                                                          .stopLoading();
                                                    },
                                                    child: Text('Cancel Order',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!)),
                                              ]);
                                        },
                                        icon: Icon(Icons.cancel,
                                            color: dark
                                                ? MPColors.light
                                                : MPColors.dark))
                                    : controller.singleOrderLineDetails.value
                                                .orderStatus!.status ==
                                            'Cancelled'
                                        ? Container()
                                        : Container(),
                              ])
                        ])
                  ]),
            )
          ],
        )));
  }
}
