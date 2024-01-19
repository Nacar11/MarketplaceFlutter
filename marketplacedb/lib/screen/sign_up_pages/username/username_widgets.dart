import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/sign_up_pages/password/sign_up_page_password.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

final usernameKey = GlobalKey<FormState>();

class CustomUsernameFormField extends StatelessWidget {
  const CustomUsernameFormField({
    super.key,
    required this.usernameController,
    required this.onUsernameChange,
  });

  final TextEditingController usernameController;
  final Function(bool) onUsernameChange;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: usernameKey,
      child: ValidatorField(
        prefixIcon: const Icon(Iconsax.profile_circle5),
        controller: usernameController,
        labelText: MPTexts.username,
        validator: (value) {
          RegExp oneNumber = RegExp(r'^[a-zA-Z0-9]*\d+[a-zA-Z0-9]*$');
          RegExp noSpecialChars = RegExp(MPTexts.regexNoSpecialChars);

          if (value == null || value.isEmpty) {
            return 'Username is required';
          } else if (!noSpecialChars.hasMatch(value)) {
            return 'Username should not have special characters';
          } else if (value.length < 6) {
            return 'Username should be at least 6 characters';
          } else if (!oneNumber.hasMatch(value)) {
            return 'Username must contain at least one number';
          }

          return null;
        },
        onChanged: (value) {
          bool isValid = usernameKey.currentState!.validate();
          onUsernameChange(isValid);
        },
      ),
    );
  }
}

class MPCheckBox extends StatelessWidget {
  const MPCheckBox({
    super.key,
    required this.onValueChanged,
    required this.checkBoxValue,
    required this.text,
  });

  final Function(bool) onValueChanged;
  final bool checkBoxValue;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.6,
          child: Checkbox(
            shape: const CircleBorder(),
            checkColor: Colors.white,
            activeColor: Colors.green,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            visualDensity: VisualDensity.standard,
            value: checkBoxValue,
            onChanged: (newBool) {
              onValueChanged(newBool!);
            },
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class CustomSignUpContinue extends StatelessWidget {
  const CustomSignUpContinue({
    super.key,
    required this.isUsernameValid,
    required this.usernameController,
    required this.isCheckedNewsLetters,
    required this.isCheckedPromotions,
    required this.authController,
  });

  final bool isUsernameValid;
  final TextEditingController usernameController;
  final AuthenticationController authController;
  final bool isCheckedNewsLetters;
  final bool isCheckedPromotions;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        height: MPSizes.buttonHeight,
        margin: const EdgeInsets.all(MPSizes.md),
        child: MPPrimaryButton(
          text: "Continue",
          isDisabled: !isUsernameValid,
          isLoading: authController.isLoading.value,
          onPressed: () async {
            if (isUsernameValid) {
              var response = await authController.checkUsername(
                  username: usernameController.text);
              if (response['message'] == 'Username is available') {
                MPLocalStorage localStorage = MPLocalStorage();

                localStorage.saveData(
                    'is_subscribe_to_promotions', isCheckedPromotions);
                localStorage.saveData(
                    'is_subscribe_to_newsletters', isCheckedNewsLetters);
                localStorage.saveData('username', usernameController.text);
                Get.to(() => const SignUpPagePassword());
              } else {
                errorSnackBar(context, response['message'], 'error');
              }
            }
          },
          // ),
        )));
  }
}
