import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class ValidatorField extends StatelessWidget {
  const ValidatorField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    this.hintText,
    this.labelText,
    this.validator,
    this.onChanged,
    this.prefixIcon,
  }) : super(key: key);

  final bool obscureText;
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MPHelperFunctions.isDarkMode(context);
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MPSizes.borderRadiusMd),
          borderSide: BorderSide(
            color: isDarkMode
                ? MPColors.lightContainer
                : MPColors.black, // Border color in normal state
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkMode
                ? MPColors.lightContainer
                : MPColors.black, // Focused border color
          ),
          borderRadius: BorderRadius.circular(MPSizes.borderRadiusMd),
        ),
        hintText: hintText,
        errorStyle: const TextStyle(fontSize: 12.0),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}

class PasswordValidatorField extends StatefulWidget {
  const PasswordValidatorField({
    Key? key,
    required this.controller,
    this.obscureText = true,
    this.hintText,
    this.labelText,
    this.validator,
    this.onChanged,
    this.prefixIcon,
  }) : super(key: key);

  final bool obscureText;
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final Icon? prefixIcon;

  @override
  PasswordValidatorFieldState createState() => PasswordValidatorFieldState();
}

class PasswordValidatorFieldState extends State<PasswordValidatorField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MPHelperFunctions.isDarkMode(context);
    final Color iconColor =
        isDarkMode ? MPColors.lightContainer : MPColors.black;
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: _obscureText
                ? Icon(Icons.visibility_off, color: iconColor)
                : Icon(Icons.visibility, color: iconColor)),
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MPSizes.borderRadiusMd),
          borderSide: BorderSide(
            color: isDarkMode
                ? MPColors.lightContainer
                : MPColors.black, // Border color in normal state
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkMode
                ? MPColors.lightContainer
                : MPColors.black, // Focused border color
          ),
          borderRadius: BorderRadius.circular(MPSizes.borderRadiusMd),
        ),
        hintText: widget.hintText,
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}

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
        onChanged(phone.completeNumber);
      },
    );
  }
}

class UnderlineTextField extends StatelessWidget {
  const UnderlineTextField(
      {Key? key,
      required this.controller,
      this.hintText,
      this.labelText,
      this.obscureText = false,
      this.padding // Should default to false for plain text input
      })
      : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText, // You can provide an optional label
          border: const UnderlineInputBorder(), // Add an underline border
        ),
      ),
    );
  }
}
