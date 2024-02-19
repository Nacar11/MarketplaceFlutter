import 'package:flutter/material.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/birthdate/birth_date_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class SignUpPageBirthDate extends StatelessWidget {
  const SignUpPageBirthDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PrimaryAppBarColored(title: MPTexts.getStarted),
      body: Padding(
        padding: MPSpacingStyle.signUpProcessPadding,
        child: Column(
          children: [
            ContainerGuide(
              headerText: MPTexts.birthDateHeaderText,
              text: MPTexts.birthDateSubText,
            ),
            SizedBox(height: MPSizes.spaceBtwSections),
            CustomGenderSelector(),
            SizedBox(height: MPSizes.spaceBtwSections),
            CustomBirthDateSelector(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomSignUpContinue(),
    );
  }
}
