import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/screen/sign_up_pages/controller/sign_up_pages_controller.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/name/sign_up_page_name.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';
import 'package:pinput/pinput.dart';

MPLocalStorage localStorage = MPLocalStorage();

RichText codeSubRichText(BuildContext context) {
  return RichText(
    text: TextSpan(
      text: MPTexts.codeSubText,
      style: Theme.of(context).textTheme.bodyMedium,
      children: <TextSpan>[
        TextSpan(
          text: '${localStorage.readData('contact_number')}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    ),
  );
}

class CustomPinInput extends StatelessWidget {
  final Function(String) onCompleted;
  const CustomPinInput({
    required this.onCompleted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
        length: 6,
        onCompleted: onCompleted,
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
    required this.onTapFunction,
  });

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
  });

  @override
  Widget build(BuildContext context) {
    SignUpPagesController controller = SignUpPagesController.instance;
    return Obx(() => Container(
          height: MPSizes.buttonHeight,
          margin: const EdgeInsets.all(MPSizes.md),
          child: MPPrimaryButton(
            text: MPTexts.continueText,
            isLoading: controller.isLoading.value,
            onPressed: () async {
              if (controller.otp ==
                  localStorage.readData('SMSVerificationCode')) {
                Get.to(() => const SignUpPageName());
                getSnackBar(MPTexts.signInCoupleMoreSteps, 'Welcome!', true);
              } else {
                getSnackBar(
                    'Incorrect PIN, Please Try Again.', 'Invalid PIN', false);
              }
            },
          ),
        ));
  }
}
