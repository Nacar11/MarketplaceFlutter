import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/screen/sign_up_pages/controller/sign_up_pages_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/util/helpers/validators.dart';

class CustomUsernameFormField extends StatelessWidget {
  const CustomUsernameFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SignUpPagesController controller = SignUpPagesController.instance;
    return Form(
      key: controller.usernameKey,
      child: ValidatorField(
        prefixIcon: const Icon(Iconsax.profile_circle5),
        controller: controller.username,
        labelText: MPTexts.username,
        validator: (value) => MPValidator.validateUsername(
          value,
        ),
        onChanged: (value) {
          controller.isUsernameValid.value =
              controller.usernameKey.currentState!.validate() == true;
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
        Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.green,
          value: checkBoxValue,
          onChanged: (newBool) {
            onValueChanged(newBool!);
          },
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}

class CustomSignUpContinue extends StatelessWidget {
  const CustomSignUpContinue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SignUpPagesController controller = SignUpPagesController.instance;
    return Obx(() => Container(
        height: MPSizes.buttonHeight,
        margin: const EdgeInsets.all(MPSizes.md),
        child: MPPrimaryButton(
          text: "Continue",
          isDisabled:
              !controller.isUsernameValid.value || !controller.agreements.value,
          isLoading: controller.isLoading.value,
          onPressed: () async {
            await controller.checkUsername();
          },
          // ),
        )));
  }
}

class AgreementsText extends StatelessWidget {
  const AgreementsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "I agree to ", style: Theme.of(context).textTheme.labelMedium),
      TextSpan(
          text: "Privacy Policy",
          style: Theme.of(context).textTheme.labelMedium!.apply(
              color: dark ? MPColors.white : MPColors.primary,
              decoration: TextDecoration.underline,
              decorationColor: dark ? MPColors.white : MPColors.primary)),
      TextSpan(text: " and ", style: Theme.of(context).textTheme.labelMedium),
      TextSpan(
          text: "Terms of use",
          style: Theme.of(context).textTheme.labelMedium!.apply(
              color: dark ? MPColors.white : MPColors.primary,
              decoration: TextDecoration.underline,
              decorationColor: dark ? MPColors.white : MPColors.primary)),
    ]));
  }
}
