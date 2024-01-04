import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/CustomAppBar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class SignUpPagePassword extends StatefulWidget {
  const SignUpPagePassword({Key? key}) : super(key: key);

  @override
  State<SignUpPagePassword> createState() => _SignUpPagePasswordState();
}

final authController = AuthenticationController();

class _SignUpPagePasswordState extends State<SignUpPagePassword> {
  final passwordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();
  bool isPasswordValid = false;
  bool isPasswordEightCharacters = false;
  bool isPasswordOneNumber = false;
  bool isPasswordOneSpecialChar = false;
  bool passwordsMatch = false;
  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> reEnterPasswordKey = GlobalKey<FormState>();

  void continueButton(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Navigation(hasSnackbar: 'welcomeMessage')));
  }

  void onPasswordChange(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    setState(() {
      isPasswordEightCharacters = false;
      if (password.length >= 8) {
        isPasswordEightCharacters = true;
      }
      isPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) {
        isPasswordOneNumber = true;
      }
      isPasswordOneSpecialChar = false;
      if (specialCharRegex.hasMatch(password)) {
        isPasswordOneSpecialChar = true;
      }

      isPasswordValid = isPasswordEightCharacters &&
          isPasswordOneNumber &&
          isPasswordOneSpecialChar &&
          passwordsMatch;

      print("password eight characters:");
      print(isPasswordEightCharacters);
      print("password one number:");
      print(isPasswordOneNumber);
      print("password one special:");
      print(isPasswordOneSpecialChar);
      print("password match:");
      print(passwordsMatch);
      print("password validdddd:");
      print(isPasswordValid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: const SignUpAppBar(),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: ContainerGuide(
              headerText: "Set a password",
              text:
                  "Please create a secure password which includes the following criteria below.",
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Form(
                key: passwordKey,
                child: PasswordValidatorField(
                  controller: passwordController,
                  labelText: 'Enter Password',
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      passwordsMatch = value == reEnterPasswordController.text;
                    });
                    onPasswordChange(value);
                    print(value);
                  },
                ),
              )),
          const SizedBox(height: 5),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Form(
                key: reEnterPasswordKey,
                child: PasswordValidatorField(
                  controller: reEnterPasswordController,
                  labelText: 'Re-enter Password',
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      passwordsMatch = value == passwordController.text;
                    });
                    onPasswordChange(value);
                    print(value);
                  },
                ),
              )),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: isPasswordEightCharacters
                            ? Colors.green
                            : Colors.transparent,
                        border: isPasswordEightCharacters
                            ? Border.all(color: Colors.transparent)
                            : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Center(
                        child:
                            Icon(Icons.check, color: Colors.white, size: 15))),
                const SizedBox(width: 10),
                const Text("Contains at least 8 characters"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: isPasswordOneNumber
                            ? Colors.green
                            : Colors.transparent,
                        border: isPasswordOneNumber
                            ? Border.all(color: Colors.transparent)
                            : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Center(
                        child:
                            Icon(Icons.check, color: Colors.white, size: 15))),
                const SizedBox(width: 10),
                const Text("Contains at least 1 Number"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: isPasswordOneSpecialChar
                            ? Colors.green
                            : Colors.transparent,
                        border: isPasswordOneSpecialChar
                            ? Border.all(color: Colors.transparent)
                            : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Center(
                        child:
                            Icon(Icons.check, color: Colors.white, size: 15))),
                const SizedBox(width: 10),
                const Text("Contains at least 1 Special Character"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color:
                            passwordsMatch ? Colors.green : Colors.transparent,
                        border: passwordsMatch
                            ? Border.all(color: Colors.transparent)
                            : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Center(
                        child:
                            Icon(Icons.check, color: Colors.white, size: 15))),
                const SizedBox(width: 10),
                const Text("Passwords Match"),
              ],
            ),
          ),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(
          () => Container(
            height: 50,
            margin: const EdgeInsets.all(10),
            child: MPPrimaryButton(
              text: "Create Account",
              isLoading: authController.isLoading.value,
              isDisabled: !isPasswordValid,
              onPressed: () async {
                await authController.storeLocalData(
                    'password', passwordController.text);
                var response = await authController.register();
                if (response == 0) {
                  // print("Success");
                  continueButton(context);
                } else {
                  final text = response;
                  showErrorHandlingSnackBar(context, text, 'error');
                }
              },
            ),
          ),
        ));
  }
}
