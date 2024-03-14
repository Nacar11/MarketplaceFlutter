import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/list_tile.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/add_billing_address/add_billing_address_controller.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class CountryPickerDialog {
  static void openDialog(
    BuildContext context,
    AddBillingAddressController addBillingAddressController,
  ) {
    Get.defaultDialog(
      title: 'Select Country',
      titlePadding: const EdgeInsets.all(MPSizes.lg),
      titleStyle: Theme.of(context).textTheme.headlineSmall!,
      content: CountryPicker(
          addBillingAddressController: addBillingAddressController),
    );
  }
}

class CountryPicker extends StatelessWidget {
  const CountryPicker({
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
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: addBillingAddressController.countryList.length,
                itemBuilder: (context, index) {
                  return MPSettingsMenuTile(
                    subTitle:
                        addBillingAddressController.countryList[index].code!,
                    title: addBillingAddressController.countryList[index].name!,
                    onTap: () async {
                      await addBillingAddressController.onCountrySelected(
                          addBillingAddressController.countryList[index]);
                      print(addBillingAddressController
                          .selectedCountry.value.name);
                      Get.back();
                    },
                  );
                }),
          ),
        )));
  }
}
