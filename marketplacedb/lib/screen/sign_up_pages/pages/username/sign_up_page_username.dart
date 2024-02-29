// ignore_for_file: use_build_context_synchronously, avoid_print, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/screen/sign_up_pages/controller/sign_up_pages_controller.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/username/username_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class SignUpPageUsername extends StatelessWidget {
  const SignUpPageUsername({super.key});

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
                headerText: MPTexts.usernameHeaderText,
                text: MPTexts.usernameSubText),
            const SizedBox(height: MPSizes.spaceBtwSections),
            const CustomUsernameFormField(),
            const SizedBox(height: MPSizes.spaceBtwSections),
            Obx(() => Column(children: [
                  MPCheckBox(
                    text: 'Subscribe to MarketPlace Promotions',
                    checkBoxValue: controller.isSubscribedToPromotions.value,
                    onValueChanged: (newBool) {
                      controller.isSubscribedToPromotions.value = newBool;
                    },
                  ),
                  const SizedBox(height: MPSizes.spaceBtwInputFields),
                  MPCheckBox(
                    text: 'Subscribe to MarketPlace Newsletters',
                    checkBoxValue: controller.isSubscribedToNewsletters.value,
                    onValueChanged: (newBool) {
                      controller.isSubscribedToNewsletters.value = newBool;
                    },
                  ),
                  const SizedBox(height: MPSizes.spaceBtwInputFields),
                  Row(children: [
                    Checkbox(
                        activeColor: Colors.green,
                        value: controller.agreements.value,
                        onChanged: (value) {
                          controller.agreements.value = value!;
                        }),
                    const AgreementsText()
                  ])
                ]))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const CustomSignUpContinue(),
    );
  }
}
