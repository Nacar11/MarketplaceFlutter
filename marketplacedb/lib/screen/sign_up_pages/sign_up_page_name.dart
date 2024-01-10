import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';

import 'package:marketplacedb/common/widgets/common_widgets/CustomAppBar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/common/widgets/screen_specific/sign_up_pages/name.dart';

import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

import '../../controllers/authenticationController.dart';

class SignUpPageName extends StatefulWidget {
  const SignUpPageName({Key? key}) : super(key: key);

  @override
  State<SignUpPageName> createState() => SignUpPageNameState();
}

class SignUpPageNameState extends State<SignUpPageName> {
  final authController = Get.put(AuthenticationController());
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  bool isFirstNameValid = false;
  bool isLastNameValid = false;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showWelcomeMessageSnackBar();
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void showWelcomeMessageSnackBar() {
    phoneNumberVerified(context, MPTexts.signInCoupleMoreSteps, 'loginsuccess');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const SignUpAppBarBackToHomeScreen(),
      body: Padding(
        padding: MPSpacingStyle.signUpProcessPadding,
        child: Column(children: [
          const ContainerGuide(
            headerText: MPTexts.nameHeaderText,
            text: MPTexts.nameSubText,
          ),
          const SizedBox(height: MPSizes.spaceBtwInputFields),
          const UserProfileAnimation(),
          const SizedBox(height: MPSizes.spaceBtwInputFields),
          NameFormFields(
            firstNameController: firstNameController,
            lastNameController: lastNameController,
            onFirstNameValidChanged: (isValid) {
              setState(() {
                isFirstNameValid = isValid;
              });
            },
            onLastNameValidChanged: (isValid) {
              setState(() {
                isLastNameValid = isValid;
              });
            },
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomSignUpContinue(
          firstNameController: firstNameController,
          lastNameController: lastNameController,
          isFirstNameValid: isFirstNameValid,
          isLastNameValid: isLastNameValid),
    );
  }
}
