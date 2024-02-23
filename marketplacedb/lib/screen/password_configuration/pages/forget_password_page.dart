import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/screen/password_configuration/controller/password_configuration_controller.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class PasswordConfigurationForgetPasswordPage extends StatelessWidget {
  const PasswordConfigurationForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PasswordConfigurationController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(MPSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MPTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: MPSizes.spaceBtwItems),
            Text(
              MPTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: MPSizes.spaceBtwSections),
            ValidatorField(
              onChanged: (value) {
                controller.isEmailValid.value =
                    value.contains("@") && value.isNotEmpty;
                print(controller.isEmailValid.value);
              },
              controller: controller.email,
              labelText: MPTexts.email,
              prefixIcon: const Icon(Iconsax.card_pos),
            ),
            const SizedBox(height: MPSizes.spaceBtwSections),
            Obx(() => MPPrimaryButton(
                  text: MPTexts.continueText,
                  isDisabled: !controller.isEmailValid.value,
                  isLoading: controller.isLoading.value,
                  onPressed: () async {
                    await controller.getEmailVerificationCode();
                  },
                ))
          ],
        ),
      ),
    );
  }
}
