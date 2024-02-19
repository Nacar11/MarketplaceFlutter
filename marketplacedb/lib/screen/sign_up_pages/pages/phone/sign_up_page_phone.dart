import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/screen/sign_up_pages/controller/sign_up_pages_controller.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/phone/phone_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class SignUpPagePhone extends StatelessWidget {
  const SignUpPagePhone({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpPagesController());
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
            onChanged: (completePhoneNumber) {
              controller.phoneNumber.text = completePhoneNumber;
              controller.isPhoneValid.value = completePhoneNumber.length == 13;
            },
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const CustomSignUpContinue(),
    );
  }
}
