import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/birthdate/sign_up_page_birthdate.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

MPLocalStorage localStorage = MPLocalStorage();

class CustomSignUpContinue extends StatelessWidget {
  const CustomSignUpContinue({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.isFirstNameValid,
    required this.isLastNameValid,
  });

  final bool isFirstNameValid;
  final bool isLastNameValid;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MPSizes.buttonHeight,
      margin: const EdgeInsets.all(MPSizes.md),
      child: MPPrimaryButton(
        text: MPTexts.continueText,
        isDisabled: !isFirstNameValid || !isLastNameValid,
        onPressed: () {
          if (isFirstNameValid && isLastNameValid) {
            localStorage.saveData(
                'first_name',
                MPHelperFunctions.capitalizeFirstLetter(
                    firstNameController.text));
            localStorage.saveData(
                'last_name',
                MPHelperFunctions.capitalizeFirstLetter(
                    lastNameController.text));
            Get.to(() => const SignUpPageBirthDate());
          }
        },
      ),
    );
  }
}

final firstNameFormKey = GlobalKey<FormState>();
final lastNameFormKey = GlobalKey<FormState>();

class NameFormFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final Function(bool) onFirstNameValidChanged;
  final Function(bool) onLastNameValidChanged;

  const NameFormFields({
    Key? key,
    required this.onFirstNameValidChanged,
    required this.onLastNameValidChanged,
    required this.firstNameController,
    required this.lastNameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: firstNameFormKey,
          child: ValidatorField(
            controller: firstNameController,
            labelText: MPTexts.firstName,
            validator: (value) {
              RegExp firstNamePattern =
                  RegExp(MPTexts.regexNoSpecialCharsAndNumbers);
              if (value == null || value.isEmpty) {
                return MPTexts.firstNameRequired;
              } else if (!firstNamePattern.hasMatch(value)) {
                return MPTexts.firstNameNoSpecialChars;
              }
              return null;
            },
            onChanged: (value) {
              firstNameFormKey.currentState!.validate();
              onFirstNameValidChanged(
                  firstNameFormKey.currentState!.validate());
            },
          ),
        ),
        const SizedBox(height: MPSizes.spaceBtwInputFields),
        Form(
          key: lastNameFormKey,
          child: ValidatorField(
            controller: lastNameController,
            labelText: MPTexts.lastName,
            validator: (value) {
              RegExp lastNamePattern = RegExp(MPTexts.regexNoSpecialChars);
              if (value == null || value.isEmpty) {
                return MPTexts.lastNameRequired;
              } else if (!lastNamePattern.hasMatch(value)) {
                return MPTexts.lastNameNoSpecialChars;
              }
              return null;
            },
            onChanged: (value) {
              bool isValid = value.isNotEmpty &&
                  lastNameController.text.trim().isNotEmpty &&
                  lastNameFormKey.currentState!.validate();
              onLastNameValidChanged(isValid);
            },
          ),
        ),
      ],
    );
  }
}
