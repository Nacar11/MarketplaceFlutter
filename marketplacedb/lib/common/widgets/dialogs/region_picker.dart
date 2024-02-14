import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/list_tile.dart';
import 'package:marketplacedb/screen/signin_pages/sell_pages/add_billing_address/add_billing_address_controller.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class RegionPicker extends StatelessWidget {
  const RegionPicker({
    super.key,
    required this.addBillingAddressController,
  });
  final AddBillingAddressController addBillingAddressController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => MPCircularContainer(
        height: 300,
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: SizedBox(
            height: 300,
            child: addBillingAddressController.regionList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(MPSizes.defaultSpace),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Country not yet selected.",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: MPSizes.spaceBtwItems),
                          Text(
                            "Select your Country first.",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ]),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: addBillingAddressController.regionList.length,
                    itemBuilder: (context, index) {
                      return MPSettingsMenuTile(
                        title:
                            addBillingAddressController.regionList[index].name!,
                        onTap: () async {
                          await addBillingAddressController.onRegionSelected(
                              addBillingAddressController.regionList[index]);
                          print(addBillingAddressController
                              .selectedRegion.value.name);
                          Get.back();
                        },
                      );
                    }),
          ),
        )));
  }
}
