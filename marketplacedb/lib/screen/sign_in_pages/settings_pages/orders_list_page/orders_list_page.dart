import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/layouts/list_view_layout.dart';
import 'package:marketplacedb/common/widgets/shimmer/shimmer_progress.dart';
import 'package:marketplacedb/controllers/order_process/order_line_controller.dart';
import 'package:marketplacedb/controllers/user/user_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/orders_list_page/orders_list_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/orders_list_page/orders_list_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class OrdersListPage extends StatelessWidget {
  const OrdersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    OrderLineController orderLineController = OrderLineController.instance;
    UserController userController = UserController.instance;
    OrdersListPageController controller = Get.put(OrdersListPageController());
    return Scaffold(
        appBar: PrimarySearchAppBar(
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("My Orders", style: Theme.of(context).textTheme.headlineSmall),
        ])),
        body: Obx(() => Padding(
            padding: const EdgeInsets.all(MPSizes.defaultSpace),
            child: controller.isLoading.value
                ? Column(children: [
                    MPListViewLayout(
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: MPSizes.spaceBtwItems),
                        itemCount: orderLineController.orderLineList
                            .where((orderLine) =>
                                orderLine.user!.id ==
                                userController.userData.value.id)
                            .length,
                        itemBuilder: (_, index) {
                          return const ShimmerProgressContainer(
                              height: MPSizes.productImageSize * 1.2,
                              width: double.infinity);
                        })
                  ])
                : controller.orderLinesList.isEmpty
                    ? const NoOrdersDisplay()
                    : const MPOrderListItems())));
  }
}
