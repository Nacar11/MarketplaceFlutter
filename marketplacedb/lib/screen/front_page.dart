import 'package:flutter/material.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_name.dart';
import 'package:marketplacedb/screen/signin_page.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/config/snackbar.dart';
import 'package:flutter/services.dart';

class Frontpage extends StatefulWidget {
  final bool? logoutMessage;
  const Frontpage({Key? key, this.logoutMessage}) : super(key: key);

  @override
  State<Frontpage> createState() =>
      // ignore: no_logic_in_create_state
      FrontpageState(logoutMessage: logoutMessage ?? false);
}

class FrontpageState extends State<Frontpage> {
  final bool logoutMessage;
  FrontpageState({required this.logoutMessage});

  @override
  void initState() {
    super.initState(); // Call the superclass's initState
    // Call your custom init method here
    if (logoutMessage) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showLogoutSnackBar();
      });
    }
  }

  void showLogoutSnackBar() async {
    showSuccessSnackBar(context, "Successfully Logged Out", 'success');
  }

  void fbbutton() {}
  void signupButton(BuildContext context) {
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
    return WillPopScope(
        onWillPop: () async {
          // Handle the back button press here
          SystemNavigator
              .pop(); // This will exit the app and go to the home screen
          return false; // Return false to prevent exiting the app immediately
        },
        child: Scaffold(
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
                          LargeBlackButton(
                              text: "Sign Up",
                              isDisabled: false,
                              onPressed: () async {
                                signupButton(
                                  context,
                                );
                              }),

                          // Add any other properties or styling to the button here

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
        ));
  }
}
