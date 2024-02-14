import 'package:flutter/material.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/screen/sign_up_pages/birthdate/birth_date_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class SignUpPageBirthDate extends StatefulWidget {
  const SignUpPageBirthDate({Key? key}) : super(key: key);

  @override
  State<SignUpPageBirthDate> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPageBirthDate> {
  late TextEditingController dateOfBirthController;
  DateTime? pickedDate;
  String _valueGender = "Male";
  DateTime selectedDate = DateTime(2023, 9, 22, 12, 21);
  bool isDateSelected = false;

  void handleDateSelected(DateTime? selectedDate) {
    setState(() {
      pickedDate = selectedDate;
      isDateSelected = selectedDate != null;
    });
  }

  @override
  void initState() {
    dateOfBirthController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PrimaryAppBarColored(title: MPTexts.getStarted),
      body: Padding(
        padding: MPSpacingStyle.signUpProcessPadding,
        child: Column(children: [
          const ContainerGuide(
            headerText: MPTexts.birthDateHeaderText,
            text: MPTexts.birthDateSubText,
          ),
          const SizedBox(height: MPSizes.spaceBtwSections),
          CustomGenderSelector(
            valueGender: _valueGender,
            onGenderSelected: (onGenderSelected) {
              setState(() {
                _valueGender = onGenderSelected;
              });
            },
          ),
          const SizedBox(height: MPSizes.spaceBtwSections),
          CustomBirthDateSelector(
            onDateSelected: (isValid) {
              setState(() {
                isDateSelected = isValid;
              });
            },
            dateOfBirthController: dateOfBirthController,
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomSignUpContinue(
          dateOfBirthController: dateOfBirthController,
          isDateSelected: isDateSelected,
          valueGender: _valueGender),
    );
  }
}
