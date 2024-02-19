import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/screen/sign_up_pages/controller/sign_up_pages_controller.dart';
import 'package:marketplacedb/screen/sign_up_pages/username/sign_up_page_username.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

MPLocalStorage localStorage = MPLocalStorage();

class CustomGenderSelector extends StatelessWidget {
  const CustomGenderSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpPagesController controller = SignUpPagesController.instance;
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Select Gender'),
            Row(
              children: [
                Radio(
                  value: 'Male',
                  groupValue: controller.gender.value,
                  onChanged: (value) {
                    controller.gender.value = value as String;
                  },
                ),
                const Text('Male'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 'Female',
                  groupValue: controller.gender.value,
                  onChanged: (value) {
                    controller.gender.value = value as String;
                  },
                ),
                const Text('Female'),
              ],
            ),
          ],
        ));
  }
}

class CustomBirthDateSelector extends StatelessWidget {
  const CustomBirthDateSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpPagesController controller = SignUpPagesController.instance;
    return TextField(
      readOnly: true,
      controller: controller.birthDate,
      decoration: const InputDecoration(
        icon: Icon(Icons.calendar_today_rounded),
        labelText: "Date of Birth",
      ),
      onTap: () async {
        controller.isDateValid.value = false;
        final pickedDate = await showDatePicker(
          helpText: "Select Date of Birth",
          context: Get.overlayContext!,
          initialDate: controller.currentDate,
          firstDate: DateTime(1960),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          controller.birthDate.text =
              DateFormat('yyyy-MM-dd').format(pickedDate);

          int age = controller.currentDate.year - pickedDate.year;
          if (controller.currentDate.month < pickedDate.month ||
              (controller.currentDate.month == pickedDate.month &&
                  controller.currentDate.day < pickedDate.day)) {
            age--;
          }

          if (age >= 13) {
            controller.isDateValid.value = true;
          } else {
            showDialog(
              context: Get.overlayContext!,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Invalid Date of Birth"),
                  content: const Text(
                      "You must be at least 13 years old to use this app."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
            controller.isDateValid.value = false;
          }
        }
      },
    );
  }
}

class CustomSignUpContinue extends StatelessWidget {
  const CustomSignUpContinue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpPagesController controller = SignUpPagesController.instance;
    return Obx(() => Container(
          height: MPSizes.buttonHeight,
          margin: const EdgeInsets.all(MPSizes.md),
          child: MPPrimaryButton(
            text: MPTexts.continueText,
            isDisabled: !controller.isDateValid.value,
            onPressed: () {
              localStorage.saveData('date_of_birth', controller.birthDate.text);
              localStorage.saveData('gender', controller.gender.value);
              Get.to(() => const SignUpPageUsername());
            },
          ),
        ));
  }
}
