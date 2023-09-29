import 'package:flutter/material.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_email.dart';
import 'package:marketplacedb/config/textfields.dart';

class SignUpPagecode extends StatefulWidget {
  const SignUpPagecode({Key? key}) : super(key: key);

  @override
  State<SignUpPagecode> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPagecode> {
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

  void continuebutton4(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpPageemail()));
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
          const Headertext(text: 'Get Started'),
          const MyContainer(
            headerText: "Enter the code              ",
            text: "We've sent a 6 digit code to your number",
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: textcontrol,
            hintText: 'Code',
            labelText: 'Enter your code',
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
                      onTap: () {
                        if (!isNameEmpty) {
                          continuebutton4(context);
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
