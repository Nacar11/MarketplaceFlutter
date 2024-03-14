import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/list_tile.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/add_billing_address/add_billing_address_controller.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class CityPickerDialog {
  static void openDialog(
    BuildContext context,
    AddBillingAddressController addBillingAddressController,
  ) {
    Get.defaultDialog(
      title: 'Select City',
      titlePadding: const EdgeInsets.all(MPSizes.lg),
      titleStyle: Theme.of(context).textTheme.headlineSmall!,
      content:
          CityPicker(addBillingAddressController: addBillingAddressController),
    );
  }
}

class CityPicker extends StatelessWidget {
  const CityPicker({
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
              child: addBillingAddressController.cityList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(MPSizes.defaultSpace),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Region not yet selected.",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: MPSizes.spaceBtwItems),
                            Text(
                              "Select your region first.",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ]),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: addBillingAddressController.cityList.length,
                      itemBuilder: (context, index) {
                        return MPSettingsMenuTile(
                          title:
                              addBillingAddressController.cityList[index].name!,
                          onTap: () async {
                            await addBillingAddressController.onCitySelected(
                                addBillingAddressController.cityList[index]);
                            print(addBillingAddressController
                                .selectedCity.value.name);
                            Get.back();
                          },
                        );
                      })),
        )));
  }
}
