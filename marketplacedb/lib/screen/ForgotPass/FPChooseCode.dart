// ignore_for_file: unused_element, use_build_context_synchronously, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/screen/ForgotPass/FPCode.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class FPChoosecode extends StatefulWidget {
  const FPChoosecode({Key? key}) : super(key: key);

  @override
  State<FPChoosecode> createState() => _FPChoosecodeState();
}

final authController = AuthenticationController();

class _FPChoosecodeState extends State<FPChoosecode> {
  String ischeckedType = '';

  bool isNameEmpty = true;

  void continuebutton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const FPCode()));
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
        title: const Text("Forgot Password"),
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      ),
      body: Stack(
        children: [
          Column(children: [
            const Center(
              child: Headertext(text: 'Forgot Password'),
            ),
            const MyContainer(
              headerText:
                  "We will send you a code to confirm Change Password              ",
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
          Positioned(
              bottom: 20, // Adjust this value as needed
              left: 0,
              right: 0,
              child: LargeBlackButton(
                  text: "Continue",
                  onPressed: () async {
                    if (ischeckedType == "Email") {
                      final storage = GetStorage();
                      final code = await authController
                          .getEmailVerificationCode(storage.read('email'));
                      if (code['success'] != null) {
                        String successValue = code['success'].toString();

                        storage.write('emailVerificationCode', successValue);
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
                      }
                      continuebutton(context);
                    }
                  }))
        ],
      ),
    );
  }
}
