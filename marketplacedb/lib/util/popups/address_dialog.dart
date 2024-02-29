import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/texts/address_details.dart';
import 'package:marketplacedb/data/models/addresses/user_address_model.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class AddressDialog {
  static void openDialog(
    BuildContext context,
    UserAddressModel userAddress,
  ) {
    final dark = MPHelperFunctions.isDarkMode(context);
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
                backgroundColor: dark ? MPColors.darkerGrey : MPColors.white,
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Address Details",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      )
                    ]),
                content: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AddressDetails(
                          title: 'Default Address',
                          value: userAddress.isDefault! ? "Yes" : "No",
                        ),
                        AddressDetails(
                          title: 'Unit Number',
                          value: userAddress.address!.unitNumber ?? "NA",
                        ),
                        AddressDetails(
                          title: 'Address Line 1',
                          value: userAddress.address!.addressLine1!,
                        ),
                        AddressDetails(
                          title: 'Address Line 2',
                          value: userAddress.address!.addressLine2 ?? "NA",
                        ),
                        AddressDetails(
                          title: 'City',
                          value: userAddress.address!.city!.name!,
                        ),
                        AddressDetails(
                          title: 'Region',
                          value: userAddress.address!.region!.name!,
                        ),
                        AddressDetails(
                          title: 'Country',
                          value:
                              "${userAddress.address!.country!.code!} ${userAddress.address!.country!.name!}",
                        ),
                        AddressDetails(
                          title: 'Zip Code',
                          value: userAddress.address!.postalCode!,
                        ),
                      ]),
                ),
                actions: [
                  MaterialButton(
                      onPressed: () {
                        AddressDialog.popDialog();
                      },
                      child: Text("Close",
                          style: Theme.of(context).textTheme.bodyMedium!)),
                ]));
  }

  static popDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
