import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_promotions.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class SignUpPagepassword extends StatefulWidget {
  const SignUpPagepassword({Key? key}) : super(key: key);

  @override
  State<SignUpPagepassword> createState() => _SignUpPageState();
}

final authController = AuthenticationController();

class _SignUpPageState extends State<SignUpPagepassword> {
  final passwordControl = TextEditingController();
  bool isNameEmpty = true;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the text field and update isNameEmpty accordingly.
    passwordControl.addListener(() {
      setState(() {
        isNameEmpty = passwordControl.text.isEmpty;
      });
    });
  }

  void continuebutton6(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpPagepromotion()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        appBar: AppBar(
          title: const Text("Sign Up"),
          backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        ),
        body: Obx(
          () => authController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    const Headertext(text: 'Get Started'),
                    const MyContainer(
                      headerText: "Please input a password.              ",
                      text: "password must be at least 8 characters.",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      controller: passwordControl,
                      hintText: 'Password',
                      labelText: 'Enter Password',
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Continue(
                                onTap: () async {
                                  if (!isNameEmpty) {
                                    authController.storeLocalData(
                                        'password', passwordControl.text);
                                    authController.test();
                                    continuebutton6(context);
                                  }
                                },
                                isDisabled:
                                    isNameEmpty, // Pass the isNameEmpty variable here
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }
}
