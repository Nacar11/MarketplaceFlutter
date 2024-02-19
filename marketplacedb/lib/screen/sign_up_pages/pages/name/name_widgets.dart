import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/screen/sign_up_pages/controller/sign_up_pages_controller.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/birthdate/sign_up_page_birthdate.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/util/helpers/validators.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class CustomSignUpContinue extends StatelessWidget {
  const CustomSignUpContinue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SignUpPagesController controller = SignUpPagesController.instance;
    MPLocalStorage localStorage = MPLocalStorage();
    return Obx(() => Container(
          height: MPSizes.buttonHeight,
          margin: const EdgeInsets.all(MPSizes.md),
          child: MPPrimaryButton(
            text: MPTexts.continueText,
            isDisabled: !controller.isFirstNameValid.value ||
                !controller.isLastNameValid.value,
            onPressed: () {
              localStorage.saveData(
                  'first_name',
                  MPHelperFunctions.capitalizeFirstLetter(
                      controller.firstName.text));
              localStorage.saveData(
                  'last_name',
                  MPHelperFunctions.capitalizeFirstLetter(
                      controller.lastName.text));
              Get.to(() => const SignUpPageBirthDate());
            },
          ),
        ));
  }
}

class NameFormFields extends StatelessWidget {
  const NameFormFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpPagesController controller = SignUpPagesController.instance;
    return Column(children: [
      Form(
          key: controller.firstNameKey,
          child: ValidatorField(
            controller: controller.firstName,
            labelText: MPTexts.firstName,
            validator: (value) => MPValidator.validateNames(
              value,
              MPTexts.firstName,
            ),
            onChanged: (value) {
              controller.isFirstNameValid.value =
                  controller.firstNameKey.currentState!.validate() == true;
            },
          )),
      const SizedBox(height: MPSizes.spaceBtwInputFields),
      Form(
        key: controller.lastNameKey,
        child: ValidatorField(
          controller: controller.lastName,
          labelText: MPTexts.lastName,
          validator: (value) => MPValidator.validateNames(
            value,
            MPTexts.lastName,
          ),
          onChanged: (value) {
            controller.isLastNameValid.value =
                controller.lastNameKey.currentState!.validate() == true;
          },
        ),
      )
    ]);
  }
}
