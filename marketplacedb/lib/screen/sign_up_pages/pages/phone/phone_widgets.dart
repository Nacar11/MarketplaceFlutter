import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/screen/sign_up_pages/controller/sign_up_pages_controller.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class CustomSignUpContinue extends StatelessWidget {
  const CustomSignUpContinue({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpPagesController controller = SignUpPagesController.instance;
    return Obx(() => Container(
          height: MPSizes.buttonHeight,
          margin: const EdgeInsets.all(MPSizes.md),
          child: MPPrimaryButton(
              text: MPTexts.continueText,
              isLoading: controller.isLoading.value,
              isDisabled: !controller.isPhoneValid.value,
              onPressed: () async {
                await controller.getSMSVerificationCode();
              }),
        ));
  }
}
