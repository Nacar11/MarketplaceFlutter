// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_username.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_emailcode.dart';

import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/config/snackbar.dart';

class SignUpPageemail extends StatefulWidget {
  const SignUpPageemail({Key? key}) : super(key: key);

  @override
  State<SignUpPageemail> createState() => _SignUpPageState();
}

final authController = AuthenticationController();

class _SignUpPageState extends State<SignUpPageemail> {
  final emailcontrol = TextEditingController();

  bool isEmailValid = true;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the text field and update isNameEmpty accordingly.
  }

  void continuebutton5(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpPageEmailcode()));
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed.

    super.dispose();
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
              const Center(
                child: Headertext(text: 'Get Started'),
              ),
              const MyContainer(
                headerText: "What is your email?              ",
                text:
                    "notifications and transactions will be sent to your email",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ValidatorField(
                  controller: emailcontrol,
                  hintText: 'Email',
                  labelText: 'Enter Email',
                  obscureText: false,
                  validator: (value) {
                    RegExp emailPattern = RegExp(r'^[a-zA-Z\s.]+@gmail\.com$');
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!emailPattern.hasMatch(value)) {
                      return 'Email must be valid';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      isEmailValid = _formKey.currentState != null &&
                          _formKey.currentState!.validate();
                    });
                  },
                ),
              ),
            ])),
        Positioned(
          bottom: 20, // Adjust this value as needed
          left: 0,
          right: 0,
          child: Center(
            child: Continue(
              onTap: () async {
                if (isEmailValid) {
                  print("asd");
                  var response =
                      await authController.checkEmail(email: emailcontrol.text);

                  if (response['message'] == null) {
                    authController.storeLocalData('email', emailcontrol.text);
                    final code = await authController
                        .getEmailVerificationCode(emailcontrol.text);
                    if (code['success'] != null) {
                      String successValue = code['success'].toString();
                      print(successValue);
                      print(successValue.runtimeType);
                      final storage = GetStorage();
                      storage.write('emailVerificationCode', successValue);
                      print('ASD ${storage.read('emailVerificationCode')}');
                      continuebutton5(context);
                    } else {
                      showErrorHandlingSnackBar(
                          context,
                          "Error on Passing Verification Code, Please Try Again.",
                          'error');
                    }
                  } else {
                    final text = response['message'];
                    showErrorHandlingSnackBar(context, text, 'error');
                  }
                }
              },
              isDisabled: !isEmailValid, // Pass the isNameEmpty variable here
            ),
          ),
        )
      ]),
    );
  }
}
