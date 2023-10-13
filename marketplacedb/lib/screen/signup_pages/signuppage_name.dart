import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:get/get.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/config/snackbar.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_birthdate.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class SignUpPagename extends StatefulWidget {
  final bool? socialLogin;

  const SignUpPagename({Key? key, this.socialLogin}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<SignUpPagename> createState() =>
      // ignore: no_logic_in_create_state
      SignUpPagenameState(socialLogin: socialLogin ?? false);
}

class SignUpPagenameState extends State<SignUpPagename> {
  final bool socialLogin;
  SignUpPagenameState({required this.socialLogin});
  final firstnamecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();
  final authController = AuthenticationController();

  bool isNameEmpty = true;

  @override
  void initState() {
    super.initState();
    if (socialLogin) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showWelcomeMessageSnackBar();
      });
    }
  }

  void showWelcomeMessageSnackBar() {
    final storage = GetStorage();
    String text =
        'Welcome, ${storage.read('email')}. Sign in with just a couple more steps!';
    socialLoginSignUp(context, text, 'loginsuccess');
  }

  void continuebutton(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpPagebirthdate()));
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed.
    firstnamecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      ),
      body: ListView(
        children: [
          const Center(
            child: Headertext(text: 'Get Started'),
          ),
          const MyContainer(
            headerText: "Hello, tell us about yourself              ",
            text: "so we can personalize your account",
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: firstnamecontroller,
            hintText: 'First name',
            labelText: 'Enter your First name',
            obscureText: false,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: lastnamecontroller,
            hintText: 'Last name',
            labelText: 'Enter your Last name',
            obscureText: false,
          ),
          const SizedBox(height: 270),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Continue(
                        onTap: () {
                          if (!isNameEmpty) {
                            authController.test();
                            authController.storeLocalData(
                                'first_name', firstnamecontroller.text);
                            authController.storeLocalData(
                                'last_name', lastnamecontroller.text);
                            authController.test();
                            continuebutton(context);
                          }
                        },
                        isDisabled:
                            !isNameEmpty, // Pass the isNameEmpty variable here
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
