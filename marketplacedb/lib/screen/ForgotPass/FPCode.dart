// ignore_for_file: avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/textfields.dart';
import 'package:marketplacedb/screen/ForgotPass/ChangePass.dart';

class FPCode extends StatefulWidget {
  const FPCode({Key? key}) : super(key: key);

  @override
  State<FPCode> createState() => FPCodeState();
}

class FPCodeState extends State<FPCode> {
  final codeControl = TextEditingController();
  bool isCodeValid = true;

  void continueButton(BuildContext context) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      // Handle code validation logic here
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const ChangePass()));
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        appBar: AppBar(
          title: const Text("Forgot Password"),
          backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        ),
        body: Stack(children: [
          Form(
              key: _formKey,
              child: Column(children: [
                Column(children: [
                  const Center(
                    child: Headertext(text: 'Change Password'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ContainerGuide(
                      headerText: "Enter the code              ",
                      text: "We've sent a 6-digit code to your e-mail/phone",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: MyCodeField(
                      controller: codeControl,
                      hintText: 'Code',
                      labelText: 'Enter Code',
                      onChanged: (value) {
                        setState(() {
                          isCodeValid = _formKey.currentState != null &&
                              _formKey.currentState!.validate();
                        });
                      },
                    ),
                  ),
                ])
              ])),
          Positioned(
              bottom: 20, // Adjust this value as needed
              left: 0,
              right: 0,
              child: Center(
                child: Continue(
                  onTap: () {
                    final storage = GetStorage();
                    print(codeControl.text.runtimeType);
                    print(storage.read('emailVerificationCode').runtimeType);
                    if (codeControl.text ==
                        storage.read('emailVerificationCode')) {
                      continueButton(context);
                    } else if (codeControl.text ==
                        storage.read('SMSVerificationCode')) {
                      continueButton(context);
                    } else {
                      showErrorHandlingSnackBar(
                          context,
                          "Verification Code is not Correct, Please Check your Email/Phone.",
                          'error');
                    }
                  },
                  isDisabled: !isCodeValid,
                ),
              ))
        ]));
  }
}

class MyCodeField extends StatelessWidget {
  const MyCodeField({
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
        obscureText: false, // Not an obscured field
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
          RegExp codePattern = RegExp(r'^\d{6}$');

          if (value == null || value.isEmpty) {
            return 'Code is required';
          } else if (!codePattern.hasMatch(value)) {
            return 'Code must contain 6 digits';
          }

          return null;
        },
        onChanged: onChanged,
      ),
    );
  }
}
