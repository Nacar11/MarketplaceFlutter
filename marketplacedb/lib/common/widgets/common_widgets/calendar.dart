import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  DateTime datetime = DateTime(2023, 9, 22, 12, 21);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: CupertinoButton(
        child: const Text('Cupertino Date picker'),
        onPressed: () {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => SizedBox(
              height: 250,
              child: CupertinoDatePicker(
                backgroundColor: Colors.white,
                initialDateTime: datetime,
                onDateTimeChanged: (DateTime newTime) {
                  setState(() => datetime = newTime);
                },
                use24hFormat: true,
                mode: CupertinoDatePickerMode.date,
              ),
            ),
          );
        },
      ),
    ));
  }
}
