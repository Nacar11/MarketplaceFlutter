// ignore_for_file: unused_element, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signin_page.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/config/textfields.dart';

void continuebutton7(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const Navigation()));
}

class SignUpPagepromotion extends StatefulWidget {
  const SignUpPagepromotion({Key? key}) : super(key: key);

  @override
  State<SignUpPagepromotion> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPagepromotion> {
  bool ischeckedpromotions = false;
  bool ischeckednewsletters = false;
  bool isNameEmpty = true;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the text field and update isNameEmpty accordingly.

    @override
    void dispose() {
      // Dispose the controller when the widget is removed.
      super.dispose();
    }
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
            headerText:
                "Would you like to subcribe to our promotions and newsletters              ",
            text: "so you can get updated",
          ),
          const SizedBox(
            height: 20,
          ),
          Column(children: [
            Row(children: [
              Checkbox(
                  value: ischeckedpromotions,
                  onChanged: (newBool) {
                    setState(() {
                      ischeckedpromotions = newBool!;
                    });
                  }),
              const Text('Subscribe to promotions'),
            ]),
            Row(children: [
              Checkbox(
                  value: ischeckednewsletters,
                  onChanged: (newBool) {
                    setState(() {
                      ischeckednewsletters = newBool!;
                    });
                  }),
              const Text('Subscribe to promotions'),
            ]),
          ]),
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
                        authController.storeLocalBoolData(
                            'is_subscribe_to_promotion', ischeckedpromotions);
                        authController.storeLocalBoolData(
                            'is_subscribe_to_newsletter', ischeckednewsletters);
                        var response = await authController.register();
                        if (response == 0) {
                          continuebutton7(context);
                        } else {
                          print(response);
                        }
                      },

                      isDisabled: false, // Pass the isNameEmpty variable here
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
