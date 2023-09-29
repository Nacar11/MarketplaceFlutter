import 'package:flutter/material.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_name.dart';
import 'package:marketplacedb/screen/signin_page.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';

class Frontpage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Frontpage({Key? key});
  void fbbutton() {}
  void signupbutton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpPagename()));
  }

  void googlebutton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Navigation()));
  }

  void signInButton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              // Big Logo-like Text
              const Text(
                "Market Place",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32, // Adjust the font size as needed
                ),
              ),
              //logo
              //welcome
              //google
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GoogleButton(onTap: () => googlebutton(context)),
                      const SizedBox(height: 20), // Add spacing if needed
                      FBButton(onTap: fbbutton),
                      const SizedBox(height: 20),
                      SignupButton(onTap: () => signupbutton(context)),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign in",
                              style: const TextStyle(
                                color: Colors
                                    .blue, // Make "Sign in" text blue and clickable
                                decoration: TextDecoration.underline,
                                fontSize: 20,
                              ),
                              // Add onPressed function here for sign-in action
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  signInButton(context);
                                  // Handle the "Sign in" button click action here
                                  // For example, navigate to the sign-in screen
                                },
                              //signup
                              //login
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 70),
                      RichText(
                        text: TextSpan(
                          text: "By continuing you agree to our ",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          children: [
                            TextSpan(
                              text: "Terms of Service",
                              style: const TextStyle(
                                color: Colors
                                    .black, // Make "Sign in" text blue and clickable
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              // Add onPressed function here for sign-in action
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  signInButton(context);
                                  // Handle the "Sign in" button click action here
                                  // For example, navigate to the sign-in screen
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
