// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/CustomAppBar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_name.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_username.dart';

class SignUpPageCode extends StatefulWidget {
  const SignUpPageCode({Key? key}) : super(key: key);

  @override
  State<SignUpPageCode> createState() => SignUpPageCodeState();
}

class SignUpPageCodeState extends State<SignUpPageCode> {
  final codeController = TextEditingController();
  List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  bool isCodeValid = true;

  void continueButton(BuildContext context) {
    // if (_formKey.currentState != null && _formKey.currentState!.validate()) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SignUpPageName(socialLogin: true)));
    // }
  }

  // @override
  // void dispose() {
  //   codeController.dispose();
  //   super.dispose();
  // }

  void clearAllControllers() {
    for (var controller in otpControllers) {
      controller.clear();
    }
  }

  String getOtpCode() {
    String otpCode = '';
    for (var controller in otpControllers) {
      otpCode += controller.text;
    }
    return otpCode;
  }

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    String contactNumber = storage.read('contact_number') ?? 'Unknown Number';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const SignUpAppBar(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: ContainerGuide(
            headerText: "Verification Code",
            richText: RichText(
              text: TextSpan(
                text: 'We have sent a 6-digit code verification to ',
                style: const TextStyle(
                  color: Color.fromARGB(255, 112, 112, 112),
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: contactNumber,
                    style: const TextStyle(
                      color: Colors.black, // Change color if desired
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => SizedBox(
                  height: 68,
                  width: 30,
                  child: TextFormField(
                    controller: otpControllers[index],
                    onChanged: (value) {
                      print(contactNumber);
                      if (value.length == 1 && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }

                      print(getOtpCode());
                    },
                    style: Theme.of(context).textTheme.titleLarge,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                  height:
                      20), // Add spacing between RichText widgets and TextFormFields

              // RichText widget - "Didn't Receive anything? Resend Code"
              InkWell(
                onTap: () async {
                  final code = await authController
                      .getSMSVerificationCode(contactNumber);
                  if (code['success'] != null) {
                    String successValue = code['success'].toString();

                    final storage = GetStorage();
                    storage.write('SMSVerificationCode', successValue);
                  } else {
                    showErrorHandlingSnackBar(
                        context,
                        "Error on Passing SMS Text Verification Code, Please Try Again.",
                        'error');
                  }
                },
                child: RichText(
                  text: const TextSpan(
                    text: "Didn't Receive anything? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Resend Code",
                        style: TextStyle(
                          color: Colors.blue, // Change color if desired
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                  height: 10), // Add spacing between RichText widgets

              // RichText widget - "Still Having Issues? Try a Different Number"
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: RichText(
                  text: const TextSpan(
                    text: "Still Having Issues? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Try a Different Number",
                        style: TextStyle(
                          color: Colors.blue, // Change color if desired
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: SignUpProcessContinueFAB(
          text: "Continue",
          isLoading: authController.isLoading.value,
          isDisabled: !isCodeValid,
          onPressed: () async {
            final storage = GetStorage();
            print(getOtpCode().runtimeType);
            print(storage.read('emailVerificationCode').runtimeType);
            if (getOtpCode() == storage.read('SMSVerificationCode')) {
              continueButton(context);
              clearAllControllers();
            } else {
              showErrorHandlingSnackBar(
                  context,
                  "Verification Code is not Correct, Please try again.",
                  'error');
            }
          },
        ),
      ),
    );
  }
}
