import 'package:flutter/material.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_phone.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:intl/intl.dart';

class SignUpPagebirthdate extends StatefulWidget {
  const SignUpPagebirthdate({Key? key}) : super(key: key);

  @override
  State<SignUpPagebirthdate> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPagebirthdate> {
  final authController = AuthenticationController();
  final textcontrol = TextEditingController();
  DateTime selectedDate = DateTime(2023, 9, 22, 12, 21);
  bool isDateSelected =
      true; // Store whether a date is selected // Store the selected date

  showDatePicker(
      {required DateTime initialDate,
      required BuildContext context,
      required DateTime firstDate,
      required DateTime lastDate}) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => SizedBox(
        height: 250,
        child: CupertinoDatePicker(
          backgroundColor: Colors.white,
          initialDateTime: selectedDate,
          onDateTimeChanged: (DateTime newTime) {
            setState(() => selectedDate = newTime);
          },
          use24hFormat: true,
          mode: CupertinoDatePickerMode.date,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Listen for changes in the text field and update the button's state.
    textcontrol.addListener(() {
      setState(() {});
    });
  }

  void continuebutton2(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpPagephone()));
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
            headerText: "What's your Date of Birth?              ",
            text: "this will not be shown without your permission",
          ),
          const SizedBox(
            height: 20,
          ),
          Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  const Text(
                    "Date of birth",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "${selectedDate.toLocal().toLocal()}"
                                  .split(' ')[0],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ],
              );
            },
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
                        if (isDateSelected) {
                          final formattedDate =
                              DateFormat('yyyy-MM-dd').format(selectedDate);
                          authController.storeLocalData(
                              'date_of_birth', formattedDate);
                          authController.test();
                          continuebutton2(context);
                        }
                      },
                      isDisabled:
                          !isDateSelected, // Disable if no date selected
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
