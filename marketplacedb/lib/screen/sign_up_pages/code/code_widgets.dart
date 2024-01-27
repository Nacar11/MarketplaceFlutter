import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/sign_up_pages/name/sign_up_page_name.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';
import 'package:pinput/pinput.dart';

MPLocalStorage localStorage = MPLocalStorage();
String contactNumber = localStorage.readData('contact_number');

RichText codeSubRichText(BuildContext context) {
  return RichText(
    text: TextSpan(
      text: MPTexts.codeSubText,
      style: Theme.of(context).textTheme.bodyMedium,
      children: <TextSpan>[
        TextSpan(
          text: contactNumber,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    ),
  );
}

class CustomPinInput extends StatelessWidget {
  final Function(String) onOtpCompleted;
  const CustomPinInput({
    required this.onOtpCompleted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
        length: 6,
        onCompleted: (code) {
          onOtpCompleted(code);
        },
        defaultPinTheme: PinTheme(
            width: MPSizes.buttonWidth,
            height: MPSizes.buttonHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MPSizes.buttonRadius),
                border: Border.all(color: MPColors.buttonPrimary))));
  }
}

class CustomDifferentNumberRichText extends StatelessWidget {
  const CustomDifferentNumberRichText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: MPTexts.differentNumberText1,
        style: Theme.of(context).textTheme.bodyMedium,
        children: <TextSpan>[
          TextSpan(
            text: MPTexts.differentNumberText2,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: MPColors.primary),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                Navigator.of(context).pop();
              },
          ),
        ],
      ),
    );
  }
}

class CustomResendCodeRichText extends StatelessWidget {
  const CustomResendCodeRichText({
    super.key,
    required this.authController,
    required this.onTapFunction,
  });

  final AuthenticationController authController;
  final Function onTapFunction;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: MPTexts.resendCodeText1,
        style: Theme.of(context).textTheme.bodyMedium,
        children: <TextSpan>[
          TextSpan(
            text: MPTexts.resendCodeText2,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: MPColors.primary),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                onTapFunction();
              },
          ),
        ],
      ),
    );
  }
}

class CustomSignUpContinue extends StatelessWidget {
  const CustomSignUpContinue({
    super.key,
    required this.authController,
    required this.otpCode,
  });
  final AuthenticationController authController;
  final String otpCode;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: MPSizes.buttonHeight,
          margin: const EdgeInsets.all(MPSizes.md),
          child: MPPrimaryButton(
            text: MPTexts.continueText,
            isLoading: authController.isLoading.value,
            onPressed: () async {
              if (otpCode == localStorage.readData('SMSVerificationCode')) {
                Get.offAll(() => const SignUpPageName());
              } else {
                // showErrorHandlingSnackBar(
                //     context, "Incorrect PIN, Please try again.", 'error');
                errorSnackBar(
                    context, 'Incorrect PIN, Please Try Again.', 'Invalid PIN');
              }
            },
          ),
        ));
  }
}
