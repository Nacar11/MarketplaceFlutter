import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/screen/sign_up_pages/sign_up_page_username.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

MPLocalStorage localStorage = MPLocalStorage();

class CustomGenderSelector extends StatelessWidget {
  final String valueGender;
  final Function(String) onGenderSelected;

  const CustomGenderSelector({
    Key? key,
    required this.valueGender,
    required this.onGenderSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('Select Gender'),
        Row(
          children: [
            Radio(
              value: 'Male',
              groupValue: valueGender,
              onChanged: (value) {
                onGenderSelected(value as String);
              },
            ),
            const Text('Male'),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 'Female',
              groupValue: valueGender,
              onChanged: (value) {
                onGenderSelected(value as String);
              },
            ),
            const Text('Female'),
          ],
        ),
      ],
    );
  }
}

class CustomBirthDateSelector extends StatelessWidget {
  final Function(bool) onDateSelected;

  final TextEditingController dateOfBirthController;

  const CustomBirthDateSelector({
    Key? key,
    required this.onDateSelected,
    required this.dateOfBirthController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true, // Disable text input
      controller: dateOfBirthController,
      decoration: const InputDecoration(
        icon: Icon(Icons.calendar_today_rounded),
        labelText: "Date of Birth",
      ),
      onTap: () async {
        final currentDate = DateTime.now();
        final pickedDate = await showDatePicker(
          helpText: "Select Date of Birth",
          context: context,
          initialDate: currentDate,
          firstDate: DateTime(1960),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          dateOfBirthController.text =
              DateFormat('yyyy-MM-dd').format(pickedDate);

          int age = currentDate.year - pickedDate.year;
          if (currentDate.month < pickedDate.month ||
              (currentDate.month == pickedDate.month &&
                  currentDate.day < pickedDate.day)) {
            age--;
          }

          if (age >= 13) {
            onDateSelected(true);
          } else {
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
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
            onDateSelected(false);
          }
        }
      },
    );
  }
}

class CustomSignUpContinue extends StatelessWidget {
  const CustomSignUpContinue({
    Key? key,
    required this.isDateSelected,
    required this.valueGender,
    required this.dateOfBirthController,
  }) : super(key: key);

  final bool isDateSelected;
  final String valueGender;
  final TextEditingController dateOfBirthController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MPSizes.buttonHeight,
      margin: const EdgeInsets.all(MPSizes.md),
      child: MPPrimaryButton(
        text: MPTexts.continueText,
        isDisabled: !isDateSelected || valueGender.isEmpty,
        onPressed: () {
          if (isDateSelected && valueGender != '') {
            localStorage.saveData('date_of_birth', dateOfBirthController.text);
            localStorage.saveData('gender', valueGender);
            Get.to(() => const SignUpPageUsername());
          }
        },
      ),
    );
  }
}
