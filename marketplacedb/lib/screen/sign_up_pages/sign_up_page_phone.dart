// ignore_for_file: avoid_print, use_build_context_synchronously, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/CustomAppBar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/common/widgets/screen_specific/sign_up_pages/phone.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/sign_up_pages/sign_up_page_code.dart';

import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class SignUpPagePhone extends StatefulWidget {
  final bool? socialLogin;
  const SignUpPagePhone({Key? key, this.socialLogin}) : super(key: key);

  @override
  State<SignUpPagePhone> createState() =>
      // ignore: no_logic_in_create_state
      _SignUpPagePhoneState(socialLogin: socialLogin ?? false);
}

AuthenticationController authController = AuthenticationController.instance;

class _SignUpPagePhoneState extends State<SignUpPagePhone> {
  final bool socialLogin;
  _SignUpPagePhoneState({required this.socialLogin});
  bool isNameEmpty = true;
  String phoneNumberController = '';
  bool isPhoneValid = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const SignUpAppBar(),
      body: Padding(
        padding: MPSpacingStyle.signUpProcessPadding,
        child: Column(children: [
          const ContainerGuide(
            headerText: MPTexts.phoneHeaderText,
            text: MPTexts.phoneSubText,
          ),
          const SizedBox(height: MPSizes.spaceBtwSections),
          CustomPhoneField(
            onChanged: (completePhoneNumber) {
              setState(() {
                print(completePhoneNumber);
                phoneNumberController = completePhoneNumber;
                isPhoneValid = completePhoneNumber.length == 13;
                print(isPhoneValid);
              });
            },
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: MPSizes.buttonHeight,
        // margin: const EdgeInsets.all(10),
        child: MPPrimaryButton(
          text: MPTexts.continueText,
          isLoading: authController.isLoading.value,
          isDisabled: !isPhoneValid,
          onPressed: () async {
            final code = await authController
                .getSMSVerificationCode(phoneNumberController);
            if (code['success'] != null) {
              String successValue = code['success'].toString();
              final storage = GetStorage();
              storage.write('SMSVerificationCode', successValue);
              authController.storeLocalData(
                  'contact_number', phoneNumberController);
              Get.to(() => const SignUpPageCode());
            } else {
              showErrorHandlingSnackBar(
                  context,
                  "Error on Passing SMS Text Verification Code, Please Try Again.",
                  'error');
            }
          },
        ),
      ),
    );
  }
}
