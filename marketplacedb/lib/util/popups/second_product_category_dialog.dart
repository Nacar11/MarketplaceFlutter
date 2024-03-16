import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/list_tile.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/list_item_page/list_item_page_controller.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class SecondProductCategoryDialog {
  static void openDialog(
      BuildContext context, ListItemPageController controller) {
    Get.defaultDialog(
      title: controller.filteredProductCategorySecondList.isEmpty
          ? ''
          : 'Select Product Category',
      titlePadding: const EdgeInsets.all(MPSizes.lg),
      titleStyle: Theme.of(context).textTheme.headlineSmall!,
      content: const SecondProductCategory(),
    );
  }
}

class SecondProductCategory extends StatelessWidget {
  const SecondProductCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ListItemPageController controller = ListItemPageController.instance;
    return Obx(() => MPCircularContainer(
        height: 300,
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: SizedBox(
            height: 300,
            child: controller.filteredProductCategorySecondList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: MPSizes.defaultSpace),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: MPSizes.spaceBtwSections * 2),
                          Text(
                            "Main Product Category not selected.",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: MPSizes.spaceBtwItems),
                          Text(
                            "Select the product category of your item first.",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ]),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        controller.filteredProductCategorySecondList.length,
                    itemBuilder: (context, index) {
                      return MPSettingsMenuTile(
                        title: controller
                            .filteredProductCategorySecondList[index]
                            .categoryName!,
                        onTap: () async {
                          Get.back();
                          await controller.onProductCategory2Selected(controller
                              .filteredProductCategorySecondList[index]);
                        },
                      );
                    }),
          ),
        )));
  }
}
