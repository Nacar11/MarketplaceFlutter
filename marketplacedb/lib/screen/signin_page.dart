// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/ForgotPass/ForgotPass.dart';
import 'package:marketplacedb/screen/front_page.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/config/snackbar.dart';

class SignInPage extends StatefulWidget {
  final String? hasSnackbar;
  const SignInPage({Key? key, this.hasSnackbar}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<SignInPage> createState() =>
      // ignore: no_logic_in_create_state
      _SignInPageState(hasSnackbar: hasSnackbar ?? '');
}

final authController = AuthenticationController();
String changePassMessage = '';
void backbutton(BuildContext context) {
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Frontpage()));
}

void signinbutton(BuildContext context, bool? welcomeMessage) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const Navigation(hasSnackbar: 'welcomeMessage')));
}

void forgotpassbutton(BuildContext context) {
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const ForgotPassPage()));
}

class _SignInPageState extends State<SignInPage> {
  final String? hasSnackbar;
  final emailcontrol = TextEditingController();
  final passwordcontrol = TextEditingController();
  _SignInPageState({required this.hasSnackbar});

  @override
  void dispose() {
    // Dispose of the controller when no longer needed to prevent memory leaks.
    emailcontrol.dispose();
    passwordcontrol.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (hasSnackbar != '') {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        switch (hasSnackbar) {
          case 'changePassSuccess':
            showChangePassSuccessSnackBar();
            break;

          default:
        }
      });
    }
  }

  void showChangePassSuccessSnackBar() {
    String text = 'Password Changed Successfully';
    showSuccessSnackBar(context, text, 'success');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backbutton(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              backbutton(
                  context); // Navigates back to the previous screen (e.g., HomePage)
            },
            child: Icon(Icons.arrow_back),
          ),
          title: const Text("Sign In"),
          backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        ),
        body: Column(
          children: [
            const Text(
              "UKAYKO.PH  ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                "Hi we've missed you, welcome back",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: MyTextField(
                controller: emailcontrol,
                hintText: 'Email',
                labelText: 'Enter your Email',
                obscureText: false,
              ),
            ),
            MyTextField(
              controller: passwordcontrol,
              hintText: 'Password',
              labelText: 'Enter your Password',
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          forgotpassbutton(context);
                        },
                        child: const Text("Forgot Password?")),
                  ],
                ),
              ),
            ),
            Obx(() {
              return Stack(
                alignment: Alignment.center,
                children: [
                  LargeBlackButton(
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
                      child: const CircularProgressIndicator(),
                    ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
