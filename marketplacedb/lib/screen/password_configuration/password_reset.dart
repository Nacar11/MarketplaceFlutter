import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/screen/sign_up_pages/password/password_widgets.dart';
import 'package:marketplacedb/screen/landing_pages/front_page/front_page_controller.dart';
import 'package:marketplacedb/screen/password_configuration/change_success.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  State<PasswordResetPage> createState() => PasswordResetPagePageState();
}

class PasswordResetPagePageState extends State<PasswordResetPage> {
  String? otpCode;
  FrontPageController authController = FrontPageController.instance;
  bool isCodeValid = true;
  MPLocalStorage localStorage = MPLocalStorage();

  late TextEditingController passwordController;
  late TextEditingController reEnterPasswordController;
  bool isPasswordValid = false;
  bool isPasswordEightCharacters = false;
  bool isPasswordOneNumber = false;
  bool isPasswordOneSpecialChar = false;
  bool passwordsMatch = false;
  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> reEnterPasswordKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    reEnterPasswordController = TextEditingController();
  }

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
        appBar: const AppBarBackToHomeScreen(),
        body: Padding(
          padding: MPSpacingStyle.signUpProcessPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MPTexts.resetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: MPSizes.spaceBtwItems),
              Text(
                MPTexts.passwordSubText,
                style: Theme.of(context).textTheme.labelLarge,
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
                      text: MPTexts.passwordsMatch),
                  const SizedBox(height: MPSizes.spaceBtwSections),
                  Obx(() => MPPrimaryButton(
                        text: MPTexts.continueText,
                        isDisabled: !isPasswordValid,
                        isLoading: authController.isLoading.value,
                        onPressed: () async {
                          // print(localStorage
                          //     .readData('emailResetPassword')
                          //     .runtimeType);
                          // print(
                          //     '----------------------------------------------');
                          // print(passwordController.text.trim().runtimeType);
                          var response = await authController.changePassword(
                            email: localStorage.readData('emailResetPassword'),
                            newPassword: passwordController.text.trim(),
                          );
                          if (response['message'] ==
                              'Password changed successfully') {
                            Get.offAll(() => const PasswordChangeSuccessPage());
                          } else {
                            final text = response['message'];
                            getSnackBar(text, 'error', false);
                          }
                        },
                      ))
                ]),
              ),
            ],
          ),
        ));
  }
}
