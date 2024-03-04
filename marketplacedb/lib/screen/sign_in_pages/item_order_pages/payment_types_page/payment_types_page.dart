import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/layouts/list_view_layout.dart';
import 'package:marketplacedb/data/models/order_process/payment_type_model.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/checkout_page/checkout_page_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class PaymentTypesPage extends StatelessWidget {
  const PaymentTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    CheckoutPageController controller = CheckoutPageController.instance;
    final dark = MPHelperFunctions.isDarkMode(context);
    return Scaffold(
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(MPSizes.defaultSpace),
            child: SizedBox(
              width: double.infinity,
              height: MPSizes.buttonHeight,
              child: MPPrimaryButton(
                onPressed: () {
                  controller.confirmedSelectedPaymentType.value =
                      controller.selectedPaymentType.value;
                  Get.back();
                },
                text: "Confirm",
              ),
            )),
        appBar: PrimarySearchAppBar(
          title: Text("Payment Type",
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: MPSizes.md),
          child: SingleChildScrollView(
            child: MPListViewLayout(
                separatorBuilder: (_, __) => const Column(
                      children: [
                        Divider(),
                      ],
                    ),
                itemBuilder: (_, index) {
                  PaymentTypeModel paymentType =
                      controller.paymentTypesList[index];
                  return Obx(() => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: MPSizes.sm),
                            title: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: MPCircularContainer(
                                    width: null,
                                    height: null,
                                    backgroundColor:
                                        dark ? MPColors.light : MPColors.white,
                                    child: MPRoundedImage(
                                      imageUrl: paymentType.productImage!,
                                      isNetworkImage: true,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: MPSizes.xs),
                                Expanded(
                                  flex: 3,
                                  child: Text(paymentType.name!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ),
                                Radio(
                                  value: paymentType,
                                  groupValue:
                                      controller.selectedPaymentType.value,
                                  onChanged: (value) {
                                    controller.selectedPaymentType.value =
                                        value as PaymentTypeModel;
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              controller.selectedPaymentType.value =
                                  paymentType;
                            },
                          ),
                        ],
                      ));
                },
                itemCount: controller.paymentTypesList.length),
          ),
        ));
  }
}
