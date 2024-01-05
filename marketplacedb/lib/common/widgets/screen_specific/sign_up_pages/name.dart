import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/sign_up_pages/sign_up_page_birthdate.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

AuthenticationController authController = AuthenticationController.instance;
final GlobalKey<FormState> firstNameKey = GlobalKey<FormState>();
final GlobalKey<FormState> lastNameKey = GlobalKey<FormState>();
final firstNameController = TextEditingController();
final lastNameController = TextEditingController();
MPLocalStorage localStorage = MPLocalStorage();

void continueButton(BuildContext context) {
  Get.to(() => const SignUpPageBirthDate());
}

class CustomSignUpContinue extends StatelessWidget {
  const CustomSignUpContinue({
    super.key,
    required this.isFirstNameValid,
    required this.isLastNameValid,
  });

  final bool isFirstNameValid;
  final bool isLastNameValid;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(10),
      child: MPPrimaryButton(
        text: MPTexts.continueText,
        isDisabled: !isFirstNameValid || !isLastNameValid,
        onPressed: () {
          if (isFirstNameValid && isLastNameValid) {
            localStorage.saveData(
                'first_name',
                MPHelperFunctions.capitalizeFirstLetter(
                    firstNameController.text));
            print(localStorage.readData('first_name'));
            localStorage.saveData(
                'last_name',
                MPHelperFunctions.capitalizeFirstLetter(
                    lastNameController.text));
            continueButton(context);
          }
        },
      ),
    );
  }
}

class LastNameForm extends StatelessWidget {
  const LastNameForm({
    super.key,
    required this.onLastNameValidChanged,
  });

  final Function(bool) onLastNameValidChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: lastNameKey,
      child: ValidatorField(
        controller: lastNameController,
        labelText: MPTexts.lastName,
        validator: (value) {
          RegExp lastNamePattern = RegExp(r'^[a-zA-Z\s]+$');
          if (value == null || value.isEmpty) {
            return 'Last Name is required';
          } else if (!lastNamePattern.hasMatch(value)) {
            return 'Last Name should not have special characters';
          }
          return null;
        },
        onChanged: (value) {
          bool isValid = lastNameKey.currentState != null &&
              lastNameKey.currentState!.validate();
          onLastNameValidChanged(isValid);
        },
      ),
    );
  }
}

class FirstNameForm extends StatelessWidget {
  const FirstNameForm({
    super.key,
    required this.onFirstNameValidChanged,
  });

  final Function(bool) onFirstNameValidChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: firstNameKey,
      child: ValidatorField(
        controller: firstNameController,
        labelText: MPTexts.firstName,
        validator: (value) {
          RegExp firstNamePattern = RegExp(r'^[a-zA-Z\s]+$');
          if (value == null || value.isEmpty) {
            return 'First Name is required';
          } else if (!firstNamePattern.hasMatch(value)) {
            return 'First Name should not have special characters';
          }
          return null;
        },
        onChanged: (value) {
          bool isValid = firstNameKey.currentState != null &&
              firstNameKey.currentState!.validate();
          onFirstNameValidChanged(isValid);
        },
      ),
    );
  }
}
