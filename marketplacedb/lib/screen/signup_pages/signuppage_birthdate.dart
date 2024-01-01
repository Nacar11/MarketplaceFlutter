// ignore_for_file: use_build_context_synchronously, avoid_print, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/screen_specific/signupProcess.dart';
import 'package:flutter/cupertino.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:intl/intl.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_username.dart';

class SignUpPageBirthDate extends StatefulWidget {
  const SignUpPageBirthDate({Key? key}) : super(key: key);

  @override
  State<SignUpPageBirthDate> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPageBirthDate> {
  final authController = AuthenticationController();
  final dateOfBirthController = TextEditingController();
  DateTime? pickedDate;
  String _valueGender = "";
  DateTime selectedDate = DateTime(2023, 9, 22, 12, 21);
  bool isDateSelected = false;
  showDatePickerC(
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
    isDateSelected = selectedDate != DateTime(2023, 9, 22, 12, 21);
    dateOfBirthController.addListener(() {
      setState(() {});
    });
  }

  void continueButton(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignUpPageUsername()));
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed.
    dateOfBirthController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const SignUpAppBar(),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: ContainerGuide(
            headerText: "Please provide your Gender and Date of Birth",
            text:
                "To better tailor user experience, personalization, and verify compliance with legal age requirements",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: Row(
              children: [
                const Text("Select Gender"),
                Radio(
                  value: "Male",
                  groupValue: _valueGender,
                  onChanged: (value) {
                    setState(() {
                      _valueGender = value!;
                    });
                  },
                ),
                const Text("Male"),
                Radio(
                  value: "Female",
                  groupValue: _valueGender,
                  onChanged: (value) {
                    setState(() {
                      _valueGender = value!;
                    });
                  },
                ),
                const Text("Female"),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            readOnly: true, // Disable text input
            controller: dateOfBirthController,
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today_rounded),
              labelText: "Date of Birth",
            ),
            onTap: () async {
              final currentDate = DateTime.now();
              pickedDate = await showDatePicker(
                context: context,
                initialDate: currentDate,
                firstDate: DateTime(1960),
                lastDate: DateTime(2101),
              );

              if (pickedDate != null) {
                if (pickedDate!.day != null) {
                  dateOfBirthController.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate!);
                  setState(() {
                    isDateSelected = true;
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Please pick a date"),
                        content: const Text("Please select a day as well"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
                int age = currentDate.year - pickedDate!.year;

                if (currentDate.month < pickedDate!.month ||
                    (currentDate.month == pickedDate!.month &&
                        currentDate.day < pickedDate!.day)) {
                  age--;
                }

                if (age >= 13) {
                  setState(() {
                    isDateSelected = true;
                  });
                } else {
                  setState(() {
                    isDateSelected = false;
                  });
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Invalid Date of Birth"),
                        content: const Text(
                            "You must be at least 13 years old to use this app."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            },
          ),
        )
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: SignUpProcessContinueFAB(
          text: "Continue",
          isDisabled: !isDateSelected || _valueGender.isEmpty,
          onPressed: () {
            print(isDateSelected);
            print(_valueGender);
            if (isDateSelected && _valueGender != '') {
              print("Ssdasdasdasdasdsda");

              authController.storeLocalData(
                  'date_of_birth', dateOfBirthController.text);
              authController.storeLocalData('gender', _valueGender);
              continueButton(context);
            }
          },
        ),
      ),
    );
  }
}
