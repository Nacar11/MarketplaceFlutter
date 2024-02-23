import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/screen/password_configuration/controller/password_configuration_controller.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/password/password_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class PasswordConfigurationPasswordResetPage extends StatelessWidget {
  final MPLocalStorage localStorage = MPLocalStorage();

  PasswordConfigurationPasswordResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    PasswordConfigurationController controller =
        PasswordConfigurationController.instance;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarBackToHomeScreen(),
      body: Padding(
        padding: MPSpacingStyle.signUpProcessPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MPTexts.resetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: MPSizes.spaceBtwItems),
            Text(
              MPTexts.passwordSubText,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: MPSizes.spaceBtwSections),
            PasswordValidatorField(
              labelText: MPTexts.enterPassword,
              onChanged: (value) {
                controller.passwordsMatch.value =
                    value == controller.reEnterPassword.text;
                controller.onPasswordChange(value);
              },
              controller: controller.password,
            ),
            const SizedBox(height: MPSizes.spaceBtwInputFields),
            PasswordValidatorField(
              labelText: MPTexts.enterPassword,
              onChanged: (value) {
                controller.passwordsMatch.value =
                    value == controller.password.text;
              },
              controller: controller.reEnterPassword,
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(left: MPSizes.sm),
                child: Column(
                  children: [
                    const SizedBox(height: MPSizes.spaceBtwSections),
                    CustomPasswordCondition(
                      conditionBoolValue:
                          controller.isPasswordEightCharacters.value,
                      text: MPTexts.passwordEightChars,
                    ),
                    const SizedBox(height: MPSizes.spaceBtwInputFields),
                    CustomPasswordCondition(
                      conditionBoolValue: controller.isPasswordOneNumber.value,
                      text: MPTexts.passwordOneNumber,
                    ),
                    const SizedBox(height: MPSizes.spaceBtwInputFields),
                    CustomPasswordCondition(
                      conditionBoolValue:
                          controller.isPasswordOneSpecialChar.value,
                      text: MPTexts.passwordSpecialChars,
                    ),
                    const SizedBox(height: MPSizes.spaceBtwInputFields),
                    CustomPasswordCondition(
                      conditionBoolValue: controller.passwordsMatch.value,
                      text: MPTexts.passwordsMatch,
                    ),
                    const SizedBox(height: MPSizes.spaceBtwSections),
                    MPPrimaryButton(
                      text: MPTexts.continueText,
                      isDisabled: !controller.isPasswordEightCharacters.value ||
                          !controller.isPasswordOneNumber.value ||
                          !controller.isPasswordOneSpecialChar.value ||
                          !controller.passwordsMatch.value,
                      isLoading: controller.isLoading.value,
                      onPressed: () async {
                        await controller.changePassword();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
