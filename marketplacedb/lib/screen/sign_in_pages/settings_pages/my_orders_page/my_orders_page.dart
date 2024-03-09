import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/my_orders_page/my_orders_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/my_orders_page/my_orders_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    MyOrdersPageController controller = Get.put(MyOrdersPageController());
    return Scaffold(
        appBar: PrimarySearchAppBar(
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("My Orders", style: Theme.of(context).textTheme.headlineSmall),
        ])),
        body: const Padding(
            padding: EdgeInsets.all(MPSizes.defaultSpace),
            child: MPOrderListItems()));
  }
}
