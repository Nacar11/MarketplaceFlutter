import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/layouts/list_view_layout.dart';
import 'package:marketplacedb/common/widgets/shimmer/shimmer_progress.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/listed_items_list_page/listed_items_list_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/listed_items_list_page/listed_items_list_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class ListedItemsListPage extends StatelessWidget {
  const ListedItemsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductItemController productItemController =
        ProductItemController.instance;
    UserController userController = UserController.instance;
    ListedItemsListPageController controller =
        Get.put(ListedItemsListPageController());
    return Scaffold(
        appBar: PrimarySearchAppBar(
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("My Listed Items",
              style: Theme.of(context).textTheme.headlineSmall),
        ])),
        body: Obx(() => Padding(
            padding: const EdgeInsets.all(MPSizes.defaultSpace),
            child: controller.isLoading.value
                ? MPListViewLayout(
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: MPSizes.spaceBtwItems),
                    itemCount: productItemController.productItemList
                        .where((productItem) =>
                            productItem.userId ==
                            userController.userData.value.id)
                        .length,
                    itemBuilder: (_, index) {
                      return const ShimmerProgressContainer(
                          height: MPSizes.productImageSize * 1.2,
                          width: double.infinity);
                    })
                : controller.listedItemsList.isEmpty
                    ? const MPNoListedItemsDisplay()
                    : const MPListedItems())));
  }
}
