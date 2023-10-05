// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/config/snackbar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

final authController = AuthenticationController();

void signinbutton(BuildContext context, bool? welcomeMessage) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Navigation(welcomeMessage: welcomeMessage)));
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
      body: Column(
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
                  text: "Sign In",
                  isDisabled: authController.isLoading.value,
                  onPressed: () async {
                    if (authController.isLoading.value) {
                      return; // Prevent further actions while loading
                    }

                    var response = await authController.login(
                      email: emailcontrol.text.trim(),
                      password: passwordcontrol.text.trim(),
                    );

                    if (response == 0) {
                      print("Success");
                      signinbutton(context, true);
                    } else {
                      final text = response;
                      showErrorHandlingSnackBar(context, text, 'error');
                    }
                  },

                  // Add any other properties or styling to the button here
                ),
                if (authController.isLoading.value)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey
                          .withOpacity(0.5), // Adjust the color and opacity
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the border radius
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          })
        ],
      ),
    );
  }
}
