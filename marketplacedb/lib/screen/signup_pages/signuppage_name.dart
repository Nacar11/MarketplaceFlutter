import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_birthdate.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';

class SignUpPagename extends StatefulWidget {
  const SignUpPagename({Key? key}) : super(key: key);

  @override
  State<SignUpPagename> createState() => SignUpPagenameState();
}

class SignUpPagenameState extends State<SignUpPagename> {
  final firstnamecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();
  final authController = AuthenticationController();

  bool isNameEmpty = true;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the text field and update isNameEmpty accordingly.
    firstnamecontroller.addListener(() {
      setState(() {
        isNameEmpty = firstnamecontroller.text.isEmpty;
      });
    });
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
                            isNameEmpty, // Pass the isNameEmpty variable here
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
