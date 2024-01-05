import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';

import 'package:marketplacedb/common/widgets/common_widgets/CustomAppBar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/common/widgets/screen_specific/sign_up_pages/name.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class SignUpPageName extends StatefulWidget {
  const SignUpPageName({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpPageName> createState() => SignUpPageNameState();
}

class SignUpPageNameState extends State<SignUpPageName> {
  bool isFirstNameValid = false;
  bool isLastNameValid = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showWelcomeMessageSnackBar();
    });
  }

  void showWelcomeMessageSnackBar() {
    String text = ' Sign in with just a couple more steps!';
    phoneNumberVerified(context, text, 'loginsuccess');
  }

  @override
  void dispose() {
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
            headerText: MPTexts.nameHeaderText,
            text: MPTexts.nameSubText,
          ),
          const SizedBox(height: MPSizes.spaceBtwInputFields),
          Lottie.asset(
            AnimationsUtils.userProfile1,
            width: MPHelperFunctions.screenWidth() * 0.6,
            height: MPHelperFunctions.screenHeight() * 0.15,
          ),
          const SizedBox(height: MPSizes.spaceBtwInputFields),
          FirstNameForm(
            onFirstNameValidChanged: (isValid) {
              setState(() {
                isFirstNameValid = isValid;
                print(isValid);
              });
            },
          ),
          const SizedBox(height: MPSizes.spaceBtwInputFields),
          LastNameForm(
            onLastNameValidChanged: (isValid) {
              setState(() {
                isLastNameValid = isValid;
                print(isValid);
              });
            },
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomSignUpContinue(
          isFirstNameValid: isFirstNameValid, isLastNameValid: isLastNameValid),
    );
  }
}
