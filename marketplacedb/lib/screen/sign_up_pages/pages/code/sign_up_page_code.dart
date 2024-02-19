import 'package:flutter/material.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/screen/sign_up_pages/controller/sign_up_pages_controller.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/code/code_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class SignUpPageCode extends StatelessWidget {
  const SignUpPageCode({Key? key}) : super(key: key);

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
            ContainerGuide(
              headerText: MPTexts.codeHeaderText,
              richText: codeSubRichText(context),
            ),
            const SizedBox(height: MPSizes.spaceBtwSections),
            CustomPinInput(
              onCompleted: (otp) {
                controller.otp.value = otp;
              },
            ),
            const SizedBox(height: MPSizes.spaceBtwSections),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomResendCodeRichText(onTapFunction: () async {
                  await controller.getSMSVerificationCode();
                  getSnackBar(
                      MPTexts.otpResentSuccessful, MPTexts.success, false);
                }),
                const SizedBox(height: MPSizes.spaceBtwItems),
                const CustomDifferentNumberRichText(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const CustomSignUpContinue(),
    );
  }
}
