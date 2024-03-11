// import 'package:flutter/material.dart';

// class ListedItemsListPage extends StatelessWidget {
//   const ListedItemsListPage({super.key});

//   @override
//  Widget build(BuildContext context) {
//     OrdersListPageController controller = Get.put(OrdersListPageController());
//     return Scaffold(
//         appBar: PrimarySearchAppBar(
//             title:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text("My Orders", style: Theme.of(context).textTheme.headlineSmall),
//         ])),
//         body: Obx(() => controller.isLoading.value
//             ? const Center(child: CircularProgressIndicator())
//             : Padding(
//                 padding: const EdgeInsets.all(MPSizes.defaultSpace),
//                 child: controller.orderLinesList.isEmpty
//                     ? const NoOrdersDisplay()
//                     : const MPOrderListItems())));
//   }
// }
