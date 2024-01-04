import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class CustomPhoneField extends StatelessWidget {
  final Function(String) onChanged;

  const CustomPhoneField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      invalidNumberMessage: MPTexts.invalidNumberMessage,
      decoration: const InputDecoration(
        labelText: MPTexts.phoneNo,
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      initialCountryCode: 'PH',
      onChanged: (phone) {
        onChanged(phone
            .completeNumber); // Pass the complete phone number back to the parent widget
      },
    );
  }
}
