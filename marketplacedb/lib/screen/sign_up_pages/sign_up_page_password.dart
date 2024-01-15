import 'package:flutter/material.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/CustomAppBar.dart';
import 'package:marketplacedb/common/widgets/screen_specific/sign_up_pages/password.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class SignUpPagePassword extends StatefulWidget {
  const SignUpPagePassword({Key? key}) : super(key: key);

  @override
  State<SignUpPagePassword> createState() => _SignUpPagePasswordState();
}

class _SignUpPagePasswordState extends State<SignUpPagePassword> {
  final passwordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();
  bool isPasswordValid = false;
  bool isPasswordEightCharacters = false;
  bool isPasswordOneNumber = false;
  bool isPasswordOneSpecialChar = false;
  bool passwordsMatch = false;
  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> reEnterPasswordKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    reEnterPasswordController.dispose();
    super.dispose();
  }

  void onPasswordChange(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    setState(() {
      isPasswordEightCharacters = false;
      if (password.length >= 8) {
        isPasswordEightCharacters = true;
      }
      isPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) {
        isPasswordOneNumber = true;
      }
      isPasswordOneSpecialChar = false;
      if (specialCharRegex.hasMatch(password)) {
        isPasswordOneSpecialChar = true;
      }
      isPasswordValid = isPasswordEightCharacters &&
          isPasswordOneNumber &&
          isPasswordOneSpecialChar &&
          passwordsMatch;
    });
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
            headerText: MPTexts.passwordHeaderText,
            text: MPTexts.passwordSubText,
          ),
          const SizedBox(height: MPSizes.spaceBtwSections),
          CustomPasswordFormField(
            text: MPTexts.enterPassword,
            onIfPasswordsMatch: (boolValue) {
              setState(() {
                passwordsMatch = boolValue;
              });
            },
            formKey: passwordKey,
            controller1: passwordController,
            controller2: reEnterPasswordController,
            onPasswordChange: onPasswordChange,
            passwordsMatch: passwordsMatch,
          ),
          const SizedBox(height: MPSizes.spaceBtwInputFields),
          CustomPasswordFormField(
            text: MPTexts.reEnterPassword,
            onIfPasswordsMatch: (boolValue) {
              setState(() {
                passwordsMatch = boolValue;
              });
            },
            formKey: reEnterPasswordKey,
            controller1: reEnterPasswordController,
            controller2: passwordController,
            onPasswordChange: onPasswordChange,
            passwordsMatch: passwordsMatch,
          ),
          Padding(
            padding: const EdgeInsets.only(left: MPSizes.sm),
            child: Column(children: [
              const SizedBox(height: MPSizes.spaceBtwSections),
              CustomPasswordCondition(
                  conditionBoolValue: isPasswordEightCharacters,
                  text: MPTexts.passwordEightChars),
              const SizedBox(height: MPSizes.spaceBtwInputFields),
              CustomPasswordCondition(
                  conditionBoolValue: isPasswordOneNumber,
                  text: MPTexts.passwordOneNumber),
              const SizedBox(height: MPSizes.spaceBtwInputFields),
              CustomPasswordCondition(
                  conditionBoolValue: isPasswordOneSpecialChar,
                  text: MPTexts.passwordSpecialChars),
              const SizedBox(height: MPSizes.spaceBtwInputFields),
              CustomPasswordCondition(
                  conditionBoolValue: passwordsMatch,
                  text: MPTexts.passwordsMatch)
            ]),
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomSignUpContinue(
          isPasswordValid: isPasswordValid,
          passwordController: passwordController),
    );
  }
}
