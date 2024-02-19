import 'package:flutter/material.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';

import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/name/name_widgets.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';

import 'package:marketplacedb/util/constants/app_strings.dart';

class SignUpPageName extends StatelessWidget {
  const SignUpPageName({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SignUpAppBarBackToHomeScreen(),
      body: Padding(
        padding: MPSpacingStyle.signUpProcessPadding,
        child: Column(
          children: [
            ContainerGuide(
              headerText: MPTexts.nameHeaderText,
              text: MPTexts.nameSubText,
            ),
            AnimationContainer(
              height: 0.25,
              animation: AnimationsUtils.userProfile1,
              duration: Duration(seconds: 8),
            ),
            NameFormFields(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomSignUpContinue(),
    );
  }
}
