import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';

import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/screen/sign_up_pages/name/name_widgets.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';

import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

import '../../../controllers/authenticationController.dart';

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
      getSnackBar(MPTexts.signInCoupleMoreSteps, 'Welcome!', true);
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
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
          const AnimationContainer(
              animation: AnimationsUtils.userProfile1,
              duration: Duration(seconds: 2)),
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
