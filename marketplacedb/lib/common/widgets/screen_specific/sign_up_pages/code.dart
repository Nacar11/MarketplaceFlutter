import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/sign_up_pages/sign_up_page_name.dart';
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

String? otpCode;
AuthenticationController authController = AuthenticationController.instance;

class CustomPinInput extends StatelessWidget {
  const CustomPinInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
        length: 6,
        onCompleted: (code) {
          print(code);
          otpCode = code;
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
  });

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
                final code =
                    await authController.getSMSVerificationCode(contactNumber);
                if (code['success'] != null) {
                  String successValue = code['success'].toString();
                  localStorage.saveData('SMSVerificationCode', successValue);
                  showSuccessSnackBar(
                      context, "OTP successfully Resent", 'Success');
                }
              },
          ),
        ],
      ),
    );
  }
}

void continueButton(BuildContext context) {
  Get.to(() => const SignUpPageName());
}

class CustomSignUpContinue extends StatelessWidget {
  const CustomSignUpContinue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(10),
      child: MPPrimaryButton(
        text: MPTexts.continueText,
        isLoading: authController.isLoading.value,
        onPressed: () async {
          if (otpCode == localStorage.readData('SMSVerificationCode')) {
            continueButton(context);
          } else {
            showErrorHandlingSnackBar(
                context, "Incorrect PIN, Please try again.", 'error');
          }
        },
      ),
    );
  }
}
