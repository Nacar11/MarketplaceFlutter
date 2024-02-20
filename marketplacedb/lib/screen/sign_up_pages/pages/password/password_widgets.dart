import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/screen/sign_up_pages/controller/sign_up_pages_controller.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

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

class CustomSignUpContinue extends StatelessWidget {
  const CustomSignUpContinue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MPLocalStorage localStorage = MPLocalStorage();
    SignUpPagesController controller = SignUpPagesController.instance;
    return Obx(() => Container(
          height: 50,
          margin: const EdgeInsets.all(10),
          child: MPPrimaryButton(
            text: MPTexts.continueText,
            isLoading: controller.isLoading.value,
            isDisabled: !controller.isPasswordEightCharacters.value ||
                !controller.isPasswordOneNumber.value ||
                !controller.isPasswordOneSpecialChar.value ||
                !controller.passwordsMatch.value,
            onPressed: () async {
              await localStorage.saveData('password', controller.password.text);
              await controller.register();
            },
          ),
        ));
  }
}
