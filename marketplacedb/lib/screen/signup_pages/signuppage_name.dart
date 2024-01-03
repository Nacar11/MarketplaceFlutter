// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/CustomAppBar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_birthdate.dart';
import 'package:marketplacedb/common/widgets/common_widgets/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class SignUpPageName extends StatefulWidget {
  final bool? socialLogin;

  const SignUpPageName({Key? key, this.socialLogin}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<SignUpPageName> createState() =>
      // ignore: no_logic_in_create_state
      SignUpPageNameState(socialLogin: socialLogin ?? false);
}

class SignUpPageNameState extends State<SignUpPageName> {
  final bool socialLogin;
  SignUpPageNameState({required this.socialLogin});
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final authController = AuthenticationController();
  bool isFirstNameValid = false;
  bool isLastNameValid = false;

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
    String text = ' Sign in with just a couple more steps!';
    phoneNumberVerified(context, text, 'loginsuccess');
  }

  void continueButton(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpPageBirthDate()));
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed.
    firstNameController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> firstNameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> lastNameKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const SignUpAppBar(),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: ContainerGuide(
            headerText: "Tell us about Yourself",
            text: "Help us personalize your experience by providing your name",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Form(
            key: firstNameKey,
            child: ValidatorField(
              controller: firstNameController,
              labelText: 'Enter First Name',
              obscureText: false,
              validator: (value) {
                RegExp firstNamePattern = RegExp(r'^[a-zA-Z\s]+$');
                if (value == null || value.isEmpty) {
                  return 'First Name is required';
                } else if (!firstNamePattern.hasMatch(value)) {
                  return 'First Name should not have special characters';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  isFirstNameValid = firstNameKey.currentState != null &&
                      firstNameKey.currentState!.validate();
                  print(isFirstNameValid);
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Form(
            key: lastNameKey,
            child: ValidatorField(
              controller: lastNameController,
              labelText: 'Enter Last Name',
              obscureText: false,
              validator: (value) {
                RegExp lastNamePattern = RegExp(r'^[a-zA-Z\s]+$');
                if (value == null || value.isEmpty) {
                  return 'Last Name is required';
                } else if (!lastNamePattern.hasMatch(value)) {
                  return 'Last Name should not have special characters';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  isLastNameValid = lastNameKey.currentState != null &&
                      lastNameKey.currentState!.validate();
                });
              },
            ),
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: SignUpProcessContinueFAB(
          text: "Continue",
          isDisabled: !isFirstNameValid || !isLastNameValid,
          onPressed: () {
            if (isFirstNameValid && isLastNameValid) {
              print("asd");
              authController.storeLocalData(
                  'first_name', firstNameController.text);
              authController.storeLocalData(
                  'last_name', lastNameController.text);
              continueButton(context);
            }
          },
        ),
      ),
    );
  }
}
