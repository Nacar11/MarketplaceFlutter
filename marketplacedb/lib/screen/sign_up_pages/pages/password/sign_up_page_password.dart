import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/screen/sign_up_pages/controller/sign_up_pages_controller.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/password/password_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class SignUpPagePassword extends StatelessWidget {
  const SignUpPagePassword({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpPagesController controller = SignUpPagesController.instance;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PrimaryAppBarColored(title: MPTexts.getStarted),
      body: Padding(
        padding: MPSpacingStyle.signUpProcessPadding,
        child: Column(
          children: [
            const ContainerGuide(
              headerText: MPTexts.passwordHeaderText,
              text: MPTexts.passwordSubText,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const CustomSignUpContinue(),
    );
  }
}
