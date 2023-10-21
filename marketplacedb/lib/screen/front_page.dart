// ignore_for_file: use_build_context_synchronously, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:marketplacedb/constants/constant.dart';
import 'package:marketplacedb/networks/googleSignIn.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_name.dart';
import 'package:marketplacedb/screen/signin_page.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/config/snackbar.dart';
import 'package:flutter/services.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:http/http.dart' as http;

final authController = AuthenticationController();

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
    super.initState();
    if (logoutMessage) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showLogoutSnackBar();
      });
    }
  }

  void showLogoutSnackBar() async {
    showSuccessSnackBar(context, "Successfully Logged Out", 'success');
  }

  void fbbutton() async {
    await FacebookAuth.instance.login(permissions: ['public_profile', 'email']);
    await GoogleSignAPI.logout();

    // print('asdasdaaaaaa');
    // final response = await http.get(
    //   Uri.parse('https://192.168.254.102:8080/api/test'),
    // );
    // print(response.body);
  }

  void signupButton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpPagename()));
  }

  Future googlebutton(BuildContext context) async {
    // await GoogleSignAPI.logout();
    final userData = await GoogleSignAPI.login();

    final response = await authController.loginGoogle(userData?.email);
    // print(response);
    if (response == 0) {
      await GoogleSignAPI.logout();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SignUpPagename(socialLogin: true)));
    } else if (response == 1) {
      await GoogleSignAPI.logout();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              const Navigation(hasSnackbar: 'welcomeMessage')));
    } else {
      await GoogleSignAPI.logout();
      showErrorHandlingSnackBar(context, 'Error Logging In', 'error');
    }
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
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Image(
                          image: AssetImage('flutter_images/UkaykoLogo.png')),
                    ),
                  ),

                  //welcome
                  //google
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GoogleButton(onTap: () => googlebutton(context)),
                          // Add spacing if needed
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: ElevatedButton(
                                onPressed: () {
                                  fbbutton();
                                },
                                child: const Text('asd')),
                          ),

                          LargeBlackButton(
                              padding: const EdgeInsets.all(20),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              fontsize: 20,
                              text: "Sign Up",
                              isDisabled: false,
                              onPressed: () async {
                                signupButton(
                                  context,
                                );
                              }),

                          // Add any other properties or styling to the button here

                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: RichText(
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
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 70, bottom: 20),
                            child: RichText(
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
                          ),
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
