import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/data/models/addresses/user_address_model.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/address_list_page/address_list_page_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/util/popups/address_dialog.dart';
import 'package:marketplacedb/util/popups/alert_dialog.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.userAddress,
  });

  final UserAddressModel userAddress;

  @override
  Widget build(BuildContext context) {
    AddressListPageController controller = AddressListPageController.instance;
    final dark = MPHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        if (userAddress.isDefault! == false) {
          MPAlertDialog.openDialog(
              context,
              "Make this your default address?",
              "Are you sure you want to make this address as your default address?",
              [
                MaterialButton(
                    onPressed: () {
                      MPAlertDialog.popDialog();
                    },
                    child: Text("Cancel",
                        style: Theme.of(context).textTheme.bodyMedium!)),
                MaterialButton(
                    onPressed: () async {
                      controller.selectedAddress.value = userAddress;
                      await controller.setDefaultAddress();
                      MPAlertDialog.popDialog();
                    },
                    child: Text('Approve',
                        style: Theme.of(context).textTheme.bodyMedium!))
              ]);
        }
      },
      child: MPCircularContainer(
          height: null,
          width: double.infinity,
          showBorder: true,
          padding: const EdgeInsets.all(MPSizes.defaultSpace),
          backgroundColor: userAddress.isDefault!
              ? MPColors.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: userAddress.isDefault!
              ? Colors.transparent
              : dark
                  ? MPColors.darkerGrey
                  : MPColors.grey,
          margin: const EdgeInsets.only(bottom: MPSizes.spaceBtwItems),
          child: Stack(children: [
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                onPressed: () {
                  AddressDialog.openDialog(context, userAddress);
                },
                icon: Icon(Iconsax.info_circle5,
                    color: userAddress.isDefault!
                        ? dark
                            ? MPColors.light
                            : MPColors.dark.withOpacity(0.6)
                        : null),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: IconButton(
                  onPressed: () {
                    controller.selectedAddress.value = userAddress;
                    if (controller.selectedAddress.value.isDefault! == true) {
                      MPAlertDialog.openDialog(
                          context,
                          "Default Address cannot be removed ",
                          "Select other address to default", [
                        MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel",
                                style:
                                    Theme.of(context).textTheme.bodyMedium!)),
                      ]);
                    } else {
                      MPAlertDialog.openDialog(context, "Remove Address?",
                          "Are you sure you want to delete this address?", [
                        MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel",
                                style:
                                    Theme.of(context).textTheme.bodyMedium!)),
                        MaterialButton(
                            onPressed: () {
                              controller.deleteAddress();
                              Navigator.of(context).pop();
                            },
                            child: Text('Remove',
                                style: Theme.of(context).textTheme.bodyMedium!))
                      ]);
                    }
                  },
                  icon: Icon(Icons.delete,
                      color: dark ? MPColors.light : MPColors.dark)),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(userAddress.address!.contactNumber!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(width: MPSizes.xs),
              const SizedBox(height: MPSizes.sm / 2),
              Text(userAddress.address!.city!.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall!),
              const SizedBox(height: MPSizes.sm / 2),
              Text(
                userAddress.address!.unitNumber!,
                softWrap: true,
                maxLines: 2,
              ),
              const SizedBox(height: MPSizes.sm / 2),
              Text(
                userAddress.address!.addressLine1!,
                softWrap: true,
                maxLines: 2,
              ),
            ])
          ])),
    );
  }
}
