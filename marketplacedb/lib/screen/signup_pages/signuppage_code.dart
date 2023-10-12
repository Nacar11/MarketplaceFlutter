import 'package:flutter/material.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_email.dart';
import 'package:marketplacedb/config/textfields.dart';

class SignUpPagecode extends StatefulWidget {
  const SignUpPagecode({Key? key}) : super(key: key);

  @override
  State<SignUpPagecode> createState() => SignUpPageCodeState();
}

class SignUpPageCodeState extends State<SignUpPagecode> {
  final codeControl = TextEditingController();
  bool isCodeValid = true;

  void continueButton(BuildContext context) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      // Handle code validation logic here
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SignUpPageemail()));
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        appBar: AppBar(
          title: const Text("Sign Up"),
          backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        ),
        body: Stack(children: [
          Form(
              key: _formKey,
              child: Column(children: [
                Column(children: [
                  const Center(
                    child: Headertext(text: 'Get Started'),
                  ),
                  const MyContainer(
                    headerText: "Enter the code              ",
                    text: "We've sent a 6-digit code to your number",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyCodeField(
                    controller: codeControl,
                    hintText: 'Code',
                    labelText: 'Enter Code',
                    onChanged: (value) {
                      setState(() {
                        isCodeValid = _formKey.currentState != null &&
                            _formKey.currentState!.validate();
                      });
                    },
                  ),
                ])
              ])),
          Positioned(
              bottom: 20, // Adjust this value as needed
              left: 0,
              right: 0,
              child: Center(
                child: Continue(
                  onTap: () {
                    continueButton(context);
                  },
                  isDisabled: !isCodeValid,
                ),
              ))
        ]));
  }
}

class MyCodeField extends StatelessWidget {
  const MyCodeField({
    Key? key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: false, // Not an obscured field
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
        validator: (value) {
          RegExp codePattern = RegExp(r'^\d{6}$');

          if (value == null || value.isEmpty) {
            return 'Code is required';
          } else if (!codePattern.hasMatch(value)) {
            return 'Code must contain 6 digits';
          }

          return null;
        },
        onChanged: onChanged,
      ),
    );
  }
}
