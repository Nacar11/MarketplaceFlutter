import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/screen/sign_up_pages/code/code_widgets.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/password_configuration/password_reset.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class CodeVerificationForgetPasswordPage extends StatefulWidget {
  const CodeVerificationForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<CodeVerificationForgetPasswordPage> createState() =>
      CodeVerificationForgetPasswordPageState();
}

class CodeVerificationForgetPasswordPageState
    extends State<CodeVerificationForgetPasswordPage> {
  String otpCode = '';
  AuthenticationController authController = AuthenticationController.instance;
  bool isCodeValid = true;
  MPLocalStorage localStorage = MPLocalStorage();

  void onTapFunction() async {
    var response = await authController
        .getEmailVerificationCode(localStorage.readData('emailResetPassword'));
    print(response);
    if (response['message'] == 'success') {
      localStorage.saveData(
          'emailVerificationCode', response['code'].toString());
      getSnackBar(MPTexts.otpResentSuccessful, MPTexts.success, true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: MPSpacingStyle.signUpProcessPadding,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            onOtpCompleted: (otp) {
              setState(() {
                otpCode = otp;
              });
            },
          ),
          const SizedBox(height: MPSizes.spaceBtwSections),
          CustomResendCodeRichText(
              authController: authController, onTapFunction: onTapFunction),
          const SizedBox(height: MPSizes.spaceBtwSections),
          Obx(() => MPPrimaryButton(
                text: MPTexts.continueText,
                // isDisabled: !isEmailValid,
                isLoading: authController.isLoading.value,
                onPressed: () async {
                  await authController
                      .simulateLoading(const Duration(seconds: 1));
                  if (otpCode ==
                      localStorage.readData('emailVerificationCode')) {
                    Get.offAll(() => const PasswordResetPage());
                    getSnackBar(
                        MPTexts.changePassword, MPTexts.codeVerified, true);
                  } else {
                    getSnackBar('Incorrect PIN, Please Try Again.',
                        'Invalid PIN', false);
                  }
                },
              ))
        ]),
      ),
    );
  }
}
