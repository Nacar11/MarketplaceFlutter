import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/list_tile.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/list_item_page/list_item_page_controller.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class FirstProductCategoryDialog {
  static void openDialog(
      BuildContext context, ListItemPageController controller) {
    Get.defaultDialog(
      title: 'Select Product Category',
      titlePadding: const EdgeInsets.all(MPSizes.lg),
      titleStyle: Theme.of(context).textTheme.headlineSmall!,
      content: const FirstProductCategory(),
    );
  }
}

class FirstProductCategory extends StatelessWidget {
  const FirstProductCategory({
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
            child: controller.filteredProductCategoryFirstList.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(MPSizes.defaultSpace),
                    child: Center(child: CircularProgressIndicator()))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        controller.filteredProductCategoryFirstList.length,
                    itemBuilder: (context, index) {
                      return MPSettingsMenuTile(
                        title: controller
                            .filteredProductCategoryFirstList[index]
                            .categoryName!,
                        onTap: () async {
                          Get.back();
                          await controller.onProductCategory1Selected(controller
                              .filteredProductCategoryFirstList[index]);
                        },
                      );
                    }),
          ),
        )));
  }
}
