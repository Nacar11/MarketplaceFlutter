// ignore_for_file: avoid_print, use_build_context_synchronously, unused_import

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/config/snackbar.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_code.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_password.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_username.dart';

class SignUpPagephone extends StatefulWidget {
  const SignUpPagephone({Key? key}) : super(key: key);

  @override
  State<SignUpPagephone> createState() => _SignUpPageState();
}

final authController = AuthenticationController();

class _SignUpPageState extends State<SignUpPagephone> {
  final phonecontrol = TextEditingController();

  bool isNameEmpty = true;

  // Define a list of country codes
  List<String> countryCodes = ['+63']; // Add more codes as needed
  String selectedCountryCode = '+63'; // Set a default value
  bool isPhoneValid = true;

  @override
  void initState() {
    super.initState();
  }

  void continuebutton3(BuildContext context) {
    final storage = GetStorage();
    if (storage.read('signInMethod') != null) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SignUpPageUsername()));
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SignUpPagecode()));
    }
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
                headerText: "What is your phone number?              ",
                text: "A verification will be sent to your number",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    // Dropdown for country codes
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: selectedCountryCode,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCountryCode = newValue!;
                          });
                        },
                        items: countryCodes.map((String code) {
                          return DropdownMenuItem<String>(
                            value: code,
                            child: Text(code),
                          );
                        }).toList(),
                      ),
                    ),
                    // Phone number text field
                    Expanded(
                      child: ValidatorField(
                        controller: phonecontrol,
                        hintText: 'Phone Number',
                        labelText: 'Enter Phone Number',
                        obscureText: false,
                        validator: (value) {
                          RegExp phonePattern = RegExp(r'^9\d{9}$');
                          if (value == null || value.isEmpty) {
                            return 'Phone Number is required';
                          } else if (!phonePattern.hasMatch(value)) {
                            return 'Please Enter A Valid Phone Number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            isPhoneValid = _formKey.currentState != null &&
                                _formKey.currentState!.validate();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Positioned(
              bottom: 20, // Adjust this value as needed
              left: 0,
              right: 0,
              child: Center(
                child: Continue(
                  onTap: () async {
                    // final code = await authController
                    //     .getSMSVerificationCode("+63${phonecontrol.text}");
                    // if (code['success'] != null) {
                    //   String successValue = code['success'].toString();

                    final storage = GetStorage();
                    // storage.write('SMSVerificationCode', successValue);
                    authController.storeLocalData(
                        'contact_number', "+63${phonecontrol.text}");
                    print(storage.read('contact_number'));
                    continuebutton3(context);
                    // } else {
                    //   showErrorHandlingSnackBar(
                    //       context,
                    //       "Error on Passing SMS Text Verification Code, Please Try Again.",
                    //       'error');
                    // }
                  },
                  isDisabled: !isPhoneValid,
                ),
              ))
        ]));
  }
}
