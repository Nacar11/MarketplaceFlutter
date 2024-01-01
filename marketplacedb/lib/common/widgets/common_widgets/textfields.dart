import 'package:flutter/material.dart';

class ValidatorField extends StatelessWidget {
  const ValidatorField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    this.hintText,
    this.labelText,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  final bool obscureText;
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 0, 0, 0),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}

class PasswordValidatorField extends StatefulWidget {
  const PasswordValidatorField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    this.hintText,
    this.labelText,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  final bool obscureText;
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: _obscureText
                  ? const Icon(Icons.visibility_off, color: Colors.grey)
                  : const Icon(Icons.visibility, color: Colors.black)),
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 0, 0, 0),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: widget.hintText,
        ),
        validator: widget.validator,
        onChanged: widget.onChanged,
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = true,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText, // Include label text
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 0, 0, 0),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}

class Headertext extends StatelessWidget {
  final String text;

  const Headertext({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    );
  }
}

class Sidetext extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color textcolor;

  const Sidetext(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.textcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, // Use the provided onPressed function
      child: Text(
        text,

        style:
            TextStyle(color: textcolor), // Use TextStyle to set the text color
      ),
    );
  }
}

class MyText extends StatelessWidget {
  final String text;

  const MyText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
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
