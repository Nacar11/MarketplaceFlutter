// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:get/get.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/config/snackbar.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_birthdate.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class SignUpPagename extends StatefulWidget {
  final bool? socialLogin;

  const SignUpPagename({Key? key, this.socialLogin}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<SignUpPagename> createState() =>
      // ignore: no_logic_in_create_state
      SignUpPagenameState(socialLogin: socialLogin ?? false);
}

class SignUpPagenameState extends State<SignUpPagename> {
  final bool socialLogin;
  SignUpPagenameState({required this.socialLogin});
  final firstnamecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();
  final authController = AuthenticationController();
  bool isFirstnameValid = false;
  bool isLastnameValid = false;

  bool isNameEmpty = true;

  @override
  void initState() {
    super.initState();
    if (socialLogin) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showWelcomeMessageSnackBar();
      });
    }
  }

  void showWelcomeMessageSnackBar() {
    final storage = GetStorage();
    String text =
        'Welcome, ${storage.read('email')}. Sign in with just a couple more steps!';
    socialLoginSignUp(context, text, 'loginsuccess');
  }

  void continuebutton(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpPagebirthdate()));
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed.
    firstnamecontroller.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> firstnameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> lastnameKey = GlobalKey<FormState>();

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
          Column(children: [
            const Center(
              child: Headertext(text: 'Get Started'),
            ),
            const MyContainer(
              headerText: "Hello, tell us about yourself              ",
              text: "so we can personalize your account",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Form(
                key: firstnameKey,
                child: ValidatorField(
                  controller: firstnamecontroller,
                  hintText: 'Firstname',
                  labelText: 'Enter Firstname',
                  obscureText: false,
                  validator: (value) {
                    RegExp firstnamePattern = RegExp(r'^[a-zA-Z\s]+$');
                    if (value == null || value.isEmpty) {
                      return 'First name is required';
                    } else if (!firstnamePattern.hasMatch(value)) {
                      return 'First name should not have special characters';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      isFirstnameValid = firstnameKey.currentState != null &&
                          firstnameKey.currentState!.validate();
                      print(isFirstnameValid);
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Form(
                key: lastnameKey,
                child: ValidatorField(
                  controller: lastnamecontroller,
                  hintText: 'Lastname',
                  labelText: 'Enter Lastname',
                  obscureText: false,
                  validator: (value) {
                    RegExp lastnamePattern = RegExp(r'^[a-zA-Z\s]+$');
                    if (value == null || value.isEmpty) {
                      return 'Lastname is required';
                    } else if (!lastnamePattern.hasMatch(value)) {
                      return 'Lastname should not have special characters';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      isLastnameValid = lastnameKey.currentState != null &&
                          lastnameKey.currentState!.validate();
                    });
                  },
                ),
              ),
            ),
          ]),
          Positioned(
            bottom: 20, // Adjust this value as needed
            left: 0,
            right: 0,
            child: Center(
              child: Continue(
                  onTap: () {
                    // print(isLastnameValid);
                    if (isFirstnameValid && isLastnameValid) {
                      print("asd");
                      authController.test();
                      authController.storeLocalData(
                          'first_name', firstnamecontroller.text);
                      authController.storeLocalData(
                          'last_name', lastnamecontroller.text);
                      authController.test();
                      continuebutton(context);
                    }
                  },
                  isDisabled: !isFirstnameValid || !isLastnameValid),
            ),
          )
        ],
      ),
    );
  }
}
