import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/common/widgets/layouts/list_view_layout.dart';
import 'package:marketplacedb/common/widgets/shimmer/shimmer_progress.dart';
import 'package:marketplacedb/common/widgets/texts/peso_sign.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/list_item_page/list_item_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/list_item_page/list_item_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/validators.dart';
import 'package:marketplacedb/util/popups/alert_dialog.dart';
import 'package:marketplacedb/util/popups/dialog_container_loader.dart';
import 'package:marketplacedb/util/popups/first_product_category_dialog.dart';
import 'package:marketplacedb/util/popups/full_screen_overlay_loader.dart';
import 'package:marketplacedb/util/popups/product_type_dialog.dart';
import 'package:marketplacedb/util/popups/second_product_category_dialog.dart';

class ListItemPage extends StatelessWidget {
  const ListItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    ListItemPageController controller = Get.put(ListItemPageController());
    return Scaffold(
      appBar: PrimarySearchAppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Product Listing",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProductListingImagesDisplay(),
            Padding(
                padding: const EdgeInsets.all(MPSizes.defaultSpace),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product Category',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: MPSizes.spaceBtwItems),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                FirstProductCategoryDialog.openDialog(
                                    context, controller);
                              },
                              child: Obx(() => ProductDialogContainer(
                                    text: controller
                                            .selectedFirstProductCategory
                                            .value
                                            .categoryName ??
                                        "Select Main Category",
                                  )),
                            ),
                          ),
                          const SizedBox(width: MPSizes.spaceBtwInputFields),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                SecondProductCategoryDialog.openDialog(
                                    context, controller);
                              },
                              child: Obx(() => ProductDialogContainer(
                                    text: controller
                                            .selectedSecondProductCategory
                                            .value
                                            .categoryName ??
                                        "Select Sub-Category",
                                  )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: MPSizes.spaceBtwItems),
                      Text('Product Type',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: MPSizes.spaceBtwItems),
                      GestureDetector(
                        onTap: () {
                          ProductTypeDialog.openDialog(context, controller);
                        },
                        child: Obx(() => ProductDialogContainer(
                              text: controller.selectedProductType.value.name ??
                                  "Select Product Type",
                            )),
                      ),
                      const SizedBox(height: MPSizes.spaceBtwItems),
                      Text('Your Item Description',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: MPSizes.spaceBtwItems),
                      Form(
                        key: controller.itemDescriptionKey,
                        child: ValidatorField(
                          onChanged: (value) {
                            controller.isItemDescriptionValid.value = controller
                                    .itemDescriptionKey.currentState!
                                    .validate() ==
                                true;
                          },
                          validator: (value) =>
                              MPValidator.validateDescriptionLength(
                            value,
                            'Item Description',
                          ),
                          maxLines: 3,
                          controller: controller.itemDescription.value,
                          labelText: 'Item Description',
                        ),
                      ),
                      const SizedBox(height: MPSizes.spaceBtwSections),
                      Text('Specify Variation:',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: MPSizes.spaceBtwSections),
                      const Divider(),
                      Obx(() => controller.variationListWidgetLoading.value
                          ? Padding(
                              padding:
                                  const EdgeInsets.all(MPSizes.defaultSpace),
                              child: MPListViewLayout(
                                separatorBuilder: (_, __) => const SizedBox(
                                    height: MPSizes.spaceBtwSections),
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return const ShimmerProgressContainer(
                                      height: 75, width: double.infinity);
                                },
                              ))
                          : controller.specifiedVariationList.isEmpty
                              ? Column(
                                  children: [
                                    const SizedBox(
                                        height: MPSizes.spaceBtwSections),
                                    Center(
                                      child: Text(
                                          'No Product Category Variation',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall),
                                    ),
                                    const SizedBox(
                                        height: MPSizes.spaceBtwSections),
                                  ],
                                )
                              : const Padding(
                                  padding: EdgeInsets.all(MPSizes.defaultSpace),
                                  child: VariationPicker())),
                      const Divider(),
                      const SizedBox(height: MPSizes.spaceBtwSections),
                      Row(
                        children: [
                          Text('Price',
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(width: MPSizes.spaceBtwItems),
                          const PesoSign(),
                          const SizedBox(width: MPSizes.spaceBtwItems),
                          Expanded(
                              child: Form(
                            key: controller.itemPriceKey,
                            child: ValidatorField(
                              onChanged: (value) {
                                controller.isItemPriceValid.value = controller
                                        .itemPriceKey.currentState!
                                        .validate() ==
                                    true;
                              },
                              validator: (value) => MPValidator.validatePrice(
                                  value,
                                  minimumPrice: 60,
                                  maximumPrice: 200000),
                              controller: controller.itemPrice.value,
                              isKeyboardInputNumber: true,
                              labelText: 'Item Price',
                            ),
                          ))
                        ],
                      ),
                      const SizedBox(height: MPSizes.spaceBtwSections),
                      Obx(() => MPPrimaryButton(
                          isDisabled: !(controller.selectedImages
                                  .any((image) => image != null) &&
                              controller.isItemPriceValid.value &&
                              controller.isItemDescriptionValid.value &&
                              controller.selectedProductType.value.id != null &&
                              (controller.selectedVariationOptionList.isEmpty ||
                                  (controller.selectedVariationOptionList
                                              .length ==
                                          controller
                                              .specifiedVariationList.length &&
                                      controller.selectedVariationOptionList
                                          .every(
                                              (option) => option.id != null)))),
                          onPressed: () {
                            MPAlertDialog.openDialog(
                                context,
                                "Add Item to Marketplace Listing?",
                                "Are you sure you want to create this item and add this to MarketPlace?",
                                [
                                  MaterialButton(
                                      onPressed: () {
                                        MPAlertDialog.popDialog();
                                      },
                                      child: Text("Cancel",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!)),
                                  MaterialButton(
                                      onPressed: () async {
                                        controller.isLoading.value == true
                                            ? null
                                            : {
                                                MPAlertDialog.popDialog(),
                                                await controller.imageUpload(),
                                              };
                                      },
                                      child: Text('Add',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!))
                                ]);
                          },
                          text: 'List Item'))
                    ]))
          ],
        ),
      ),
    );
  }
}
