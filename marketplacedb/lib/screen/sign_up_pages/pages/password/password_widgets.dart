import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/screen/landing_pages/front_page/front_page_controller.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class CustomPasswordFormField extends StatelessWidget {
  const CustomPasswordFormField(
      {Key? key,
      required this.text,
      required this.controller1,
      required this.controller2,
      required this.formKey,
      required this.onPasswordChange,
      required this.passwordsMatch,
      required this.onIfPasswordsMatch})
      : super(key: key);

  final TextEditingController controller1;
  final String text;
  final TextEditingController controller2;
  final Function(bool) onIfPasswordsMatch;
  final Function(String) onPasswordChange;
  final bool passwordsMatch;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: PasswordValidatorField(
        controller: controller1,
        labelText: text,
        obscureText: true,
        onChanged: (value) {
          final passwordsMatch = value == controller2.text;
          onIfPasswordsMatch(passwordsMatch);
          onPasswordChange(value);
        },
      ),
    );
  }
}

class CustomPasswordCondition extends StatelessWidget {
  const CustomPasswordCondition({
    super.key,
    required this.conditionBoolValue,
    required this.text,
  });

  final bool conditionBoolValue;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: conditionBoolValue ? Colors.green : Colors.transparent,
                border: conditionBoolValue
                    ? Border.all(color: Colors.transparent)
                    : Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(50)),
            child: const Center(
                child: Icon(Icons.check, color: Colors.white, size: 15))),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }
}

FrontPageController authController = FrontPageController.instance;

class CustomSignUpContinue extends StatelessWidget {
  const CustomSignUpContinue({
    super.key,
    required this.isPasswordValid,
    required this.passwordController,
  });

  final bool isPasswordValid;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: 50,
          margin: const EdgeInsets.all(10),
          child: MPPrimaryButton(
            text: MPTexts.continueText,
            isLoading: authController.isLoading.value,
            isDisabled: !isPasswordValid,
            onPressed: () async {
              MPLocalStorage localStorage = MPLocalStorage();
              await localStorage.saveData('password', passwordController.text);
              await authController.register();
            },
          ),
        ));
  }
}
