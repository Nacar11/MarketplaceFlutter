// ignore_for_file: unused_element, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:get/get.dart';

import 'package:marketplacedb/screen/signin_page.dart';
import 'package:marketplacedb/common/widgets/common_widgets/textfields.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_code.dart';

void signUpbutton(BuildContext context, bool? welcomeMessage) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const Navigation(hasSnackbar: 'welcomeMessage')));
}

class SignUpPageChoosecode extends StatefulWidget {
  const SignUpPageChoosecode({Key? key}) : super(key: key);

  @override
  State<SignUpPageChoosecode> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPageChoosecode> {
  String ischeckedType = '';

  bool isNameEmpty = true;

  void continuebutton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpPageCode()));
  }

  @override
  void initState() {
    super.initState();
    // Listen for changes in the text field and update isNameEmpty accordingly.

    @override
    void dispose() {
      // Dispose the controller when the widget is removed.
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const ContainerGuide(
              headerText:
                  "We will send you a code to confirm registration              ",
              text: "would you like it via Email or Phone?",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: "Email",
                        groupValue: ischeckedType,
                        onChanged: (newValue) {
                          setState(() {
                            ischeckedType = newValue!;
                          });
                        },
                      ),
                      const Text('Email'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: "Phone",
                        groupValue: ischeckedType,
                        onChanged: (newValue) {
                          setState(() {
                            ischeckedType = newValue!;
                          });
                        },
                      ),
                      const Text('Phone'),
                    ],
                  ),
                ],
              ),
            ),
          ]),
          Obx(() => Positioned(
              bottom: 20, // Adjust this value as needed
              left: 0,
              right: 0,
              child: LargeBlackButton(
                  isDisabled: ischeckedType == '',
                  isLoading: authController.isLoading.value,
                  text: "Continue",
                  onPressed: () async {
                    if (ischeckedType == "Email") {
                      final storage = GetStorage();
                      final code = await authController
                          .getEmailVerificationCode(storage.read('email'));

                      if (code['success'] != null) {
                        String successValue = code['success'].toString();

                        storage.write('emailVerificationCode', successValue);
                        storage.write('verifySnackbar', ischeckedType);
                        print(storage.read('verifySnackbar'));
                      }
                      continuebutton(context);
                    } else if (ischeckedType == "Phone") {
                      final storage = GetStorage();
                      print(storage.read('contact_number'));

                      final code = await authController.getSMSVerificationCode(
                          storage.read('contact_number'));
                      if (code['success'] != null) {
                        String successValue = code['success'].toString();
                        storage.write('SMSVerificationCode', successValue);
                        storage.write('verifySnackbar', ischeckedType);
                      }
                      continuebutton(context);
                    }
                  })))
        ],
      ),
    );
  }
}
