import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/orders_list_page/orders_list_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/orders_list_page/orders_list_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class OrdersListPage extends StatelessWidget {
  const OrdersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    OrdersListPageController controller = Get.put(OrdersListPageController());
    return Scaffold(
        appBar: PrimarySearchAppBar(
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("My Orders", style: Theme.of(context).textTheme.headlineSmall),
        ])),
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(MPSizes.defaultSpace),
                child: controller.orderLinesList.isEmpty
                    ? const NoOrdersDisplay()
                    : const MPOrderListItems())));
  }
}
