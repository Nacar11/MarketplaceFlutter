import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/sign_up_pages/code/sign_up_page_code.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

AuthenticationController authController = AuthenticationController.instance;

String phoneNumberController = '';

class CustomPhoneField extends StatelessWidget {
  final Function(String) onValidityChanged;

  const CustomPhoneField({
    Key? key,
    required this.onValidityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      invalidNumberMessage: MPTexts.invalidNumberMessage,
      decoration: const InputDecoration(
        labelText: MPTexts.phoneNo,
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      initialCountryCode: 'PH',
      onChanged: (phone) {
        onValidityChanged(phone.completeNumber);
      },
    );
  }
}

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
