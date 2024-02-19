import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/screen/password_configuration/controller/password_configuration_controller.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/code/code_widgets.dart';
import 'package:marketplacedb/screen/password_configuration/pages/password_reset.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class CodeVerificationForgetPasswordPage extends StatelessWidget {
  final MPLocalStorage localStorage = MPLocalStorage();

  CodeVerificationForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    PasswordConfigurationController controller =
        PasswordConfigurationController.instance;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: MPSpacingStyle.signUpProcessPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MPTexts.codeHeaderText,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: MPSizes.spaceBtwItems),
            Text(
              MPTexts.codeSubText,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              localStorage.readData('emailResetPassword'),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: MPSizes.spaceBtwSections),
            CustomPinInput(
              onCompleted: (otp) {
                controller.otp.value = otp;
              },
            ),
            const SizedBox(height: MPSizes.spaceBtwSections),
            CustomResendCodeRichText(
              onTapFunction: () async {
                await controller.getEmailVerificationCode();
                getSnackBar(MPTexts.otpResentSuccessful, MPTexts.success, true);
              },
            ),
            const SizedBox(height: MPSizes.spaceBtwSections),
            Obx(() => MPPrimaryButton(
                  text: MPTexts.continueText,
                  isLoading: controller.isLoading.value,
                  onPressed: () async {
                    await controller
                        .simulateLoading(const Duration(seconds: 1));
                    if (controller.otp.value ==
                        localStorage.readData('emailVerificationCode')) {
                      Get.offAll(() => PasswordResetPage());
                      getSnackBar(
                          MPTexts.changePassword, MPTexts.codeVerified, true);
                    } else {
                      getSnackBar('Incorrect PIN, Please Try Again.',
                          'Invalid PIN', false);
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
