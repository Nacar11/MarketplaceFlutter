import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/screen/signin_pages/sell_pages/add_billing_address/add_billing_address.dart';
import 'package:marketplacedb/screen/signin_pages/settings_pages/address_list_page/address_list_controller.dart';
import 'package:marketplacedb/screen/signin_pages/settings_pages/address_list_page/address_list_widgets.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class AddressListPage extends StatelessWidget {
  const AddressListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addressListPageController = Get.put(AddressListPageController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: MPColors.secondary,
            onPressed: () => Get.to(() => const AddBillingAddress()),
            child: const Icon(Iconsax.add, color: MPColors.white)),
        appBar: PrimarySearchAppBar(
            title: Text("Addresses",
                style: Theme.of(context).textTheme.headlineSmall)),
        body: const SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(MPSizes.defaultSpace),
                child: Column(children: [
                  SingleAddress(selectedAddress: true),
                  SingleAddress(selectedAddress: false),
                  SingleAddress(selectedAddress: false),
                  SingleAddress(selectedAddress: false)
                ]))));
  }
}
