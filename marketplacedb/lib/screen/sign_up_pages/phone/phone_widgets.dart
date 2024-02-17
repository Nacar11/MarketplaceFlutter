import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/screen/landing_pages/front_page/front_page_controller.dart';
import 'package:marketplacedb/screen/sign_up_pages/code/sign_up_page_code.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

FrontPageController authController = FrontPageController.instance;

String phoneNumberController = '';

class CustomSignUpContinue extends StatelessWidget {
  final bool isPhoneValid;
  const CustomSignUpContinue({
    Key? key,
    required this.isPhoneValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: MPSizes.buttonHeight,
          margin: const EdgeInsets.all(MPSizes.md),
          child: MPPrimaryButton(
              text: MPTexts.continueText,
              isLoading: authController.isLoading.value,
              isDisabled: !isPhoneValid,
              onPressed: () async {
                final code = await authController
                    .getSMSVerificationCode(phoneNumberController);
                if (code['success'] != null) {
                  String successValue = code['success'].toString();
                  MPLocalStorage localStorage = MPLocalStorage();
                  localStorage.saveData('SMSVerificationCode', successValue);
                  localStorage.saveData(
                      'contact_number', phoneNumberController);

                  Get.to(() => const SignUpPageCode());
                }
              }),
        ));
  }
}
