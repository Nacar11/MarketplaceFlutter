import 'package:flutter/material.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_username.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/config/snackbar.dart';

class SignUpPageemail extends StatefulWidget {
  const SignUpPageemail({Key? key}) : super(key: key);

  @override
  State<SignUpPageemail> createState() => _SignUpPageState();
}

final authController = AuthenticationController();

class _SignUpPageState extends State<SignUpPageemail> {
  final textcontrol = TextEditingController();
  bool isNameEmpty = true;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the text field and update isNameEmpty accordingly.
    textcontrol.addListener(() {
      setState(() {
        isNameEmpty = textcontrol.text.isEmpty;
      });
    });
  }

  void continuebutton5(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpPageusername()));
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed.
    textcontrol.dispose();
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
          const MyContainer(
            headerText: "What is your email?              ",
            text: "notifications and transactions will be sent to your email",
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: textcontrol,
            hintText: 'E-mail',
            labelText: 'Enter your E-mail',
            obscureText: false,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Continue(
                      onTap: () async {
                        if (!isNameEmpty) {
                          var response = await authController.checkEmail(
                              email: textcontrol.text);

                          if (response['message'] == null) {
                            authController.storeLocalData(
                                'email', textcontrol.text);
                            continuebutton5(context);
                          } else {
                            final text = response['message'];
                            showErrorHandlingSnackBar(context, text, 'error');
                          }
                        }
                      },
                      isDisabled:
                          isNameEmpty, // Pass the isNameEmpty variable here
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
