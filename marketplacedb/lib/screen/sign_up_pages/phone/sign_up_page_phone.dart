// ignore_for_file: avoid_print, use_build_context_synchronously, unused_import

import 'package:flutter/material.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/screen/sign_up_pages/phone/phone_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class SignUpPagePhone extends StatefulWidget {
  const SignUpPagePhone({
    Key? key,
  }) : super(key: key);
  @override
  State<SignUpPagePhone> createState() => _SignUpPagePhoneState();
}

class _SignUpPagePhoneState extends State<SignUpPagePhone> {
  bool isPhoneValid = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PrimaryAppBarColored(title: MPTexts.getStarted),
      body: Padding(
        padding: MPSpacingStyle.signUpProcessPadding,
        child: Column(children: [
          const ContainerGuide(
            headerText: MPTexts.phoneHeaderText,
            text: MPTexts.phoneSubText,
          ),
          const SizedBox(height: MPSizes.spaceBtwSections),
          CustomPhoneField(
            onValidityChanged: (completePhoneNumber) {
              print(completePhoneNumber);
              setState(() {
                phoneNumberController = completePhoneNumber;
                isPhoneValid = completePhoneNumber.length == 13;
              });
            },
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomSignUpContinue(isPhoneValid: isPhoneValid),
    );
  }
}
