import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_code.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_password.dart';

class SignUpPagephone extends StatefulWidget {
  const SignUpPagephone({Key? key}) : super(key: key);

  @override
  State<SignUpPagephone> createState() => _SignUpPageState();
}

final authController = AuthenticationController();

class _SignUpPageState extends State<SignUpPagephone> {
  final textcontrol = TextEditingController();

  bool isNameEmpty = true;

  // Define a list of country codes
  List<String> countryCodes = ['+63']; // Add more codes as needed
  String selectedCountryCode = '+63'; // Set a default value

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

  void continuebutton3(BuildContext context) {
    final storage = GetStorage();
    if (storage.read('signInMethod')) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SignUpPagePassword()));
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SignUpPagecode()));
    }
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
      body: ListView(children: [
        Column(
          children: [
            const Center(
              child: Headertext(text: 'Get Started'),
            ),
            const MyContainer(
              headerText: "What is your phone number?              ",
              text: "A verification will be sent to your number",
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                // Dropdown for country codes
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: selectedCountryCode,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCountryCode = newValue!;
                      });
                    },
                    items: countryCodes.map((String code) {
                      return DropdownMenuItem<String>(
                        value: code,
                        child: Text(code),
                      );
                    }).toList(),
                  ),
                ),
                // Phone number text field
                Expanded(
                  child: MyTextField(
                    controller: textcontrol,
                    hintText: 'Phone Number',
                    labelText: 'Enter your Phone Number',
                    obscureText: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 360),
            Stack(children: [
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
                            authController.storeLocalData(
                                'contact_number', textcontrol.text);
                            continuebutton3(context);
                          }
                        },
                        isDisabled: isNameEmpty,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ]),
    );
  }
}
