// ignore_for_file: use_build_context_synchronously, avoid_print, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/screen/sign_up_pages/username/username_widgets.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class SignUpPageUsername extends StatefulWidget {
  const SignUpPageUsername({Key? key}) : super(key: key);

  @override
  State<SignUpPageUsername> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPageUsername> {
  AuthenticationController authController = AuthenticationController.instance;
  bool isCheckedPromotions = false;
  bool isCheckedNewsLetters = false;

  late TextEditingController usernameController;

  bool isUsernameValid = false;

  @override
  void initState() {
    usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const SignUpAppBar(),
      body: Padding(
        padding: MPSpacingStyle.signUpProcessPadding,
        child: Column(
          children: [
            const ContainerGuide(
                headerText: MPTexts.usernameHeaderText,
                text: MPTexts.usernameSubText),
            const SizedBox(height: MPSizes.spaceBtwSections),
            CustomUsernameFormField(
              usernameController: usernameController,
              onUsernameChange: (isValid) {
                setState(() {
                  isUsernameValid = isValid;
                });
              },
            ),
            const SizedBox(height: MPSizes.spaceBtwSections),
            MPCheckBox(
              text: 'Subscribe to Marketplace Promotions',
              checkBoxValue: isCheckedPromotions,
              onValueChanged: (newBool) {
                setState(() {
                  isCheckedPromotions = newBool;

                  print(isCheckedPromotions);
                });
              },
            ),
            const SizedBox(height: MPSizes.spaceBtwInputFields),
            MPCheckBox(
              text: 'Subscribe to Marketplace Newsletters',
              checkBoxValue: isCheckedNewsLetters,
              onValueChanged: (newBool) {
                setState(() {
                  isCheckedNewsLetters = newBool;

                  print(isCheckedNewsLetters);
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomSignUpContinue(
          isCheckedNewsLetters: isCheckedNewsLetters,
          isCheckedPromotions: isCheckedPromotions,
          isUsernameValid: isUsernameValid,
          usernameController: usernameController,
          authController: authController),
    );
  }
}
