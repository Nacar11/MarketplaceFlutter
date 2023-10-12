import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_promotions.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class SignUpPagePassword extends StatefulWidget {
  const SignUpPagePassword({Key? key}) : super(key: key);

  @override
  State<SignUpPagePassword> createState() => _SignUpPagePasswordState();
}

final authController = AuthenticationController();

class _SignUpPagePasswordState extends State<SignUpPagePassword> {
  final passwordControl = TextEditingController();
  bool isPasswordValid = true; // Add a new variable for password validity

  void continueButton(BuildContext context) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      authController.storeLocalData('password', passwordControl.text);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpPagepromotion()),
      );
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Column(
              children: [
                const Center(
                  child: Headertext(text: 'Get Started'),
                ),
                const MyContainer(
                  headerText: "Please input a password.              ",
                  text: "Password must be at least 8 characters.",
                ),
                const SizedBox(
                  height: 20,
                ),
                MyPasswordField(
                  controller: passwordControl,
                  hintText: 'Password',
                  labelText: 'Enter Password',
                  onChanged: (value) {
                    setState(() {
                      isPasswordValid = _formKey.currentState != null &&
                          _formKey.currentState!.validate();
                    });
                  },
                ),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Continue(
                              onTap: () {
                                continueButton(context);
                              },
                              isDisabled: !isPasswordValid,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyPasswordField extends StatelessWidget {
  const MyPasswordField({
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
        obscureText: true,
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
          RegExp passwordPattern =
              RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$');

          if (value == null || value.isEmpty) {
            return 'Password is required';
          } else if (!passwordPattern.hasMatch(value)) {
            return 'Password must contain at least one number, one uppercase letter, one lowercase letter, and be at least 8 characters long';
          }

          return null;
        },
        onChanged: onChanged,
      ),
    );
  }
}
