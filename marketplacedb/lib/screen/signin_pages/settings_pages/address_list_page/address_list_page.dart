import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/layouts/list_view_layout.dart';
import 'package:marketplacedb/common/widgets/shimmer/shimmer_progress.dart';
import 'package:marketplacedb/data/models/addresses/user_address_model.dart';
import 'package:marketplacedb/screen/signin_pages/sell_pages/add_billing_address/add_billing_address.dart';
import 'package:marketplacedb/screen/signin_pages/settings_pages/address_list_page/address_list_controller.dart';
import 'package:marketplacedb/screen/signin_pages/settings_pages/address_list_page/address_list_widgets.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class AddressListPage extends StatelessWidget {
  const AddressListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressListPageController());
    return Obx(() => Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: MPColors.secondary,
            onPressed: () {
              MPLocalStorage localStorage = MPLocalStorage();
              localStorage.saveData('addAddressToNavigation', false);
              print(localStorage.readData('addAddressToNavigation'));
              Get.to(() => const AddBillingAddress());
            },
            child: const Icon(Iconsax.add, color: MPColors.white)),
        appBar: PrimarySearchAppBar(
            title: Text("Addresses",
                style: Theme.of(context).textTheme.headlineSmall)),
        body: SingleChildScrollView(
            child: controller.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.all(MPSizes.defaultSpace),
                    child: Column(children: [
                      MPListViewLayout(
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: MPSizes.spaceBtwItems),
                          itemCount: controller.userAddressList.isNotEmpty
                              ? controller.userAddressList.length
                              : 3,
                          itemBuilder: (_, index) {
                            return const ShimmerProgressContainer(
                                height: MPSizes.productImageSize * 1.2,
                                width: double.infinity);
                          })
                    ]))
                : Padding(
                    padding: const EdgeInsets.all(MPSizes.defaultSpace),
                    child: Column(children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.userAddressList.length,
                          itemBuilder: (_, index) {
                            UserAddressModel userAddress =
                                controller.userAddressList[index];
                            return SingleAddress(userAddress: userAddress);
                          })
                    ])))));
  }
}
