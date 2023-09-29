import 'package:flutter/material.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_password.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class SignUpPageusername extends StatefulWidget {
  const SignUpPageusername({Key? key}) : super(key: key);

  @override
  State<SignUpPageusername> createState() => _SignUpPageState();
}

final authController = AuthenticationController();

class _SignUpPageState extends State<SignUpPageusername> {
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

  void continuebutton6(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpPagepassword()));
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
            headerText: "Please enter a username.              ",
            text: "this will be the primary name other users will see",
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: textcontrol,
            hintText: 'Username',
            labelText: 'Enter your Username',
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
                          authController.storeLocalData(
                              'username', textcontrol.text);
                          authController.test();
                          continuebutton6(context);
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
