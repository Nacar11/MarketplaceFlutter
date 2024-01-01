// ignore_for_file: avoid_print, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/textfields.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/screen/ForgotPass/FPChooseCode.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

final authController = AuthenticationController();

void signinbutton(BuildContext context) {
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const FPChoosecode()));
}

class _ForgotPassPageState extends State<ForgotPassPage> {
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
        title: const Text("Forgot Password"),
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
              "Please Enter Your Email",
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
          Stack(
            alignment: Alignment.center,
            children: [
              LargeWhiteButton(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                text: "Submit",
                onPressed: () async {
                  var response = await authController.getUser(
                    email: emailcontrol.text.trim(),
                  );

                  if (response == 0) {
                    print("Success");
                    signinbutton(context);
                  } else {
                    final text = response;
                    showErrorHandlingSnackBar(
                        context, text, 'error no email found');
                  }
                },

                // Add any other properties or styling to the button here
              ),
              if (authController.isLoading.value)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey
                        .withOpacity(0.5), // Adjust the color and opacity
                    borderRadius:
                        BorderRadius.circular(8.0), // Adjust the border radius
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: const CircularProgressIndicator(),
                ),
            ],
          )
        ],
      ),
    );
  }
}
