// ignore_for_file: avoid_print, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/common/widgets/common_widgets/textfields.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/screen/ForgotPass/ForgotPass.dart';
import 'package:marketplacedb/screen/signin_page.dart';

import 'package:marketplacedb/controllers/authenticationController.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

final authController = AuthenticationController();

void signinbutton(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SignInPage(
            hasSnackbar: 'changePassSuccess',
          )));
}

void forgotpassbutton(BuildContext context) {
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const ForgotPassPage()));
}

class _ChangePassState extends State<ChangePass> {
  final TextEditingController passwordcontrol = TextEditingController();
  final TextEditingController newpasswordcontrol = TextEditingController();
  bool ispasswordValid = false;
  bool isnewpasswordValid = false;
  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> newpasswordKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose of the controller when no longer needed to prevent memory leaks.
    newpasswordcontrol.dispose();
    passwordcontrol.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      ),
      body: Column(
        children: [
          const Text(
            "UKAYKO.PH  ",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Form(
                  key: passwordKey,
                  child: ValidatorField(
                    controller: passwordcontrol,
                    hintText: 'Password',
                    labelText: 'Enter Password',
                    obscureText: true,
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
                    onChanged: (value) {
                      setState(() {
                        ispasswordValid = passwordKey.currentState != null &&
                            passwordKey.currentState!.validate();
                        print(ispasswordValid);
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Form(
                  key: newpasswordKey,
                  child: ValidatorField(
                    controller: newpasswordcontrol,
                    hintText: 'Confirm Password',
                    labelText: 'Re-enter Password',
                    obscureText: true,
                    validator: (value) {
                      if (value != passwordcontrol.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        isnewpasswordValid =
                            newpasswordKey.currentState != null &&
                                newpasswordKey.currentState!.validate();
                        print(isnewpasswordValid);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Obx(() {
              return Stack(
                alignment: Alignment.center,
                children: [
                  LargeBlackButton(
                    text: "Submit",
                    isDisabled: authController.isLoading.value,
                    onPressed: () async {
                      if (authController.isLoading.value) {
                        return; // Prevent further actions while loading
                      }
                      final storage = GetStorage();
                      var response = await authController.changePassword(
                        email: storage.read('email'),
                        newPassword: passwordcontrol.text.trim(),
                      );

                      if (response == 0) {
                        print("Success");
                        signinbutton(context);
                      } else {
                        final text = response;
                        showErrorHandlingSnackBar(context, text, 'error');
                      }
                    },

                    // Add any other properties or styling to the button here
                  ),
                  if (authController.isLoading.value)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey
                            .withOpacity(0.5), // Adjust the color and opacity
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust the border radius
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: const CircularProgressIndicator(),
                    ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
