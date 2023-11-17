// ignore_for_file: unused_element, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/config/snackbar.dart';

import 'package:marketplacedb/screen/signin_page.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';

void signUpbutton(BuildContext context, bool? welcomeMessage) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const Navigation(hasSnackbar: 'welcomeMessage')));
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
      body: Stack(
        children: [
          Column(children: [
            const Center(
              child: Headertext(text: 'Get Started'),
            ),
            const MyContainer(
              headerText:
                  "Would you like to subcribe to our promotions and newsletters              ",
              text: "so you can get updated",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(children: [
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
                  const Text('Subscribe to newsletters'),
                ]),
              ]),
            ),
          ]),
          Positioned(
              bottom: 20, // Adjust this value as needed
              left: 0,
              right: 0,
              child:
                  // Obx(() {
                  //   if (authController.isLoading.value) {
                  //     return Container(
                  //       decoration: BoxDecoration(
                  //         color: Colors.grey
                  //             .withOpacity(0.5), // Adjust the color and opacity
                  //         borderRadius:
                  //             BorderRadius.circular(8.0), // Adjust the border radius
                  //       ),
                  //       padding: const EdgeInsets.all(12.0),
                  //       child: const CircularProgressIndicator(),
                  //     ); // Display a circular progress indicator when isLoading is true
                  //   } else {
                  //     return LargeBlackButton(
                  //       text: "Sign Up",
                  //       fontsize: 24,
                  //       padding: const EdgeInsets.all(20),
                  //       margin: const EdgeInsets.symmetric(horizontal: 20),
                  //       onPressed: () async {
                  //         authController.storeLocalData(
                  //             'is_subscribe_to_promotions', ischeckedpromotions);
                  //         authController.storeLocalData(
                  //             'is_subscribe_to_newsletters', ischeckednewsletters);
                  //         var response = await authController.register();
                  //         if (response == 0) {
                  //           signUpbutton(context, true);
                  //         } else {
                  //           print(response);
                  //         }
                  //       },

                  //       isDisabled: authController
                  //           .isLoading.value, // Pass the isNameEmpty variable here
                  //     );
                  //   }
                  // }),

                  Obx(() {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    LargeBlackButton(
                      text: "Sign In",
                      onPressed: () async {
                        authController.storeLocalData(
                            'is_subscribe_to_promotions', ischeckedpromotions);
                        authController.storeLocalData(
                            'is_subscribe_to_newsletters',
                            ischeckednewsletters);

                        var response = await authController.register();
                        if (response == 0) {
                          print("Success");
                          signinbutton(context, true);
                        } else {
                          final text = response;
                          showErrorHandlingSnackBar(context, text, 'error');
                        }
                      },
                    ),
                    if (authController.isLoading.value)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey
                              .withOpacity(0.5), // Adjust the color and opacity
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust the border radius
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: const CircularProgressIndicator(),
                      ),
                  ],
                );
              }))
        ],
      ),
    );
  }
}
