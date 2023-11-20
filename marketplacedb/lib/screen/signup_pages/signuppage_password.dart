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
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(children: [
              const Center(
                child: Headertext(text: 'Get Started'),
              ),
              const MyContainer(
                headerText: "Please input a password.              ",
                text: "Password must be at least 8 characters.",
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ValidatorField(
                  controller: passwordControl,
                  hintText: 'Password',
                  labelText: 'Enter Password',
                  obscureText: true,
                  validator: (value) {
                    RegExp passwordPattern =
                        RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$');
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (!passwordPattern.hasMatch(value)) {
                      return 'Password must contain at least one number,\none uppercase letter, one lowercase letter,\nand be at least 8 characters long';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      isPasswordValid = _formKey.currentState != null &&
                          _formKey.currentState!.validate();
                    });
                  },
                ),
              )
              // MyPasswordField(
              //   controller: passwordControl,
              //   hintText: 'Password',
              //   labelText: 'Enter Password',
              //   onChanged: (value) {
              //     setState(() {
              //       isPasswordValid = _formKey.currentState != null &&
              //           _formKey.currentState!.validate();
              //     });
              //   },
              // ),
            ]),
          ),
          Positioned(
              bottom: 20, // Adjust this value as needed
              left: 0,
              right: 0,
              child: Center(
                child: LargeBlackButton(
                  text: 'Continue',
                  onPressed: () {
                    continueButton(context);
                  },
                  isDisabled: !isPasswordValid,
                ),
              ))
        ],
      ),
    );
  }
}
