// ignore_for_file: avoid_print, use_build_context_synchronously, unused_import

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/config/extractedWidgets/signupProcess.dart';
import 'package:marketplacedb/config/snackbar.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_choosecode.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_code.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_password.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_username.dart';

class SignUpPagePhone extends StatefulWidget {
  final bool? socialLogin;
  const SignUpPagePhone({Key? key, this.socialLogin}) : super(key: key);

  @override
  State<SignUpPagePhone> createState() =>
      // ignore: no_logic_in_create_state
      _SignUpPagePhoneState(socialLogin: socialLogin ?? false);
}

final authController = AuthenticationController();

class _SignUpPagePhoneState extends State<SignUpPagePhone> {
  final bool socialLogin;
  _SignUpPagePhoneState({required this.socialLogin});
  // final phoneNumberController = TextEditingController();

  bool isNameEmpty = true;

  String phoneNumberController = '';

  bool isPhoneValid = false;

  @override
  void initState() {
    super.initState();
  }

  void continueButton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpPageCode()));
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const SignUpAppBar(),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: ContainerGuide(
            headerText: "Stay Connected! What's Your Phone Number?",
            text:
                "Your contact information helps us keep you updated with the latest offers and important notifications!",
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: IntlPhoneField(
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            initialCountryCode: 'PH',
            onChanged: (phone) {
              print(phone.completeNumber);
              print(phone.completeNumber.length);
              setState(() {
                phoneNumberController = phone.completeNumber;
                isPhoneValid = phone.completeNumber.length == 13;
              });
            },
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: SignUpProcessContinueFAB(
          text: "Continue",
          isLoading: authController.isLoading.value,
          isDisabled: !isPhoneValid,
          onPressed: () async {
            final code = await authController
                .getSMSVerificationCode(phoneNumberController);

            if (code['success'] != null) {
              String successValue = code['success'].toString();

              final storage = GetStorage();
              storage.write('SMSVerificationCode', successValue);
              authController.storeLocalData(
                  'contact_number', phoneNumberController);

              continueButton(context);
            } else {
              showErrorHandlingSnackBar(
                  context,
                  "Error on Passing SMS Text Verification Code, Please Try Again.",
                  'error');
            }
          },
        ),
      ),
    );
  }
}
