// ignore_for_file: use_build_context_synchronously, avoid_print, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/screen_specific/signupProcess.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_password.dart';
import 'package:marketplacedb/common/widgets/common_widgets/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class SignUpPageUsername extends StatefulWidget {
  final String? verifySnackbar;
  const SignUpPageUsername({Key? key, this.verifySnackbar}) : super(key: key);

  @override
  State<SignUpPageUsername> createState() =>
      _SignUpPageState(verifySnackbar: verifySnackbar ?? '');
}

final authController = AuthenticationController();

class _SignUpPageState extends State<SignUpPageUsername> {
  final String verifySnackbar;
  _SignUpPageState({required this.verifySnackbar});
  bool isCheckedPromotions = false;
  bool isCheckedNewsLetters = false;

  final usernameControl = TextEditingController();
  final GlobalKey<FormState> usernameKey = GlobalKey<FormState>();
  bool isUsernameValid = false;

  @override
  void initState() {
    super.initState();
  }

  void continueButton(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpPagePassword()));
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed.
    usernameControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const SignUpAppBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: ContainerGuide(
              headerText: "Please enter your username              ",
              text: "This will be your display name other users will see.",
            ),
          ),
          Column(children: [
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Form(
                  key: usernameKey,
                  child: ValidatorField(
                    controller: usernameControl,
                    hintText: 'Username',
                    labelText: 'Enter Username',
                    validator: (value) {
                      RegExp usernamePattern =
                          RegExp(r'^[a-zA-Z0-9]*\d+[a-zA-Z0-9]*$');

                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      } else if (!usernamePattern.hasMatch(value)) {
                        return 'Username must contain at least one number,\n and is unique';
                      }

                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        isUsernameValid = usernameKey.currentState != null &&
                            usernameKey.currentState!.validate();
                        print(isUsernameValid);
                      });
                    },
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Transform.scale(
                            scale: 1.6,
                            child: Checkbox(
                              shape: const CircleBorder(),
                              checkColor: Colors.white,
                              activeColor: Colors.green,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              visualDensity: VisualDensity.standard,
                              value: isCheckedPromotions,
                              onChanged: (newBool) {
                                setState(() {
                                  isCheckedPromotions = newBool!;
                                });
                              },
                            ),
                          ),
                        ),
                        const Text(
                          'Subscribe to Marketplace Promotions',
                          style: TextStyle(
                            fontSize: 16, // Adjust the font size as needed
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Transform.scale(
                            scale: 1.6,
                            child: Checkbox(
                              shape: const CircleBorder(),
                              checkColor: Colors.white,
                              activeColor: Colors.green,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              visualDensity: VisualDensity.standard,
                              value: isCheckedNewsLetters,
                              onChanged: (newBool) {
                                setState(() {
                                  isCheckedNewsLetters = newBool!;
                                });
                              },
                            ),
                          ),
                        ),
                        const Text(
                          'Subscribe to Marketplace Newsletters',
                          style: TextStyle(
                            fontSize: 16, // Adjust the font size as needed
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() => Container(
            height: 50,
            margin: const EdgeInsets.all(10),
            child: SignUpProcessContinueFAB(
              text: "Continue",
              isDisabled: !isUsernameValid,
              isLoading: authController.isLoading.value,
              onPressed: () async {
                if (isUsernameValid) {
                  var response = await authController.checkUsername(
                      username: usernameControl.text);
                  print(response);
                  if (response['message'] == 'Username is available') {
                    authController.storeLocalData(
                        'is_subscribe_to_promotions', isCheckedPromotions);
                    authController.storeLocalData(
                        'is_subscribe_to_newsletters', isCheckedNewsLetters);
                    authController.storeLocalData(
                        'username', usernameControl.text);
                    continueButton(context);
                  } else {
                    showErrorHandlingSnackBar(
                        context, response['message'], 'error');
                  }
                }
              },
            ),
          )),
    );
  }
}
