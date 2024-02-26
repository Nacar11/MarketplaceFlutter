// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/add_billing_address/add_billing_address.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class BillingAddressSetup extends StatelessWidget {
  const BillingAddressSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimarySearchAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(MPSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MPTexts.billingAddressSetupTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: MPSizes.spaceBtwItems),
            Text(
              MPTexts.billingAddressSetupSubtitle,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Center(
              child: AnimationContainer(
                  forever: true,
                  width: 1,
                  height: 0.3,
                  animation: AnimationsUtils.addressSetup1,
                  duration: Duration(seconds: 4)),
            ),
            const SizedBox(height: MPSizes.spaceBtwSections),
            //animation
            const SizedBox(height: MPSizes.spaceBtwSections),
            MPPrimaryButton(
              text: 'Proceed',
              onPressed: () {
                MPLocalStorage localStorage = MPLocalStorage();
                localStorage.saveData('addAddressToNavigation', true);
                print(localStorage.readData('addAddressToNavigation'));
                Get.off(() => const AddBillingAddress());
              },
            )
          ],
        ),
      ),
    );
  }
}
