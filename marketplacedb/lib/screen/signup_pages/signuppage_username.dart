// ignore_for_file: use_build_context_synchronously, avoid_print, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/config/snackbar.dart';

import 'package:marketplacedb/screen/signup_pages/signuppage_password.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class SignUpPageUsername extends StatefulWidget {
  final String? verifySnackbar;
  const SignUpPageUsername({Key? key, this.verifySnackbar}) : super(key: key);

  @override
  State<SignUpPageUsername> createState() =>
      _SignUpPageState(verifySnackbar: verifySnackbar ?? '');
}

final authController = AuthenticationController();

class _SignUpPageState extends State<SignUpPageUsername> {
  final String verifySnackbar;
  _SignUpPageState({required this.verifySnackbar});

  final usernameControl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isUsernameValid = false;

  @override
  void initState() {
    super.initState();
    if (verifySnackbar != '') {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        switch (verifySnackbar) {
          case 'email':
            showSuccessSnackBar(
                context, "Email Successfully Verified", 'success');
            break;
          case 'text':
            showSuccessSnackBar(
                context, "Phone Number Successfully Verified", 'success');
            break;
          default:
            0;
        }
      });
    }
  }

  void showVerificationSuccessSnackBar() async {
    showSuccessSnackBar(context, "Email Successfully Verified", 'success');
  }

  void continueButton(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpPagePassword()));
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed.
    usernameControl.dispose();
    super.dispose();
  }

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
            child: Column(
              children: [
                Column(
                  children: [
                    const Center(
                      child: Headertext(text: 'Get Started'),
                    ),
                    const MyContainer(
                      headerText: "Please enter a username.              ",
                      text:
                          "This will be the primary name other users will see.",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: MyUsernameField(
                        controller: usernameControl,
                        hintText: 'Username',
                        labelText: 'Enter Username',
                        onChanged: (value) {
                          setState(() {
                            isUsernameValid = _formKey.currentState != null &&
                                _formKey.currentState!.validate();
                            print(isUsernameValid);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 20, // Adjust this value as needed
              left: 0,
              right: 0,
              child: Center(
                child: LargeBlackButton(
                  text: 'Continue',
                  onPressed: () async {
                    if (isUsernameValid) {
                      var response = await authController.checkUsername(
                          username: usernameControl.text);
                      print(response);
                      if (response['message'] == 'Username is available') {
                        authController.storeLocalData(
                            'username', usernameControl.text);
                        continueButton(context);
                      } else {
                        showErrorHandlingSnackBar(
                            context, response['message'], 'error');
                      }
                    }
                  },
                  isDisabled: !isUsernameValid,
                  isLoading: authController.isLoading.value,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyUsernameField extends StatelessWidget {
  const MyUsernameField({
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
        obscureText: false,
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
          RegExp usernamePattern = RegExp(r'^[a-zA-Z0-9]*\d+[a-zA-Z0-9]*$');

          if (value == null || value.isEmpty) {
            return 'Username is required';
          } else if (!usernamePattern.hasMatch(value)) {
            return 'Username must contain at least one number,\n and is unique';
          }

          return null;
        },
        onChanged: onChanged,
      ),
    );
  }
}
