import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/listed_items_list_page/listed_items_list_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/listed_items_list_page/listed_items_list_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class ListedItemsListPage extends StatelessWidget {
  const ListedItemsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    ListedItemsListPageController controller =
        Get.put(ListedItemsListPageController());
    return Scaffold(
        appBar: PrimarySearchAppBar(
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("My Listed Items",
              style: Theme.of(context).textTheme.headlineSmall),
        ])),
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(MPSizes.defaultSpace),
                child: controller.listedItemsList.isEmpty
                    ? const MPNoListedItemsDisplay()
                    : Container())));
  }
}
