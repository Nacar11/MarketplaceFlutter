import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/list_item_page/list_item_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/list_item_page/list_item_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

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
      body: const Padding(
        padding: EdgeInsets.all(MPSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ProductListingImagesDisplay()],
        ),
      ),
    );
  }
}
