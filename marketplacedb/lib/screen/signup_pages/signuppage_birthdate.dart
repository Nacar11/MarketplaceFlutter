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
      body: ListView(children: [
        Column(
          children: [
            const Center(
              child: Headertext(text: 'Get Started'),
            ),
            const MyContainer(
              headerText: "What's your Date of Birth?              ",
              text: "this will not be shown without your permission",
            ),
            const SizedBox(
              height: 20,
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
                  controller: textcontrol,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today_rounded),
                      labelText: "Date of Birth"),
                  onTap: () async {
                    pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1960),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      textcontrol.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate!);
                      setState(() {
                        isDateSelected = true;
                      });
                    }
                  }),
            ),
            const SizedBox(height: 190),
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
                            if (isDateSelected && _valueGender.isNotEmpty) {
                              final formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate!);
                              authController.storeLocalData(
                                  'date_of_birth', formattedDate);
                              authController.storeLocalData(
                                  'gender', _valueGender);

                              continuebutton2(context);
                            }
                          },
                          isDisabled: !isDateSelected || _valueGender.isEmpty),
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
