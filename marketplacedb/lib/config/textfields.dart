import 'package:flutter/material.dart';

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
