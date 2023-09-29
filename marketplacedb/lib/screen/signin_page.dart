// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

final authController = AuthenticationController();

void signinbutton(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const Navigation()));
}

class _SignInPageState extends State<SignInPage> {
  final emailcontrol = TextEditingController();
  final passwordcontrol = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controller when no longer needed to prevent memory leaks.
    emailcontrol.dispose();
    passwordcontrol.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        appBar: AppBar(
          title: const Text("Sign In"),
          backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        ),
        body: Obx(
          () => authController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    const Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Hi we've missed you, welcome back",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      controller: emailcontrol,
                      hintText: 'Email',
                      labelText: 'Enter your Email',
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      controller: passwordcontrol,
                      hintText: 'Password',
                      labelText: 'Enter your Password',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Forgot Password?"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          SigninButton(
                            onPressed: () async {
                              if (authController.isLoading.value) {
                                return; // Prevent further actions while loading
                              }
                              // authController.test();
                              // signinbutton(context);
                              var response = await authController.login(
                                email: emailcontrol.text.trim(),
                                password: passwordcontrol.text.trim(),
                              );

                              if (response == 0) {
                                print("Success");
                                signinbutton(context);
                              } else {
                                final text = response;
                                final snackbar = SnackBar(
                                  duration: const Duration(days: 365),
                                  content: Text(text),
                                  action: SnackBarAction(
                                    label: 'Dismiss',
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              }
                            },
                          ),
                          if (authController.isLoading.value)
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      );
                    })
                  ],
                ),
        ));
  }
}
